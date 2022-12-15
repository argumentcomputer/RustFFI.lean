* FFI.lean

A template for calling Rust functions in Lean using C/C++ FFI and the [cxx crate](https://cxx.rs).

Based on the [Lake FFI example](https://github.com/leanprover/lake/tree/master/examples/ffi) and [Cxx demo](https://github.com/dtolnay/cxx/tree/master/demo).

* Build

```
cargo build
lake build
```

* Run

```
lake exe test
```

should print the result of `1 + 1`

* Troubleshooting

Run `lake clean` and/or `cargo clean` after making changes.
