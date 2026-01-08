const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // =====================================================
    // 1. BUFFER STACK TETAP (IO / streaming)
    // Tujuan: buffer kerja sementara, cepat, aman
    // =====================================================
    {
        var raw: [4096]u8 = undefined; // buffer fisik
        const buf: []u8 = raw[0..]; // buffer dipakai

        // simulasi "baca data"
        const n = fakeRead(buf);
        std.debug.print("stack buffer read: {d} bytes\n", .{n});
    }

    // =====================================================
    // 2. BUFFER STACK KECIL (scratch / formatting)
    // Tujuan: kerja ringan, hidup sebentar
    // =====================================================
    {
        var tmp: [128]u8 = undefined;
        const scratch = tmp[0..];

        const msg = try std.fmt.bufPrint(scratch, "hello {d}", .{42});
        std.debug.print("scratch: {s}\n", .{msg});
    }

    // =====================================================
    // 3. BUFFER HEAP (ukuran runtime)
    // Tujuan: data besar / hidup lama
    // =====================================================
    {
        const size: usize = 1024;
        const heap_buf = try allocator.alloc(u8, size);
        defer allocator.free(heap_buf);

        // isi buffer
        for (heap_buf) |*b| b.* = 0xAA;

        std.debug.print("heap buffer size: {d}\n", .{heap_buf.len});
    }

    // =====================================================
    // 4. BUFFER READ-ONLY
    // Tujuan: parsing / hashing / kontrak baca
    // =====================================================
    {
        const data = "ini literal string";
        parse(data); // []const u8
    }

    // =====================================================
    // 5. BUFFER OUTPUT (callee nulis)
    // Tujuan: fungsi mengisi buffer dari caller
    // =====================================================
    {
        var out_raw: [64]u8 = undefined;
        const out = out_raw[0..];

        const written = try encode(out);
        std.debug.print("encode wrote {d} bytes\n", .{written});
    }

    // =====================================================
    // 6. BUFFER VIEW PARSIAL
    // Tujuan: kerja di sebagian data tanpa copy
    // =====================================================
    {
        var raw: [32]u8 = undefined;
        const buf = raw[0..];

        _ = fakeRead(buf);

        const header = buf[0..8];
        const body = buf[8..16];

        std.debug.print("header len={d}, body len={d}\n", .{ header.len, body.len });
    }

    // =====================================================
    // 7. BUFFER PANJANG 0
    // Tujuan: penanda / default arg
    // =====================================================
    {
        const empty: []u8 = &[_]u8{};
        std.debug.print("empty buffer len={d}\n", .{empty.len});
    }
}

// =========================================================
// FUNGSI-FUNGSI CONTOH
// =========================================================

// simulasi baca data ke buffer
fn fakeRead(buf: []u8) usize {
    const n = @min(buf.len, 16);
    for (buf[0..n], 0..) |*b, i| {
        b.* = @intCast(i);
    }
    return n;
}

// parser: hanya baca, tidak ubah
fn parse(data: []const u8) void {
    std.debug.print("parse read-only len={d}\n", .{data.len});
}

// encoder: nulis ke buffer caller
fn encode(out: []u8) !usize {
    if (out.len < 8) return error.BufferTooSmall;

    for (out[0..8], 0..) |*b, i| {
        b.* = @intCast(65 + i); // 'A' ..
    }
    return 8;
}
