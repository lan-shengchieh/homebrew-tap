# Homebrew tap for keyclean

Install [keyclean](https://github.com/lan-shengchieh/keyclean):

```sh
brew install lan-shengchieh/tap/keyclean
```

Or tap the repository first:

```sh
brew tap lan-shengchieh/tap
brew install keyclean
```

Upgrade to the latest release:

```sh
brew update
brew upgrade keyclean
```

The Formula builds `keyclean` from its tagged Swift source release.

KeyClean 0.2 installs a permission-free Safe Mode app and a separate Full Lock
app so Accessibility is never granted to your terminal:

```sh
keyclean                # Safe Mode, no privacy permission
keyclean --full         # Full Lock, Accessibility belongs to KeyClean
keyclean --full-once    # Full Lock, then automatically revoke access
```

Until v0.2.0 is tagged, test the new source build with:

```sh
brew install --HEAD lan-shengchieh/tap/keyclean
```
