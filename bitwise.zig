const std = @import("std");

pub fn main() void {
    const a: u8 = 6;   // 0b0110
    const b: u8 = 3;   // 0b0011

    // -------------------------
    // Operator AND (&)
    // Hasil = 1 hanya jika kedua bit bernilai 1
    // 0110 & 0011 = 0010
    std.debug.print("a & b = {} (0b{04b})\n", .{a & b, a & b});

    // -------------------------
    // Operator OR (|)
    // Hasil = 1 jika salah satu bit bernilai 1
    // 0110 | 0011 = 0111
    std.debug.print("a | b = {} (0b{04b})\n", .{a | b, a | b});

    // -------------------------
    // Operator XOR (^)
    // Hasil = 1 hanya jika salah satu bit bernilai 1, tapi bukan keduanya
    // 0110 ^ 0011 = 0101
    std.debug.print("a ^ b = {} (0b{04b})\n", .{a ^ b, a ^ b});

    // -------------------------
    // Operator NOT (~)
    // Negasi bit: invers semua bit/membalik semua bit:
    //
    // Bit 0 → jadi 1
    // Bit 1 → jadi 0
    //
    // ~0110 = 1001 (tapi untuk u8 = 0b11111001 = 249)
    std.debug.print("~a = {} (0b{08b})\n", .{~a, ~a});

    // -------------------------
    // Shift Left (<<)
    // Geser bit ke kiri, sama dengan kali 2^n
    // 0110 << 1 = 1100
    std.debug.print("a << 1 = {} (0b{04b})\n", .{a << 1, a << 1});

    // -------------------------
    // Shift Right (>>)
    // Geser bit ke kanan, sama dengan bagi 2^n
    // 0110 >> 1 = 0011
    std.debug.print("a >> 1 = {} (0b{04b})\n", .{a >> 1, a >> 1});
}
