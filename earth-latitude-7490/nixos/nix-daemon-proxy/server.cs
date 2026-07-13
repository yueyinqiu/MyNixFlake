using System.Diagnostics;
using System.IO;
using System.Net.Sockets;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;

var sockPath = "/run/nix-daemon-proxy.sock";

// 如果残留了旧的套接字文件，先把它清理掉
if (File.Exists(sockPath))
{
    File.Delete(sockPath);
}

var builder = WebApplication.CreateBuilder();

// 告诉 Kestrel 引擎：不要监听 TCP 端口，直接绑定到 Unix Domain Socket 文件上
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenUnixSocket(sockPath);
});

var app = builder.Build();

// 核心路由：接收 POST 请求更新代理
app.MapPost("/set-proxy", async (HttpContext context) =>
{
    using var reader = new StreamReader(context.Request.Body);
    var proxyVal = (await reader.ReadToEndAsync()).Trim();

    Console.WriteLine($"Received proxy update request: '{proxyVal}'");

    try
    {
        var confDir = "/run/systemd/system/nix-daemon.service.d";
        Directory.CreateDirectory(confDir);

        var confPath = Path.Combine(confDir, "override.conf");
        using (var writer = new StreamWriter(confPath, false))
        {
            writer.WriteLine("[Service]");
            if (string.Equals(proxyVal, "none", StringComparison.OrdinalIgnoreCase) || string.IsNullOrEmpty(proxyVal))
            {
                writer.WriteLine("Environment=");
            }
            else
            {
                writer.WriteLine($"Environment=\"all_proxy={proxyVal}\" \"http_proxy={proxyVal}\" \"https_proxy={proxyVal}\"");
            }
        }

        // 顶着守护进程的 Root 权限刷新并异步重启 nix-daemon
        Process.Start(new ProcessStartInfo("systemctl", "daemon-reload") { RedirectStandardOutput = true })?.WaitForExit();
        Process.Start(new ProcessStartInfo("systemctl", "restart nix-daemon --no-block") { RedirectStandardOutput = true });

        context.Response.StatusCode = 200;
        await context.Response.WriteAsync("Proxy updated successfully.\n");
    }
    catch (Exception e)
    {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsync($"Internal Error: {e.Message}\n");
    }
});

// 在 C# 异步服务启动后，立刻修改刚生成的 Socket 文件权限
app.Lifetime.ApplicationStarted.Register(() =>
{
    if (File.Exists(sockPath))
    {
        // 1. 设置 0660 权限（所有者与所属组可读写）
        File.SetUnixFileMode(sockPath, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.GroupRead | UnixFileMode.GroupWrite);
        
        // 2. 将文件的所属组变更为 nix-daemon-proxy
        Process.Start(new ProcessStartInfo("chown", $"root:nix-daemon-proxy {sockPath}") { RedirectStandardOutput = true })?.WaitForExit();
        Console.WriteLine("Unix Socket permissions configured successfully.");
    }
});

app.Run();