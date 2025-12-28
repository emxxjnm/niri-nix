{
  lib,
  pkgs,
  modules,
  ...
}:
let
  inherit (pkgs) runCommand nixosOptionsDoc;
  eval = lib.evalModules {
    modules = modules ++ [
      {
        _module.check = false;
      }
    ];
  };
  optionsDoc = nixosOptionsDoc {
    options = lib.removeAttrs eval.options [ "_module" ];
  };
in
runCommand "options-doc.md" { } ''
  cat ${optionsDoc.optionsCommonMark} >> $out
''
