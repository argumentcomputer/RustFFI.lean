{
  description = "Lean<->Rust FFI";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.05;
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            ocl-icd
            openssl
            pkg-config
            m4
            (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
            binutils
          ];
          hardeningDisable = [ "fortify" ];
          # Modify as needed
          #LEAN_PATH = "$HOME/.elan/toolchains/leanprover--lean4--nightly-2022-12-08";
          #C_INCLUDE_PATH = "{LEAN_PATH}/include";
          #CPLUS_INCLUDE_PATH = "{LEAN_PATH}/include";
          #C_INCLUDE_PATH = "/home/sam/.elan/toolchains/leanprover--lean4--nightly-2022-12-08/include";
          #CPLUS_INCLUDE_PATH = "/home/sam/.elan/toolchains/leanprover--lean4--nightly-2022-12-08/include";
        };
      });
}
