#include "lean/lean.h"
#include "rust/cxx.h"
#include "lean-rust-ffi/include/shim.h"
#include "lean-rust-ffi/src/main.rs.h"

lean_obj_res add_lean(lean_obj_arg left, lean_obj_arg right) {
  return add(left, right);
}
