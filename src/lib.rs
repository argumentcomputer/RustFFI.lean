#[no_mangle]
pub extern "C" fn add_from_rust(a : i32, b : i32) -> i32 {
    return a + b
}
