import Lake
open System Lake DSL

package RustFFI

@[default_target]
lean_exe ffi where
  root := `Main

def ffiC := "ffi.c"
def ffiO := "ffi.o"

target importTarget (pkg : NPackage _package.name) : FilePath := do
  let oFile := pkg.buildDir / ffiO
  let srcJob ← inputFile ffiC
  buildFileAfterDep oFile srcJob fun srcFile => do
    let flags := #["-I", (← getLeanIncludeDir).toString]
    compileO ffiC oFile srcFile flags

extern_lib libffi (pkg : NPackage _package.name) := do
  let name := nameToSharedLib "ffi"
  let job ← fetch <| pkg.target ``importTarget
  buildLeanSharedLib (pkg.buildDir / name) #[job]

extern_lib some_rust_lib (pkg : NPackage _package.name) := do
  proc { cmd := "cargo", args := #["build", "--release"], cwd := pkg.dir }
  let name := nameToSharedLib "some_rust_lib"
  let srcPath := pkg.dir / "target" / "release" / name
  IO.FS.createDirAll pkg.buildDir
  let tgtPath := pkg.buildDir / name
  IO.FS.writeBinFile tgtPath (← IO.FS.readBinFile srcPath)
  return (pure tgtPath)
