inputs: {
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;

  inherit (lib) types mkIf optional;

  defaultPackage = inputs.leftwm.packages.x86_64-linux.default;

  cfg = config.programs.leftwm;
in {
  options.programs.leftwm = {
    enable = mkEnableOption "leftwm";

    package = mkOption {
      type = types.package;
      default = defaultPackage;
      example = pkgs.leftwm;
    };

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
      example = with pkgs; [eww];
      description = "extra packages to be installed alongside leftwm";
    };

    theme = mkOption {
      type = let
        valueType = with types;
          nullOr (oneOf [
            int
            str
            (attrsOf valueType)
          ]);
      in
        valueType;
      default = "";
      example = import ./theme-example.nix;
      description = ''
        theme to be written to leftwm's themes/current/theme.ron
        requires up & down scripts to be set for it to take effect
      '';
    };

    up = mkOption {
      type = types.lines;
      default = "";
      description = "up script";
    };

    down = mkOption {
      type = types.lines;
      default = "";
      description = "down script";
    };

    settings = mkOption {
      type = let
        valueType = with types;
          nullOr (oneOf [
            bool
            int
            str
            (attrsOf valueType)
            (listOf valueType)
          ]);
      in
        valueType;
      default = {};
      example = import ./settings-example.nix;
      description = "settings to be written to leftwm's config.ron";
    };
  };

  config = let
    enumTypes = [
      "command"
      "layout_mode"
      "focus_behaviour"
      "max_window_width"
      "insert_behavior"
      "focus_on_activation"
      "state_path"
    ];

    attrsToRon = attrs: let
      keyValueStrs = builtins.concatLists (
        lib.attrsets.mapAttrsToList
        (
          key: value: let
            isEnumType = builtins.elem key enumTypes;
          in
            if isEnumType
            then ["${key}: ${toString value}"]
            else ["${key}: ${nixToRon value}"]
        )
        attrs
      );
    in "\n(\n${(builtins.concatStringsSep ",\n" keyValueStrs)}\n)";

    nixToRon = value:
      if builtins.isAttrs value
      then attrsToRon value
      else if builtins.isString value
      then "\"${value}\""
      else if builtins.isList value
      then "[${builtins.concatStringsSep "," (map nixToRon value)}]"
      else if builtins.isBool value
      then lib.boolToString value
      else if builtins.isInt value
      then toString value
      else abort "unsuported type";
  in
    mkIf cfg.enable
    {
      home.packages =
        (optional (cfg.package != null) cfg.package)
        ++ cfg.extraPackages;

      xdg.configFile = {
        "leftwm/config.ron".text =
          ''
            #![enable(implicit_some)]
          ''
          + (attrsToRon cfg.settings);

        "leftwm/themes/current/theme.ron" = mkIf (cfg.theme != "") {
          text = attrsToRon cfg.theme;
        };

        "leftwm/themes/current/up" = mkIf (cfg.up != "") {
          source = pkgs.writeShellScript "up" cfg.up;
        };

        "leftwm/themes/current/down" = mkIf (cfg.down != "") {
          source = pkgs.writeShellScript "up" cfg.down;
        };
      };
    };
}
