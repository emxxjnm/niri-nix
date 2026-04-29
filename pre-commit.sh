#!/usr/bin/env bash

cat "$(nix build .#docs-nixos --print-out-paths --no-link)" > ./nixos-options.md
cat "$(nix build .#docs-home --print-out-paths --no-link)" > ./home-options.md

git add ./nixos-options.md
git add ./home-options.md
