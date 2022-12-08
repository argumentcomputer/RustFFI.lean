import Lake
open System Lake DSL

package «rust-ffi» {
  srcDir := "lean"
  precompileModules := true
}

lean_lib RustFFI {}

@[default_target] lean_exe test {
  root := `Main
}

target rustffi.o (pkg : Package) : FilePath := do
  let oFile := pkg.buildDir / "c" / "rustffi.o"
  let srcJob ← inputFile <| pkg.dir / "c" / "shim.cpp"
  let flags := #["-I", (← getLeanIncludeDir).toString, "-fPIC"]
  buildO "shim.cpp" oFile srcJob flags "c++"

extern_lib librustffi (pkg : Package) := do
  let name := nameToStaticLib "rustffi"
  let rustffiO ← fetch <| pkg.target ``rustffi.o
  buildStaticLib (pkg.buildDir / "c" / name) #[rustffiO]

