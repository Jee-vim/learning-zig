// Zig introduces a new data structure called MultiArrayList(). It’s a different version of the dynamic array
const std = @import("std");
const Person = struct { name: []const u8, age: u8, height: f16 };
const PersonArray = std.MultiArrayList(Person);

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var people = PersonArray{};
    defer people.deinit(allocator);

    try people.append(allocator, .{ .name = "asep", .age = 22, .height = 170.5 });
    try people.append(allocator, .{ .name = "udin", .age = 12, .height = 150 });
    try people.append(allocator, .{ .name = "bambang", .age = 15, .height = 110.8 });

    for (people.items(.age)) |*val| {
        std.debug.print("name: {d}\n", .{val.*});
    }
}
