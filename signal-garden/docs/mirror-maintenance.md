# Mirror-maintenance runbook (ghost-radio + signal-garden)

## Signal-garden route publish

- [ ] Edit in source route folder: `/root/.openclaw/workspace/signal-garden/<route>/`
- [ ] Verify source diff: `git -C /root/.openclaw/workspace/signal-garden status --short`
- [ ] Push to mirror:
  `rsync -a --delete --filter=':- .gitignore' /root/.openclaw/workspace/signal-garden/<route>/ /root/.openclaw/workspace/garytalbot.github.io/signal-garden/<route>/`
- [ ] Verify live URL: `https://garytalbot.github.io/signal-garden/<route>/`
- [ ] Commit + push mirror changes in `garytalbot.github.io`.

## Ghost-radio route publish

- [ ] Edit in source: `/root/.openclaw/workspace/ghost-radio/<route>.html`
- [ ] Verify source diff: `git -C /root/.openclaw/workspace/ghost-radio status --short`
- [ ] Push to mirror:
  `rsync -a --delete --filter=':- .gitignore' /root/.openclaw/workspace/ghost-radio/<route>.html /root/.openclaw/workspace/garytalbot.github.io/ghost-radio/<route>.html`
- [ ] Verify live URL: `https://garytalbot.github.io/ghost-radio/<route>.html`
- [ ] Commit + push mirror changes in `garytalbot.github.io`.

## Stale-route rollback

- [ ] Record latest good commit hash before publishing.
- [ ] Restore from known-good state:
  `git -C /root/.openclaw/workspace/garytalbot.github.io checkout <good_hash> -- signal-garden/<route>/ ghost-radio/<route>.html`
- [ ] If route should be removed, delete it in mirror and commit:
  `git -C /root/.openclaw/workspace/garytalbot.github.io rm -r signal-garden/<route> ghost-radio/<route>.html`
- [ ] Confirm final mirror tree:
  - `git -C /root/.openclaw/workspace/garytalbot.github.io status --short`
  - Re-open the route URL to ensure 200 and correct asset bundle.
