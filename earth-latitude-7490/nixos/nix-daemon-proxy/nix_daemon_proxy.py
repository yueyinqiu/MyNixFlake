from mitmproxy import http
import logging

log = logging.getLogger(__name__)

def request(flow: http.HTTPFlow) -> None:
    if flow.request.pretty_host == "github.com":
        original = flow.request.url
        flow.request.url = f"https://gh-proxy.org/{flow.request.url}"
        flow.request.headers["Host"] = "gh-proxy.org"
        flow.request.headers["Origin"] = "https://gh-proxy.org"
        log.info(f"[REWRITE] {original} -> {flow.request.url}")

def response(flow: http.HTTPFlow) -> None:
    log.info(f"[RESPONSE] {flow.request.url} -> {flow.response.status_code}")
