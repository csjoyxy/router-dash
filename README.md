# RouterDash

iOS companion app for the home router dashboard (parental controls + router management).

- Native shell (WKWebView) around the router-hosted dashboard at `http://192.168.10.1/dashboard/`
- Server URL configurable in-app (use Tailscale IP when away from home)
- Built unsigned via GitHub Actions for TrollStore installation (no Apple signing needed)

## Build

Push to `main` (or run the workflow manually) — the IPA is uploaded as a build artifact.
