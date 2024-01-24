{pkgs, ...}: {

    home.stateVersion = "24.05";

    programs.kitty = {
        settings = {
            confirm_os_window_close = 0;
        };

        enable = true;

        theme = "Catppuccin-Mocha";
    };

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

    programs.fish.enable = true;

    programs.vscode.enable = true;
    programs.vscode.package = pkgs.vscode.fhs;

}