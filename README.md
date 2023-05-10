### Init

1. Install Nix 

> sh <(curl -L https://nixos.org/nix/install) --no-daemon

2. Enable flake

edit `~/.config/nix/nix.conf`:

```txt
experimental-features = nix-command flakes
```

3. Install home-manager

```bash
git clone git@github.com:wineee/nix-dotfiles.git
cd nix-dotfiles
nix run .#update-home
```



### git

1. use `gpg --full-generate-key` 



