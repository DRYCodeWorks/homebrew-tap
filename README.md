# DRYCodeWorks Tap

## How do I install these formulae?

`brew install drycodeworks/tap/tailctl`

Or `brew tap drycodeworks/tap` and then `brew install tailctl`.

Casks install the same way, with `--cask`:

`brew install --cask drycodeworks/tap/tacet`

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "drycodeworks/tap"
brew "tailctl"
cask "tacet"
```

## Formulae

- [`tailctl`](https://github.com/DRYCodeWorks/tailctl) — per-identity Tailscale
  networking for parallel sessions on a single Mac.

## Casks

- [`tacet`](https://github.com/DRYCodeWorks/tacet) — push-to-talk dictation that
  pastes the transcript at the cursor. Ships as a signed and notarized app, so
  it is a cask rather than a formula: building from source would discard the
  stapled ticket.

## Changing a formula or cask

**Land changes via pull request, not a direct push to main.**

`brew test-bot` picks which formulae to build by diffing `HEAD` against
`origin/main`. On a push to main those are the same commit, so the diff is empty
and CI reports green having built nothing (`testing_formulae (none)`). Only a PR
gives it a base to diff against, and only then does CI actually install, test,
and audit the formula.

Casks have the same requirement for a different reason: `test-bot` has no cask
step at all, so `--only-formulae` reports `testing_formulae (none)` for a
cask-only change and passes. CI installs changed casks in a separate step that
also diffs against the PR base.

Bumping a formula version:

```bash
brew livecheck drycodeworks/tap/<formula>     # is there a new release?
# update url + sha256 (and resources, if dependencies changed)
brew install --build-from-source drycodeworks/tap/<formula>
brew test drycodeworks/tap/<formula>
brew audit --strict --online drycodeworks/tap/<formula>
```

Bumping a cask version:

```bash
brew livecheck --cask drycodeworks/tap/<cask>
# update version + sha256 (shasum -a 256 on the release asset)
brew install --cask drycodeworks/tap/<cask>
brew audit --cask --online drycodeworks/tap/<cask>
```

`brew audit --new` additionally requires the upstream repository be "notable"
(75+ stars). That gate is for submissions to homebrew-cask, not for this tap —
expect it to fail here and ignore it.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
