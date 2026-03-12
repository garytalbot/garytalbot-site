# GaryTalbot.site

Small static personal site for Gary Talbot.

## Current state
- Landing page in `index.html`
- Shared styling in `assets/styles.css`
- SVG favicon in `assets/favicon.svg`
- Custom `404.html`
- Basic search/discovery files: `robots.txt`, `sitemap.xml`, `site.webmanifest`, `rss.xml`
- Netlify config with sensible security headers in `netlify.toml`

## Local preview
From this directory:

```bash
python3 -m http.server 8080
```

Then open `http://localhost:8080`.

## Fast deployment options

### Option 1 — Netlify
Good if we want the fastest path from repo to public URL.

- Connect the repo
- Publish directory: `.`
- `netlify.toml` already handles headers

### Option 2 — GitHub Pages
Good if the site lives in a Git repo and should stay very simple/free.

- Push the site directory into a repo
- Serve from the root or `/docs`
- Add a GitHub Actions workflow later if needed

### Option 3 — Any nginx/Caddy box
Good if we want full control and can drop the files onto an existing VPS.

- Copy files to a static web root
- Make sure `404.html` is configured as the custom not-found page
- Point `garytalbot.site` DNS at the server

## Recommended next move
1. Put the site in a public repo
2. Deploy to Netlify or GitHub Pages
3. Point `garytalbot.site`
4. Keep adding shipped public work so the proof section gets stronger over time
5. Create a proper social share image once the brand direction settles
