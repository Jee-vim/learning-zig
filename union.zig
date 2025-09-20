const std = @import("std");
// A union is a type that can hold one value out of several possible fields, but only one at a time.
// All fields share the same memory, so it’s more memory-efficient than a struct.

// plain union (unsafe)
const Data = union { int: u8, float: f16, string: []const u8 };

// tagged union (safe)
const EntryType = enum { file, directory };
const FileSystemEntry = union(EntryType) {
    file: struct {
        name: []const u8,
        size: usize,
    },
    directory: struct {
        name: []const u8,
        children: usize, // number of entries inside
    },

    pub fn describe(self: FileSystemEntry) void {
        switch (self) {
            .file => |f| std.debug.print("File: {s}, size={} bytes\n", .{ f.name, f.size }),
            .directory => |d| std.debug.print("Directory: {s}, children={}\n", .{ d.name, d.children }),
        }
    }
};

// shortcut (auto generated enum)
const Message = union(enum) {
    text: []const u8,
    number: i32,
};

pub fn main() !void {
    // only accept 1 field
    // so thats why we need to declare 2 var for assign other field
    const first_data = Data{ .int = 99 };
    const second_data = Data{ .string = "Hello world" };

    std.debug.print("data int {}, data str {s}\n\n", .{ first_data.int, second_data.string });

    const entry1 = FileSystemEntry{ .file = .{ .name = "report.txt", .size = 4096 } };
    const entry2 = FileSystemEntry{ .directory = .{ .name = "photos", .children = 120 } };
    entry1.describe();
    entry2.describe();

    const shortcut_union_with_enum = Message{ .number = 100 };
    std.debug.print("shortcut union with enum: {}", .{shortcut_union_with_enum.number});
}

// 🔹 Struct = Laci dengan banyak kotak
//
// Bayangin kamu punya lemari kecil.
//
// Ada laci buat buku, laci buat baju, laci buat sepatu.
//
// Semua laci ada terus, jadi kamu bisa simpan buku, baju, dan sepatu sekaligus.
//
// Tapi karena semua laci ada, lemari itu jadi lebih gede.
//
// 👉 Ini kayak struct: semua variabel hidup barengan, jadi butuh ruang lebih banyak.
//
// 🔹 Union = Satu kotak serbaguna
//
// Sekarang bayangin kamu punya satu kotak aja.
//
// Kadang isinya buku, kadang diganti jadi baju, kadang jadi sepatu.
//
// Kotak itu ukurannya disesuaikan sama barang yang paling besar (misalnya sepatu).
//
// Jadi hemat ruang, tapi jelas kamu nggak bisa simpan buku+baju+sepatu sekaligus. Harus pilih salah satu.
//
// 👉 Ini kayak union: semua variabel numpang tempat di ruang yang sama, jadi hemat memori, tapi cuma bisa aktif satu waktu.
