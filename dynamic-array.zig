const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var buffer = try std.ArrayList(u8).initCapacity(allocator, 100);
    defer buffer.deinit(allocator);

    try buffer.append(allocator, 'H');
    try buffer.append(allocator, 'a');
    try buffer.append(allocator, 'A');
    try buffer.appendSlice(allocator, "Yoho");

    _ = buffer.orderedRemove(2); // rmv A
    try buffer.insert(allocator, 2, 'B'); // insert at specifix idx
    try buffer.insertSlice(allocator, 3, "Yaw"); // insert at specifix idx
    for (buffer.items, 0..) |value, i| {
        std.debug.print("{d}: {d} ({c})\n", .{ i, value, value });
    }
}
