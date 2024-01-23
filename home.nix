{pkgs, ...}: {
    programs.kitty = {
        settings = {
            confirm_os_window_close = 0;
        };

        enable = true;

        theme = "Catppuccin-Mocha";
    };
}