{pkgs, ...}: {

    home.stateVersion = "24.05";

    programs.neovim = {
        enable = true;
    };

    services.dunst = {
        enable = true;
    };

    programs.git.enable = true;

    programs.gh.enable = true;

    programs.wlogout.enable = true;

    programs.feh.enable = true;

    programs.htop.enable = true;

    programs.obs-studio.enable = true;

    programs.bat.enable = true;

    programs.vscode.enable = true;
    programs.vscode.package = pkgs.vscode.fhs;
    
    # GNOME Dark Mode
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };
}
