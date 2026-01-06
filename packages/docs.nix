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

  root = toString ../.;

  transformDeclaration =
    decl:
    let
      declStr = toString decl;
      subpath = lib.removePrefix "/" (lib.removePrefix root declStr);
    in
    assert lib.hasPrefix root declStr;
    {
      url = "https://codeberg.org/BANanaD3V/niri-nix/src/branch/main/${subpath}";
      name = subpath;
    };

  optionsDoc = nixosOptionsDoc {
    options = lib.removeAttrs eval.options [ "_module" ];
    documentType = "none";
    transformOptions = opt: opt // { declarations = map transformDeclaration opt.declarations; };
  };
in
runCommand "options-doc.md" { } ''
  cat ${optionsDoc.optionsCommonMark} >> $out
''
