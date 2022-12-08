fn main() {
  //let include = env::var("C_INCLUDE_PATH").unwrap();
  cxx_build::bridge("src/lib.rs")
    .file("src/shim.cpp")
  //.include(include);
  //.flag_if_supported("-std=c++14")
    .compile("lean-rust-ffi");
  
  println!("cargo:rerun-if-changed=src/main.rs");
  println!("cargo:rerun-if-changed=src/shim.cpp");
  println!("cargo:rerun-if-changed=include/shim.h");
}
