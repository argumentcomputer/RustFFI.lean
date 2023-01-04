import Lake
open System Lake DSL

package FFI where
  moreLinkArgs := #["-lsome_rust_lib", "-L", "./target/release"]

@[default_target] lean_exe ffi where
  root := `Main

def ffiC := "ffi.c"
def ffiO := "ffi.o"

target importTarget (pkg : Package) : FilePath := do
  let oFile := pkg.oleanDir / ffiO
  let srcJob ← inputFile ffiC
  buildFileAfterDep oFile srcJob fun srcFile => do
    let flags := #["-I", (← getLeanIncludeDir).toString]
    compileO ffiC oFile srcFile flags

extern_lib libffi (pkg : Package) := do
  proc { cmd := "cargo", args := #["build", "--release"] }
  let name := nameToStaticLib "ffi"
  let job ← fetch <| pkg.target ``importTarget
  buildStaticLib (pkg.libDir / name) #[job]

