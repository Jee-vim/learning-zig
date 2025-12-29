const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const buffer = try allocator.alloc(u8, 10);
    defer allocator.free(buffer);

    // init val
    for (buffer, 0..) |*value, id| {
        value.* = @intCast(id);
    }

    for (buffer) |value| {
        std.debug.print("{},", .{value});
    }
}
