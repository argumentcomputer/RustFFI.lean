import Lake
open System Lake DSL

package «ffi» {
  srcDir := "lean"
  precompileModules := true
}

lean_lib FFI {}

@[default_target] lean_exe test {
  root := `Main
}

target ffi.o (pkg : Package) : FilePath := do
  let oFile := pkg.buildDir / "ffi.o"
  let srcJob ← inputFile <| pkg.dir / "src" / "shim.cpp"
  let flags := #["-I", (← getLeanIncludeDir).toString, "target/cxxbridge", "-fPIC"]
  buildO "shim.cpp" oFile srcJob flags "c++"

extern_lib libffi (pkg : Package) := do
  let name := nameToStaticLib "ffi"
  let ffiO ← fetch <| pkg.target ``ffi.o
  buildStaticLib (pkg.buildDir / "src" / name) #[ffiO]

