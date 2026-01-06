# Changelog

## Unreleased (2026-01-06)

### Features

* Add convco hook, CHANGELOG
([2011db7](https://codeberg.org/BANanaD3V/niri-nix/commit/2011db7b52865188854e8e29367c53d3c6d5ded9))
* **README:** credits
([80c1511](https://codeberg.org/BANanaD3V/niri-nix/commit/80c151145e82dbed5d5764c80a4f0433f85553b7))
* **README:** Add a note about cache security.
([397638e](https://codeberg.org/BANanaD3V/niri-nix/commit/397638e24dc3118894ef602ac10dbbf331edb45e))
* **actions/update:** Switch to DetSys nix
([c5419e6](https://codeberg.org/BANanaD3V/niri-nix/commit/c5419e6577d893a7e65416069136131a9a4ad197))
* **modules/nixos:** Do not import wayland-session
([1ca06c6](https://codeberg.org/BANanaD3V/niri-nix/commit/1ca06c60f89df7e5ba5db91dd9eb1162f327cf5f))
* **modules/nixos:** Switch to a custom module
([3a91acb](https://codeberg.org/BANanaD3V/niri-nix/commit/3a91acbf82936474667ec391878723a8fa880a65))
* **lib:** Switch to using _raw allowing to escape anything
([5a5e19a](https://codeberg.org/BANanaD3V/niri-nix/commit/5a5e19a69a68e2d0c31a771ff2628a4b42b203d9))
* **modules/nixos:** Merge attrs instead to not evaluate disabled code
([3d482ff](https://codeberg.org/BANanaD3V/niri-nix/commit/3d482ff8bf65473f527127be0fa7dbea4eeb85db))
* Make validatedConfigFor return text or throw
([04887e5](https://codeberg.org/BANanaD3V/niri-nix/commit/04887e5bdba7909cd6aad662b97658b41923f02a))
* **README:** Add info on usage without HM
([76d40d3](https://codeberg.org/BANanaD3V/niri-nix/commit/76d40d339b88a08fadd1384d42ee20fd319fdeeb))
* **README:** Better structure
([e1f9896](https://codeberg.org/BANanaD3V/niri-nix/commit/e1f9896857419612cb671e0de9e45e7a000ca670))

### Fixes

* **packages/xwayland-satellite:** use `finalAttrs.src` instead of `src`
argument; remove `meta.changelog`
([9444a68](https://codeberg.org/BANanaD3V/niri-nix/commit/9444a683265fe394000f248e54f7b81d93c08a98))
* **packages/niri:** use `finalAttrs.src` instead of `src` argument
([d161af2](https://codeberg.org/BANanaD3V/niri-nix/commit/d161af26c9e0fcc86a802c29e518c0c5a6e6e490))
* **modules/home/finalConfig:** remove readOnly, add defaultText
([c43633b](https://codeberg.org/BANanaD3V/niri-nix/commit/c43633bcc870640ba8f29a3f9e42a013f8fcbe52))
* **lib/validatedConfigFor:** remove `pkgs` argument as it is part of library,
not user environment
([80bab81](https://codeberg.org/BANanaD3V/niri-nix/commit/80bab816d3024beed7da6f32572feb00341e602e))
* **packages/niri:** Drop postPatch
([5e09808](https://codeberg.org/BANanaD3V/niri-nix/commit/5e098083258b6ddd1f7b0d7954c57e920f3eae44))
* **README:** `lib.validatedConfigFor` usage
([60ce569](https://codeberg.org/BANanaD3V/niri-nix/commit/60ce569516b42c2c14f4d05ce1dcb5680bf3f1a1))
* **actions/update:** Wrong action
([d3b9c3b](https://codeberg.org/BANanaD3V/niri-nix/commit/d3b9c3b72201cb1080950b0280dfd8900ff41cde))
* **packages/niri-unstable:** Remove cargo hash
([4e44246](https://codeberg.org/BANanaD3V/niri-nix/commit/4e44246713d93a33f5bc7ec8489e1d6cde908394))
* **lib:** Write raw value if it's a regex
([e53f691](https://codeberg.org/BANanaD3V/niri-nix/commit/e53f691e5c78c0ea199b1d047b5c5c42394a3121))
* **modules/nixos:** typo
([21434c9](https://codeberg.org/BANanaD3V/niri-nix/commit/21434c9b34a00cf1f9200df10c17ae2e80b2dd12))
* **modules/home:** Set either source or text depending on the
([45dd13b](https://codeberg.org/BANanaD3V/niri-nix/commit/45dd13b6ca446c998829ed8d40969f11d6e48ed1))
* **modules/home:** Incorrect config example.
([40f6ac4](https://codeberg.org/BANanaD3V/niri-nix/commit/40f6ac495b949dbc7c952871eb4dc3022f5db9ff))
