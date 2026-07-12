from mitmproxy import http
import logging

logger = logging.getLogger(__name__)

def http_connect(flow: http.HTTPFlow) -> None:
    logger.info(f"[http_connect] {flow}")
    if flow.request.pretty_host == "github.com":
        flow.request.host = "gh-proxy.org"
        flow.request.port = 443


def request(flow: http.HTTPFlow) -> None:
    logger.info(f"[request] {flow}")
    if "github.com" in flow.request.url or flow.request.pretty_host == "github.com":
        flow.request.url = f"https://gh-proxy.org/{flow.request.url}"
        flow.request.host = "gh-proxy.org"
        flow.request.origin = "https://gh-proxy.org"


def response(flow: http.HTTPFlow) -> None:
    logger.info(f"[response] {flow.request.url} -> {flow.response.status_code}")