{
  options,
  config,
  lib,
  ...
}:
let
  opts = options.kytkos.login;
  cfg = config.kytkos.login;
  providers = lib.attrNames opts;
  enabled = name: cfg.${name}.enable or false;
  toInt = bool: if bool then 1 else 0;
  count = builtins.foldl' (acc: bool: acc + toInt bool) 0 (map enabled providers);
in
{
  config.assertions = [
    {
      assertion = count != 0 -> count == 1;
      message =
        let
          spaced = lib.concatStringsSep " ";
          names = lib.filter enabled providers;
        in
        "At most one login manager can be enabled. Current: [${spaced names}]";
    }
  ];
}
