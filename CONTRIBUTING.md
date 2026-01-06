# Contributing Guidelines

You are welcome to contribute to the project. Don't be afraid to ask if you're
unsure about anything, we will kindly help you.

## Code Style

The code is formatted by `nixfmt`. There is a pre-commit hook set up for that.
If you have `direnv` installed and use Nix, you can `direnv allow` the project.
This will automatically install all pre-commit hooks.

There is no automated testing yet, so please test your changes yourself before
committing.

## Commit Style

All commits are to follow the [seven rules](https://cbea.ms/git-commit/) as well
as our template:

```
{scope}: {description}

{body}
```

Let's make an example commit.

The `scope` is what this commit changes, for example, `packages/niri-unstable`.

Say, we removed `postPatch` to comply with
[a change](https://github.com/YaLTeR/niri/commit/d8250fa876d986e3fe5190a8d906b221dadf5333)
in niri. The commit would look like this:

```
packages/niri-unstable: Fix build by removing postPatch

The upstream niri package no longer requires /usr/bin 
(https://github.com/YaLTeR/niri/commit/d8250fa876d986e3fe5190a8d906b221dadf5333)
```

If your commit is breaking you should add an exclamation mark after scope.

```
lib!: Remove `pkgs` argument from `validatedConfigFor`

Use `pkgs` from the `nixpkgs` input
```

All commits in PRs are **encouraged** to be atomic, though not strictly
required.
