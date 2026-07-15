#:sdk Microsoft.NET.Sdk.Web
#:package YueYinqiu.Su.DotnetRunFileUtilities@0.0.3

using System.Diagnostics;
using System.Runtime.InteropServices;
using CliWrap;
using CliWrap.Buffered;
using Microsoft.AspNetCore.Mvc;

Console.WriteLine($"Started.");

var socket = "/run/nix-daemon-proxy.sock";
var overrideConf = new FileInfo("/run/systemd/system/nix-daemon.service.d/override.conf");

var builder = WebApplication.CreateBuilder();
builder.WebHost.ConfigureKestrel(options =>
{
    options.ListenUnixSocket(socket);
});

var app = builder.Build();

app.MapPost("/", async ([FromQuery] string proxy = "") =>
{
    await File.WriteAllTextAsync(overrideConf.FullName,
        $"""
        [Service]
        Environment="all_proxy={proxy}"
        """
    );
    await Cli.Wrap("systemctl").WithArguments(["daemon-reload"]).ExecuteBufferedAsync();
    await Cli.Wrap("systemctl").WithArguments(["restart", "nix-daemon"]).ExecuteBufferedAsync();
});

app.Lifetime.ApplicationStarted.Register(async () =>
{
    Debug.Assert(RuntimeInformation.IsOSPlatform(OSPlatform.Linux));
    File.SetUnixFileMode(socket, UnixFileMode.UserRead | UnixFileMode.UserWrite | UnixFileMode.GroupRead | UnixFileMode.GroupWrite);
    await Cli.Wrap("chown").WithArguments(["root:nix-daemon-proxy", socket]).ExecuteBufferedAsync();
});

overrideConf.Directory?.Create();
if (File.Exists(socket))
    File.Delete(socket);

Console.WriteLine($"Before Run.");

app.Run();