#[cxx::bridge]
mod ffi {
    extern "Rust" {
        fn add_rust(left: u32, right: u32) -> u32;
    }

    //unsafe extern "C++" {
    //    include!("lean/lean.h");
    //    include!("ffi/include/shim.h");
    //}
}

pub fn add_rust(left: u32, right: u32) -> u32 {
    left + right
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let result = add(2, 2);
        assert_eq!(result, 4);
    }
}
