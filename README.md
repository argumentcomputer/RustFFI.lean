# RustFFI.lean

A template for calling Rust functions in Lean using Lean's C FFI.

Based on the [Lake FFI example](https://github.com/leanprover/lake/tree/master/examples/ffi) and [Rust's FFI docs](https://doc.rust-lang.org/nomicon/ffi.html#calling-rust-code-from-c).

## Running

Build/run `Main.lean` with `lake exe ffi`

It should print the result of `1 + 2`.

## Troubleshooting

Run `lake clean` and/or `cargo clean` after making changes.
