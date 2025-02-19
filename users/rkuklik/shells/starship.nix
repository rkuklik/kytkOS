{
  config,
  pkgs,
  lib,
  ...
}:
let
  presets = [
    "plain-text-symbols"
    "no-runtime-versions"
  ];
  settings = {
    format = "$all$line_break$shell$character";
    character = {
      success_symbol = "[:](bold green)";
      error_symbol = "[:](bold red)";
      vimcmd_symbol = "[:](bold yellow)";
    };
    jobs = {
      symbol = "s";
      format = "with [$number job$symbol]($style) ";
      number_threshold = 1;
      symbol_threshold = 2;
    };
    battery = {
      full_symbol = "full";
      charging_symbol = "charging";
      discharging_symbol = "discharging";
      unknown_symbol = "unknown";
      empty_symbol = "empty";
      format = "with [$symbol battery]($style) ";
    };
    username = {
      show_always = true;
      format = "[$user]($style)";
      style_user = "bold blue";
    };
    hostname = {
      ssh_only = false;
      format = "[@](bold)[$hostname]($style) in ";
      style = "bold blue";
    };
    shell = {
      disabled = false;
      format = "[$indicator]($style)";
    };
    os = {
      disabled = false;
      format = "in [$symbol]($style)";
    };
    time = {
      disabled = false;
      time_format = "%R";
    };
    sudo = {
      disabled = false;
      format = "as [$symbol]($style) ";
      symbol = "root";
      style = "bold red";
    };
    status = {
      disabled = false;
      pipestatus = true;
      format = "returned [$status]($style) ";
      pipestatus_format = "\\[ $pipestatus\\] => [$common_meaning$signal_name]($style) ";
      pipestatus_separator = "| ";
    };
  };

  pkg = config.programs.starship.package;
  fileMapper = map (f: "${pkg}/share/starship/presets/${f}.toml");
  configfile =
    pkgs.runCommand "starship.toml"
      {
        nativeBuildInputs = [ pkgs.yq ];
      }
      ''
        tomlq -s -t 'reduce .[] as $item ({}; . * $item)' \
          ${lib.concatStringsSep " " (fileMapper presets)} \
          ${(pkgs.formats.toml { }).generate "starship.toml" settings} \
          > $out
      '';
in
{
  programs.starship.enable = true;
  xdg.configFile."starship.toml".source = configfile;
}
