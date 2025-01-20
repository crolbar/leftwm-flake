{
  modkey = "Super";
  mousekey = "Super";
  workspaces = [];
  tags = ["1" "2" "3" "4" "5" "6" "7" "8" "9"];
  layouts = ["MainAndVertStack" "GridHorizontal" "EvenVertical"];
  scratchpad = [
    {
      name = "Alacritty";
      value = "alacritty";
      x = 860;
      y = 390;
      height = 1000;
      width = 1500;
    }
  ];
  window_rules = [
    {
      window_title = "Volume Control";
      spawn_floating = true;
    }
  ];
  layout_mode = "Tag";
  max_window_width = "None";
  insert_behavior = "Bottom";
  disable_current_tag_swap = true;
  disable_tile_drag = false;
  disable_window_snap = true;
  focus_behaviour = "Sloppy";
  focus_new_windows = true;
  single_window_border = false;
  sloppy_mouse_follows_focus = true;
  auto_derive_workspaces = true;
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
      command = "Execute";
      value = "schizofox";
      modifier = ["modkey"];
      key = "b";
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

    {
      command = "FocusWindowUp";
      modifier = ["modkey"];
      key = "h";
    }
    {
      command = "FocusWindowUp";
      modifier = ["modkey"];
      key = "k";
    }
    {
      command = "FocusWindowDown";
      modifier = ["modkey"];
      key = "l";
    }
    {
      command = "FocusWindowDown";
      modifier = ["modkey"];
      key = "j";
    }
    {
      command = "MoveWindowUp";
      modifier = ["modkey" "Shift"];
      key = "k";
    }
    {
      command = "MoveWindowDown";
      modifier = ["modkey" "Shift"];
      key = "j";
    }
    {
      command = "IncreaseMainWidth";
      value = "5";
      modifier = ["modkey" "Shift"];
      key = "l";
    }
    {
      command = "DecreaseMainWidth";
      value = "5";
      modifier = ["modkey" "Shift"];
      key = "h";
    }

    {
      command = "SwapTags";
      modifier = ["Alt"];
      key = "Tab";
    }
    {
      command = "NextLayout";
      modifier = ["modkey"];
      key = "n";
    }

    {
      command = "ToggleFloating";
      modifier = ["modkey"];
      key = "z";
    }
    {
      command = "ToggleFullScreen";
      modifier = ["modkey"];
      key = "f";
    }

    {
      command = "GotoTag";
      value = "1";
      modifier = ["modkey"];
      key = "1";
    }
    {
      command = "GotoTag";
      value = "2";
      modifier = ["modkey"];
      key = "2";
    }
    {
      command = "MoveToTag";
      value = "1";
      modifier = ["modkey" "Shift"];
      key = "1";
    }
  ];
  state_path = "None";
}
