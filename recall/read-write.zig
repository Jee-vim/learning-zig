const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = try std.ArrayList(u8).initCapacity(allocator, 11);
    defer list.deinit(allocator);
    _ = try list.writer(allocator).write("Hello world");

    for (list.items) |val| {
        std.debug.print("{},", .{val});
    }
}
