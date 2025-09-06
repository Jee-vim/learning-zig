const std = @import("std");

fn validation(val: u8) !void {
    if (val % 2 != 0) {
        // pakai return pas validasi user input, file parsing, network
        // jadi compile tetep lolos, tapi runtime bisa nge return error
        return error.NotEven;
    }
}

fn validationComptime(comptime val: u8) void {
    if (val % 2 != 0) {
        // pakai compileError untuk cek di runtime
        // contoh: panjang array, tipe data
        @compileError("val must be even (compile-time check)");
    }
}

pub fn main() !void {
    // ✅ compile-time check
    // validation_comptime(2); // oke
    validationComptime(3); // gagal compile

    // ✅ runtime check
    const x: u8 = 5;
    try validation(x); // compile lolos, runtime bisa error
}
