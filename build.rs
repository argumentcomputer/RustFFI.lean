//use cxx_build::CFG;

fn main() {
    //Override the default include path so Lake can find it
    //CFG.include_prefix = "";

    let home_dir = home::home_dir()
        .unwrap()
        .into_os_string()
        .into_string()
        .unwrap();

    std::env::set_var(
        "C_INCLUDE_PATH",
        format!(
            "$C_INCLUDE_PATH:{}/.elan/toolchains/leanprover--lean4---nightly-2022-12-08/include",
            home_dir
        ),
    );
    std::env::set_var(
    "CPLUS_INCLUDE_PATH",
    format!("$CPLUS_INCLUDE_PATH:{}/.elan/toolchains/leanprover--lean4---nightly-2022-12-08/include", home_dir)
  );

    let lean_path = std::env::var("C_INCLUDE_PATH").unwrap();

    cxx_build::bridge("src/lib.rs")
        .file("src/shim.cpp")
        .include(lean_path)
        .compile("ffi");

    println!("cargo:rerun-if-changed=src/main.rs");
    println!("cargo:rerun-if-changed=src/shim.cpp");
    println!("cargo:rerun-if-changed=include/shim.h");
}
