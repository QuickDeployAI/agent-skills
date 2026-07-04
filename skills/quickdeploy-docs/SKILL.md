---
name: quickdeploy-docs
description: >-
  Look up official QuickDeploy AI documentation from the agent-optimized web
  surfaces (llms.txt index and prebuilt markdown page variants). Use when a
  user asks how a QuickDeploy feature works, where a platform capability is
  documented, or for setup and API reference material. Triggers: quickdeploy
  docs, documentation, how do I, reference, llms.txt.
license: MIT
compatibility: "Any agent with shell or HTTP fetch access; no authentication required"
metadata:
  category: docs
  publisher: QuickDeploy AI
allowed-tools: "Bash, WebFetch"
---

# QuickDeploy Docs

Official QuickDeploy AI documentation is published in agent-consumable formats.
Never scrape HTML — every public page has a markdown variant.

| Task                         | How                                                        |
| ---------------------------- | ---------------------------------------------------------- |
| Discover available docs      | Fetch `https://docs.quickdeploy.ai/llms.txt`               |
| Sitewide index (all domains) | Fetch `https://quickdeploy.ai/llms.txt` (hub)              |
| Read a page as markdown      | Append `.md` to the page URL, e.g. `/features.md`          |
| Content negotiation          | Request any public page with `Accept: text/markdown`       |
| Search the doc index         | `scripts/search-docs.sh <keyword>`                         |

## Usage

1. Start from the index: `curl -s https://docs.quickdeploy.ai/llms.txt`
2. Pick the relevant page link, then fetch its markdown variant:
   `curl -s https://docs.quickdeploy.ai/<page>.md`
3. For a quick keyword scan of the index, run
   `scripts/search-docs.sh <keyword>`.

## Notes

- All public QuickDeploy domains (`quickdeploy.ai`, `docs.quickdeploy.ai`,
  `marketplace.quickdeploy.ai`, `portal.quickdeploy.ai`,
  `status.quickdeploy.ai`) serve `llms.txt`.
- `https://api.quickdeploy.ai/auth.md` documents agent registration and
  authentication for the platform API.
- Response headers carry `Content-Signal` declarations; respect them.
