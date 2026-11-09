# BPB Worker Panel on Render (Docker)

This repository adds a Docker/Render adapter around the original Cloudflare Worker. The container runs the bundled Worker under Wrangler's local `workerd` runtime and provides a local KV namespace persisted under `/data`.

## Render deployment

Create a new **Web Service** from this repository, select **Docker**, and deploy. Render can also read `render.yaml` as a Blueprint. If a persistent disk is available, mount it at `/data` so panel password and settings survive restarts.

Required or useful environment variables:

- `VL_UUID`: VLESS UUID; Render can generate this value.
- `TR_PASS`: Trojan password; Render can generate this value.
- `SECURE_PATH`: private URL path; Render can generate this value.
- `MAIN_DOMAIN`: public Render hostname or custom domain, if needed in generated links.
- `CF_ACCOUNT_ID`, `CF_ACCOUNT_EMAIL`, `CF_API_TOKEN`: optional. They are only used by the original panel's Cloudflare management actions and are not required for the proxy runtime itself.
- `PROXY_IP_MODE`, `PROXY_IPS`, `PROXY_PREFIXES`, `DOH_URL`: optional runtime settings.

The application listens on Render's `PORT` value. Do not hard-code a different public port in the Render service settings.

## Important compatibility note

This is a self-hosted compatibility layer, not a Cloudflare Workers deployment. The Worker runtime, WebSocket handling, TCP sockets, and local KV are provided by `workerd` through Wrangler. Cloudflare account management actions in the panel cannot create or update a Render service; they remain Cloudflare-specific and require valid Cloudflare credentials if used.

The Render free plan may sleep the service and does not provide a persistent disk. For stable subscriptions and saved settings, use a paid Web Service with a persistent disk or an external KV/database and review Render's current plan limits.
