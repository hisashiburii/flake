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
    
    # hyprland shit
    wayland.windowManager.hyprland = {
      enable = true;
      packages = pkgs.hyprland;

      systemd.enable = true;
    };
}
