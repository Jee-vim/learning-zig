const std = @import("std");

// array: fixed-size, compile-time known
// slice: runtime-sized view into memory (mutability depends on const)
//
// [N]T        : fixed-size array
// []T         : mutable slice
// []const T   : read-only slice

pub fn main() !void {
    // =====================================================
    // 1. ARRAY: ukuran fixed, compile-time
    // =====================================================
    var arr: [4]u8 = .{ 1, 2, 3, 4 };

    // boleh ubah isi array
    arr[0] = 10;

    // arr.len diketahui saat compile-time
    std.debug.print("array len = {d}\n", .{arr.len});

    // =====================================================
    // 2. SLICE MUTABLE: view ke array
    // =====================================================
    const slice: []u8 = arr[0..];

    slice[1] = 20; // mengubah arr juga

    std.debug.print("slice len = {d}\n", .{slice.len});
    std.debug.print("arr after slice write = {any}\n", .{arr});

    // =====================================================
    // 3. SLICE READ-ONLY
    // =====================================================
    const ro_slice: []const u8 = arr[0..];

    // ro_slice[2] = 30; // ❌ ERROR: cannot assign to const

    std.debug.print("ro slice len = {d}\n", .{ro_slice.len});

    // =====================================================
    // 4. ARRAY TIDAK AUTO JADI SLICE
    // =====================================================
    // takesSlice(arr);      // ❌ ERROR
    takesSlice(arr[0..]); // ✅ explicit slice

    // =====================================================
    // 5. ARRAY BISA JADI CONST SLICE
    // =====================================================
    takesConstSlice(arr);
    takesConstSlice(arr[0..]);
}

// =========================================================
// FUNGSI-FUNGSI CONTOH
// =========================================================

fn takesSlice(buf: []u8) void {
    buf[0] = 99;
}

fn takesConstSlice(buf: []const u8) void {
    std.debug.print("const slice first = {d}\n", .{buf[0]});
}
