# [Home-Manager](https://github.com/nix-community/home-manager) module for [LeftWM](https://leftwm.org/)

> [!WARNING]
> Nix to RON conversion is bare-bones,
> so there could be some errors.

## Using the module

Add the flake as an input

```nix
# flake.nix
{
  inputs = {
    leftwm-flake.url = "github:crolbar/leftwm-flake";
  };
}
```

Import and use the module

> [!NOTE]
> By default It will use the package output from leftwm's [flake](https://github.com/leftwm/leftwm/blob/main/flake.nix)
> so you will probably need to build it from source.
> If you don't want to do that just declare `package = pkgs.leftwm;`

```nix
imports = [inputs.leftwm-flake.homeManagerModules.default];

    
programs.leftwm = {
  enable = true;
  package = pkgs.leftwm;

  theme = {
    border_width = 2;
    margin = 4;
    default_border_color = "#000000";
    floating_border_color = "#ff0000";
    focused_border_color = "#ff0000";
  };

  up = ''
    leftwm-command "LoadTheme $SCRIPTPATH/theme.ron"

    picom
    eww open btm_tray -c ~/.config/leftwm/themes/current/eww
    eww open tags -c ~/.config/leftwm/themes/current/eww
  '';

  down = ''
    leftwm-command "UnloadTheme"
  '';

  settings = {
    modkey = "Super";
    mousekey = "Super";
    workspaces = [];
    tags = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
    layouts = ["MainAndVertStack" "GridHorizontal" "EvenVertical"];
    focus_behaviour = "Sloppy";
    focus_new_windows = true;
    single_window_border = false;
    keybind = [
      {
        command = "Execute";
        value = "rofi -show drun -show-icons";
        modifier = ["modkey"];
        key = "r";
      }
      {
        command = "Execute";
        value = "alacritty";
        modifier = ["modkey"];
        key = "x";
      }
      {
        command = "CloseWindow";
        modifier = ["modkey" "Shift"];
        key = "q";
      }
      {
        command = "SoftReload";
        modifier = ["modkey" "Shift"];
        key = "r";
      }
    ];
  };
};
```
