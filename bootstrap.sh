#!/bin/bash
# Bootstraps a brand new Mac far enough to clone my (private) dotfiles, then
# hands off to their setup.sh:
#
#   curl -fsSL https://jimmy.schementi.com/bootstrap.sh | bash
#
# Nothing secret lives here. The one credential involved is an SSH key that
# never leaves 1Password; this script installs 1Password and waits while you
# sign in.
#
# Everything is inside main(), called on the last line, so a truncated download
# runs nothing. Under `curl | bash` stdin is the script itself, so anything
# interactive reads from /dev/tty and anything that might read stdin gets
# /dev/null. Plain bash 3.2, since that's all a fresh Mac has.

set -euo pipefail

DOTFILES_REMOTE="git@github.com:jschementi/dotfiles.git"
DOTFILES_DIR="$HOME/dev/dotfiles"
TILDE="~"   # a literal ~ in ${x/#$HOME/~} gets expanded by bash 5

log()   { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33m warn:\033[0m %s\n' "$*"; }
pause() { printf '\n%s ' "$1"; read -r </dev/tty; }

# The /usr/bin/git stub exists either way; the real one only arrives with the
# Command Line Tools (or Xcode), and xcode-select -p can answer before the
# install has finished.
have_clt() {
  local dir
  dir="$(xcode-select -p 2>/dev/null)" && [ -x "$dir/usr/bin/git" ]
}

mdm_enrolled() {
  local out
  out="$(profiles status -type enrollment 2>/dev/null || true)"
  [[ "$out" == *"MDM enrollment: Yes"* ]]
}

# `ssh -T` exits 1 even when authentication succeeds, so check what it says.
github_ok() {
  local out
  out="$(ssh -T -o BatchMode=yes git@github.com 2>&1 </dev/null || true)"
  [[ "$out" == *"successfully authenticated"* ]]
}

# Trust GitHub's host keys as published over HTTPS, rather than accepting
# whatever answers on first connect.
pin_github_host_keys() {
  local kh="$HOME/.ssh/known_hosts" meta key i=0
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  ssh-keygen -F github.com -f "$kh" >/dev/null 2>&1 && return 0
  meta="$(mktemp)"
  curl -fsSL https://api.github.com/meta -o "$meta"
  while key="$(plutil -extract "ssh_keys.$i" raw -o - "$meta" 2>/dev/null)"; do
    echo "github.com $key" >> "$kh"
    i=$((i + 1))
  done
  rm -f "$meta"
  if [ "$i" -gt 0 ]; then
    log "Pinned $i GitHub host keys"
  else
    warn "couldn't read GitHub's host keys; ssh will ask on first connect"
  fi
}

main() {
  [ "$(uname -s)" = Darwin ] || { echo "This is for macOS." >&2; exit 1; }

  # --- Command Line Tools: git, clang, swiftc ------------------------------
  if ! have_clt; then
    log "Installing the Xcode Command Line Tools; finish the installer window"
    xcode-select --install 2>/dev/null || true
    until have_clt; do sleep 5; done
    log "Command Line Tools installed"
  fi

  # --- Homebrew -------------------------------------------------------------
  if [ ! -x /opt/homebrew/bin/brew ] && [ ! -x /usr/local/bin/brew ]; then
    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/tty
  fi
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  # --- 1Password ------------------------------------------------------------
  # An MDM pushes its own copy, and Homebrew shouldn't fight it for the app.
  until [ -d /Applications/1Password.app ]; do
    if mdm_enrolled; then
      warn "this Mac is MDM-managed but 1Password isn't installed yet"
      pause "Install it from the MDM's self-service app, then press Return."
    else
      log "Installing 1Password"
      brew install --cask 1password </dev/null
    fi
  done

  # --- Sign in, turn on the SSH agent ---------------------------------------
  pin_github_host_keys
  if ! github_ok; then
    open -a 1Password || true
    cat <<'EOF'

  1Password is open. To continue:

    1. Sign in. You need the account password, plus either the Secret Key
       from the Emergency Kit or the "set up another device" QR code from
       the 1Password app on your phone.
    2. Settings > Developer:
       - turn on "Use the SSH agent", and click "Edit Automatically" in the
         dialog so it writes ~/.ssh/config
       - turn on "Integrate with 1Password CLI"
EOF
    local tries=0
    until github_ok; do
      if [ "$tries" -gt 0 ]; then
        if ! grep -qs IdentityAgent "$HOME/.ssh/config"; then
          warn "~/.ssh/config has no IdentityAgent line; in the SSH agent settings, click Edit Automatically"
        else
          warn "GitHub still refuses the key. Approve 1Password's prompt, and check the key is on github.com/settings/keys"
        fi
      fi
      pause "Press Return once that's done."
      tries=$((tries + 1))
    done
  fi
  log "GitHub SSH works"

  # --- dotfiles -------------------------------------------------------------
  if [ ! -d "$DOTFILES_DIR/.git" ]; then
    log "Cloning dotfiles into ${DOTFILES_DIR/#$HOME/$TILDE}"
    mkdir -p "$(dirname "$DOTFILES_DIR")"
    git clone "$DOTFILES_REMOTE" "$DOTFILES_DIR" </dev/null
  fi

  log "Handing off to setup.sh"
  "$DOTFILES_DIR/setup.sh" </dev/tty
}

main "$@"
