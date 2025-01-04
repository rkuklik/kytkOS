{
  pkgs,
  lib,
  ...
}: let
  flags = lib.concatStringsSep " " [
    "--impure"
    "--extra-experimental-features 'nix-command flakes'"
  ];
  check =
    # bash
    ''
      if [ "$#" -eq 0 ]; then
        echo "error: at least one package expected"
        exit 1
      fi
    '';
  shell = {
    name = "shell";
    text =
      # bash
      ''
        ${check}
        pkgs=()
        while [ "$#" -gt 0 ]; do
          pkgs+=("nixpkgs#$1")
          shift
        done
        nix shell ${flags} ''${pkgs[@]}
      '';
  };
  run = {
    name = "runpkg";
    text =
      # bash
      ''
        ${check}
        pkg="nixpkgs#$1"
        shift
        nix run ${flags} "$pkg" -- $@
      '';
  };
  opts = {
    bashOptions = [
      "noclobber"
      "noglob"
      "nounset"
      "pipefail"
      "errexit"
    ];
    runtimeInputs = [pkgs.nix];
    runtimeEnv = {
      NIXPKGS_ALLOW_UNFREE = 1;
    };
    excludeShellChecks = [
      "SC2068"
    ];
  };
  pkg = cfg: pkgs.writeShellApplication (opts // cfg);
in {
  home.packages = map pkg [shell run];
}
