from mitmproxy import http
import logging


logger = logging.getLogger(__name__)


def request(flow: http.HTTPFlow) -> None:
    logger.info(f"[REQUEST] {flow.request.url}")
    if flow.request.pretty_host == "github.com":
        flow.request.url = f"https://gh-proxy.org/{flow.request.url}"
        flow.request.host = "gh-proxy.org"
        flow.request.origin = "https://gh-proxy.org"
        logger.info(f"[REWRITE TO] {flow.request.url}")


def response(flow: http.HTTPFlow) -> None:
    logger.info(f"[RESPONSE] {flow.request.url} -> {flow.response.status_code}")
