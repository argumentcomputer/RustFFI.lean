import Lake
open System Lake DSL

package FFI {
  precompileModules := true
  moreLinkArgs := #["-lsome_rust_lib", "-L", "./target/debug"]
}

@[default_target] lean_exe ffi {
  root := `Main
}

def ffiC := "ffi.c"
def ffiO := "ffi.o"

target importTarget (pkg : Package) : FilePath := do
  let oFile := pkg.oleanDir / ffiO
  let srcJob ← inputFile ffiC
  buildFileAfterDep oFile srcJob fun srcFile => do
    let flags := #["-I", (← getLeanIncludeDir).toString]
    compileO ffiC oFile srcFile flags

extern_lib rustFFI (pkg : Package) := do
  let name := nameToStaticLib "rustffi"
  let job ← fetch <| pkg.target ``importTarget
  buildStaticLib (pkg.buildDir / defaultLibDir / name) #[job]

