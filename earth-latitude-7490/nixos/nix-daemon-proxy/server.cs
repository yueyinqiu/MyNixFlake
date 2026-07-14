#:sdk Microsoft.NET.Sdk.Web

using System.Diagnostics;

var sockPath = "/run/nix-daemon-proxy.sock";

var builder = WebApplication.CreateBuilder();
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenUnixSocket(sockPath);
});

var app = builder.Build();

app.MapPost("/set-proxy", async context =>
{
    using var reader = new StreamReader(context.Request.Body);
    var proxyVal = (await reader.ReadToEndAsync()).Trim();
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

    Process.Start(new ProcessStartInfo("systemctl", "daemon-reload") { RedirectStandardOutput = true })?.WaitForExit();
    Process.Start(new ProcessStartInfo("systemctl", "restart nix-daemon --no-block") { RedirectStandardOutput = true });

    context.Response.StatusCode = 200;
    await context.Response.WriteAsync("Proxy updated successfully.\n");
});

app.Lifetime.ApplicationStarted.Register(() =>
{
    if (File.Exists(sockPath))
    {
        File.SetUnixFileMode(sockPath, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.GroupRead | UnixFileMode.GroupWrite);
        Process.Start(new ProcessStartInfo("chown", $"root:nix-daemon-proxy {sockPath}"))?.WaitForExit();
    }
});

if (File.Exists(sockPath))
{
    File.Delete(sockPath);
}
app.Run();