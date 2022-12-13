//use cxx_build::CFG;

fn main() {
    //Override the default include path so Lake can find it
    //CFG.include_prefix = "";

    std::env::set_var(
        "C_INCLUDE_PATH",
        "$C_INCLUDE_PATH:/home/sam/.elan/toolchains/leanprover--lean4---nightly-2022-12-08/include",
    );
    std::env::set_var(
    "CPLUS_INCLUDE_PATH",
    "$CPLUS_INCLUDE_PATH:/home/sam/.elan/toolchains/leanprover--lean4---nightly-2022-12-08/include"
  );
    let lean_path = std::env::var("C_INCLUDE_PATH").unwrap();

    cxx_build::bridge("src/lib.rs")
        .file("src/shim.cpp")
        .include(lean_path)
        .flag_if_supported("-std=c++17")
        .compile("ffi");

    println!("cargo:rerun-if-changed=src/main.rs");
    println!("cargo:rerun-if-changed=src/shim.cpp");
    println!("cargo:rerun-if-changed=include/shim.h");
}
