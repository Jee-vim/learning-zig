const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = try std.ArrayList(u8).initCapacity(allocator, 5); // create an array with max len of 5
    defer list.deinit(allocator);

    try list.append(allocator, 50); // assign idx 0 with 1
    try list.append(allocator, 80);
    std.debug.print("len: {}, cap: {}, val idx 0: {}\n", .{ list.items.len, list.capacity, list.items[0] }); // 2, 5, 50

    var list_name = try std.ArrayList([]const u8).initCapacity(allocator, 10);
    defer list_name.deinit(allocator);

    try list_name.append(allocator, "A");
    try list_name.append(allocator, "B");
    try list_name.append(allocator, "C");
    try list_name.append(allocator, "DE");
    std.debug.print("\nprint all list_name value\n", .{});
    for (list_name.items, 0..) |value, i| {
        std.debug.print("{d}: {s}\n", .{ i, value });
    }
}
