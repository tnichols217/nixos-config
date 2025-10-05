{ username, ... }:
{
  home-manager.users.${username} = {
    programs = {
      starship = {
        enable = true;
        settings = {
          add_newline = false;

          format = "[](fg:white)$os[](fg:white bg:dim bg:blue)$directory[](fg:blue bg:green)$git_branch$git_commit$git_status$git_state[](fg:green) ";
          right_format = "[](fg:black)$status[](bg:black fg:yellow)($cmd_duration$jobs[ ](bg:yellow fg:blue))[](bg:yellow fg:blue)($direnv$nix_shell$python$conda$kubernetes$terraform$aws$gcloud[ ](bg:blue fg:white))[](bg:blue fg:white)$time[](fg:white)";

          os = {
            disabled = false;
            format = "[ $symbol ]($style)";
            style = "bg:white fg:black";
            symbols = {
              AlmaLinux = " ";
              Alpine = " ";
              Amazon = " ";
              Android = " ";
              Arch = " ";
              Artix = " ";
              CachyOS = " ";
              CentOS = " ";
              Debian = " ";
              DragonFly = "󰚰 ";
              Emscripten = " ";
              EndeavourOS = " ";
              Fedora = " ";
              FreeBSD = " ";
              Garuda = " ";
              Gentoo = " ";
              HardenedBSD = " ";
              Kali = " ";
              Linux = " ";
              Mabox = "󰏖 ";
              Macos = " ";
              Manjaro = " ";
              Mint = " ";
              NixOS = " ";
              Nobara = " ";
              OpenBSD = "󰈈 ";
              OpenCloudOS = "󰅠 ";
              openSUSE = " ";
              OracleLinux = "󰡵 ";
              Pop = " ";
              Raspbian = " ";
              Redhat = " ";
              RedHatEnterprise = " ";
              RockyLinux = " ";
              Solus = " ";
              SUSE = " ";
              Ubuntu = " ";
              Unknown = "󰟢 ";
              Uos = "󰳛 ";
              Void = " ";
              Windows = " ";
            };
          };

          directory = {
            format = "[ $path ]($style)";
            truncation_length = 3;
            truncation_symbol = "…/";
            read_only = " ";
            read_only_style = "red";
            style = "bold bg:blue fg:black";
          };

          git_branch = {
            symbol = "  ";
            format = "[ $symbol$branch(:$remote_branch) ]($style)";
            style = "bold bg:green fg:black";
            truncation_length = 20;
            truncation_symbol = "…";
          };

          git_commit = {
            format = "[($hash$tag)]($style)";
            style = "bold bg:green fg:black";
            tag_disabled = false;
          };

          git_state = {
            style = "bold bg:green fg:black";
            rebase = "󰡓 ";
            merge = " ";
            revert = "󱞧 ";
            cherry_pick = " ";
            bisect = "󱦒 ";
            am = " ";
            am_or_rebase = " 󰡓 ";
          };

          git_status = {
            style = "bold bg:green fg:black";
            format = "[($all_status$ahead_behind )]($style)";
          };

          status = {
            success_symbol = " ";
            symbol = " ";
            not_executable_symbol = "󰜺 ";
            not_found_symbol = " ";
            sigint_symbol = "󱈸 ";
            signal_symbol = "󱑺 ";
            format = "[ $symbol$status$signal_name ]($style)";
            style = "bold bg:black fg:white";
            disabled = false;
          };

          cmd_duration = {
            format = "[⏱ $duration]($style)";
            min_time = 500;
            show_notifications = true;
            disabled = false;
            style = "bold bg:yellow fg:black";
          };

          jobs = {
            number_threshold = 1;
            style = "bold bg:yellow fg:black";
          };

          direnv = {
            format = "[$symbol$loaded/$allowed ]($style)";
            symbol = " ";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          nix_shell = {
            format = "[$symbol$state]($style)";
            symbol = " ";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          python = {
            symbol = " ";
            format = "[$symbol$pyenv_prefix($virtualenv)]($style)";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          conda = {
            format = "[$symbol$environment]($style)";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          kubernetes = {
            format = "[$symbol$context]($style)";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          terraform = {
            format = "[$symbol$workspace]($style)";
            symbol = "󰇧 ";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          aws = {
            format = "[$symbol($profile )($region )($duration )]($style)";
            symbol = " ";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          gcloud = {
            format = "[$symbol$account(@$domain)( $region)]($style)";
            symbol = " ";
            disabled = false;
            style = "bold bg:blue fg:black";
          };

          time = {
            disabled = false;
            format = "[ $time  ]($style)";
            style = "bold fg:black bg:white";
            time_format = "%H:%M:%S";
            utc_time_offset = "local";
          };
        };
      };
    };
  };
}