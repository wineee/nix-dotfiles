{
  inputs,
  config,
  pkgs,
  ...
}:

{
  # 将 test 修改为你的用户名
  home.username = "test";
  home.homeDirectory = "/home/test";

  home.packages = with pkgs; [
    # comma
    # manix
    # nixgl.nixGLIntel
    just
  ];

  # programs.fish.enable = true;

  # programs.direnv = {
  #   enable = true;
  #   nix-direnv.enable = true;
  # };

  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
