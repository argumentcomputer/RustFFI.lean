#include <lean/lean.h>
#include "rust/cxx.h"
#include "ffi/src/lib.rs.h"

extern "C" uint32_t add_cpp(uint32_t left, uint32_t right) {
  return add_rust(left, right);
}

