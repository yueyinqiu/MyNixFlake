from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "github.com":
        flow.request.url = f"https://gh-proxy.org/{flow.request.url}"
        flow.request.headers["Host"] = "gh-proxy.org"
        flow.request.headers["Origin"] = "https://gh-proxy.org"
