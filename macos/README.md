# macOS dotfiles

These Stow packages preserve the macOS configuration from `~/dotfiles` in the
platform-specific repository layout. Obsolete PageKite tooling, Linux-only
helpers, backup files, and legacy native Vim configuration are excluded. `eos/` and `old/` are independent and are
not synchronized with these packages.

From this directory, preview installation before changing any home-directory
links:

```sh
stow --simulate --verbose bin git kitty ssh tmux vim zsh
```

After reviewing and resolving any conflicts with existing files or links, run
that command without `--simulate` to install. `.stowrc` targets the home directory.
Migration does not automatically replace links pointing to the old checkout.

## Existing dependencies and machine-local paths

- Zsh uses Oh My Zsh at `~/.oh-my-zsh` (with the `robbyrussell` theme and
  `git tmux rbenv kubectl gradle direnv` plugins). The source checkout contained
  an empty Oh My Zsh gitlink without submodule metadata; install Oh My Zsh
  separately rather than stowing an empty directory over that installation.
- The shell retains the existing Homebrew NVM, Conda, SDKMAN, pyenv, direnv,
  Colima, and personal executable paths. Referenced tools must already be installed.
- tmux expects TPM at `~/.tmux/plugins/tpm/tpm`.
- `bin/bin/pi` and `bin/bin/golangci-lint` intentionally retain their original
  absolute symlink targets. Those external installations are not bundled here.
  The existing `kan` executable is an Apple Silicon binary.
- SSH retains the source host settings and Colima include. No private keys are
  included. Git uses the source filename `~/.globalgitignore`.
- Neovim filetype configuration lives in `ftplugin/` (singular, as required by
  Neovim). The `vim` Stow package name is retained for consistency with the
  repository layout, but contains only Neovim configuration.

The upstream Starship/Antidote assets remain available in the Zsh package, but
are not loaded by the migrated Oh My Zsh configuration.
