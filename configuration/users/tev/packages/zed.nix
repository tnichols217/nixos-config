_: {
  enable = true;
  extensions = [
    "assembly"
    "color-highlight"
    "colored-zed-icons-theme"
    "comment"
    "csharp"
    "csv"
    "dockerfile"
    "editorconfig"
    "git-firefly"
    "html"
    "java"
    "json5"
    "julia"
    "matlab"
    "napalm"
    "nix"
    "pylsp"
    "python-requirements"
    "qml"
    "quarto"
    "r"
    "scss"
    "svelte"
    "toml"
    "uiua"
    "verilog"
    "vscode-monokai-charcoal"
    "wat"
    "xml"
  ];
  installRemoteServer = true;
  mutableUserDebug = false;
  mutableUserKeymaps = false;
  mutableUserSettings = false;
  mutableUserTasks = false;
  userSettings = {
    project_panel = {
      dock = "left";
    };
    ui_font_weight = 100.0;
    ui_font_family = "FiraCode Nerd Font Mono";
    auto_update = false;
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    base_keymap = "VSCode";
    buffer_font_family = "FiraCode Nerd Font";
    colorize_brackets = true;
    show_whitespaces = "all";
    semantic_tokens = "combined";
    icon_theme = "Colored Zed Icons Theme Dark";
    ui_font_size = 14.0;
    buffer_font_size = 15;
    theme = {
      mode = "dark";
      light = "One Light";
      dark = "Napalm Github x VSCode";
    };
    load_direnv = "shell_hook";
  };
  userTasks = [
    {
      args = [
        "fmt"
        "$ZED_WORKTREE_ROOT"
      ];
      command = "nix";
      label = "Format";
    }
  ];
}
