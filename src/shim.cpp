#include "lean/lean.h"
//#include "../include/shim.h"
//#include "../target/cxxbridge/ffi/src/lib.rs.h"
//#include "../target/debug/libffi.a"

#include "ffi/include/shim.h"
#include "ffi/src/lib.rs.h"

size_t add_cpp(size_t left, size_t right) {
  return add(left, right);
}
