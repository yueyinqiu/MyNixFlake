from mitmproxy import http

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "github.com":
        flow.request.url = f"https://gh-proxy.org/{flow.request.url}"
        flow.request.headers["Host"] = "gh-proxy.org"
        if flow.request.method not in ("GET", "HEAD"):
            flow.request.headers["Origin"] = "https://gh-proxy.org"

def response(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "github.com" and flow.response:
        flow.response.stream = lambda chunk: chunk
