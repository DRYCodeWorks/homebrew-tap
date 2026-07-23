# DRYCodeWorks Tap

## How do I install these formulae?

`brew install drycodeworks/tap/tailctl`

Or `brew tap drycodeworks/tap` and then `brew install tailctl`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "drycodeworks/tap"
brew "tailctl"
```

## Formulae

- [`tailctl`](https://github.com/DRYCodeWorks/tailctl) — per-identity Tailscale
  networking for parallel sessions on a single Mac.

## Changing a formula

**Land formula changes via pull request, not a direct push to main.**

`brew test-bot` picks which formulae to build by diffing `HEAD` against
`origin/main`. On a push to main those are the same commit, so the diff is empty
and CI reports green having built nothing (`testing_formulae (none)`). Only a PR
gives it a base to diff against, and only then does CI actually install, test,
and audit the formula.

Bumping a version:

```bash
brew livecheck drycodeworks/tap/<formula>     # is there a new release?
# update url + sha256 (and resources, if dependencies changed)
brew install --build-from-source drycodeworks/tap/<formula>
brew test drycodeworks/tap/<formula>
brew audit --strict --online drycodeworks/tap/<formula>
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
