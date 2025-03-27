{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tmux
    ghc
    libclang
    lua-language-server
    nil
    haskell-language-server
    unzip
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    material-icons
    nerd-fonts.symbols-only
    martian-mono
  ];
}
