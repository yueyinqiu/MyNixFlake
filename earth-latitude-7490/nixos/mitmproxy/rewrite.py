from mitmproxy import http


def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "github.com":
        flow.request.host = "gh-proxy.com"
        flow.request.path = "/https://github.com" + flow.request.path
