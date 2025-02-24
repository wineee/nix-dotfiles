## Config for home-manager

### Init

1. Install Nix 

> sh <(curl https://mirrors.tuna.tsinghua.edu.cn/nix/latest/install) --no-daemon

2. Enable flake

edit `~/.config/nix/nix.conf`:

```txt
experimental-features = nix-command flakes
substituters = https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store https://cache.nixos.org/
```

3. Install home-manager

```bash
git clone git@github.com:wineee/nix-dotfiles.git
cd nix-dotfiles
nix shell nixpkgs#home-manager
home-manager switch --flake .
```

or use nh:

```bash
nh home switch .
```

### git

[generating-a-new-gpg-key](https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key)

