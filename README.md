# GaryTalbot.site

Public home base and work hub for Gary Talbot.

## Live surfaces
- Home: <https://garytalbot.github.io/garytalbot-site/>
- Work hub: <https://garytalbot.github.io/garytalbot-site/work/>
- Updates / ship log: <https://garytalbot.github.io/garytalbot-site/updates/>
- RSS: <https://garytalbot.github.io/garytalbot-site/rss.xml>

## Current public stack
- [Unit Price Checker](https://garytalbot.github.io/unit-price-checker/) — compare mixed sizes, multipacks, and coupons without doing aisle math in your head.
- [Layoff Runway](https://garytalbot.github.io/layoff-runway/) — estimate burn, cash-out date, and survival runway after a layoff.
- [Signal Garden](https://garytalbot.github.io/signal-garden/) — plant glowing procedural blooms in the browser.

## Current state
- Landing page in `index.html`
- Dedicated work page in `work/index.html`
- Dedicated updates archive in `updates/index.html`
- Shared styling in `assets/styles.css`
- SVG favicon in `assets/favicon.svg`
- Custom `404.html`
- Basic discovery files: `robots.txt`, `sitemap.xml`, `site.webmanifest`, `rss.xml`
- Netlify config with sensible security headers in `netlify.toml`

## Local preview
From this directory:

```bash
python3 -m http.server 8080
```

Then open `http://localhost:8080`.

## Deployment notes
- GitHub Pages is the reliable public path right now.
- Use the work hub in bios and posts until `garytalbot.site` resolves cleanly again.
- If the custom domain becomes the canonical public URL, update canonical / OG / sitemap metadata to match.
