from mitmproxy import http
import logging

logger = logging.getLogger(__name__)

def request(flow: http.HTTPFlow) -> None:
    logger.info(f"[request] {flow}")
    if flow.request.pretty_host == "github.com":
        logger.info(f"[REDIRECT] Catching github.com request: {flow.request.url}")
        target_url = f"https://gh-proxy.org/{flow.request.url}"
        flow.response = http.Response.make(
            302,
            b"",
            {"Location": target_url}
        )
        logger.info(f"[REDIRECTED TO] {target_url}")