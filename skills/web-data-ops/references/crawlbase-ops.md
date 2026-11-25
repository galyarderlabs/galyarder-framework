# Crawlbase Ops (research notes)

Attribution: Crawlbase official skills as listed in the VoltAgent/awesome-agent-skills index (https://github.com/VoltAgent/awesome-agent-skills). The index describes Crawlbase as web data infrastructure: Crawling API, MCP server, and integrations giving agents live access to webpages, with JavaScript rendering, proxy rotation, and anti-bot protection.

## Skills listed in the index

- crawl-html: crawl a URL and return raw HTML, with JS rendering, device emulation, and geo-targeting.
- crawl-markdown: extract clean, LLM-ready Markdown from a URL, stripped of ads and boilerplate.
- crawl-screenshot: full-page or viewport screenshots on desktop or mobile.
- storage-get: retrieve a stored page as JSON, HTML, or Markdown.
- storage-list: list stored rids with scroll-based pagination, up to 1000 per call.
- storage-bulk-get: retrieve up to 100 stored pages in one call, with optional auto-delete.
- storage-count: count documents held in Cloud Storage for a token.
- storage-delete: delete a single stored page by rid.
- storage-bulk-delete: delete up to 100 stored pages in one call.

## Paired tooling (not skills)

- crawlbase-mcp: the MCP server behind these skills (npm @crawlbase/mcp).
- langchain-crawlbase: LangChain document loader, tool, and retriever backed by the Crawling API.
- n8n-nodes-crawlbase: native Crawlbase node for n8n with credentials and Crawling API options.

## What the Forge draft takes from this

Only the shape: fetch as HTML, Markdown, or screenshot; store with retrievable IDs; every extracted row cites its source page and fetch time. The draft does not copy any Crawlbase skill text, and it adds the Forge rules the source does not carry: a crawl plan before fetching, a failed-fetch list, raw-copy retention for re-checks, and a shipped dataset as the output.
