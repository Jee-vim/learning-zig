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
