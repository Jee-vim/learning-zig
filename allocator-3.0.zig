const std = @import("std");

pub fn main() !void {
    const word = "hello world";
    var buffer: [15]u8 = undefined;
    for (0..buffer.len) |i| {
        buffer[i] = 0; // Initialize to zero
    }
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const input = try allocator.alloc(u8, word.len);
    defer allocator.free(input);

    std.mem.copyForwards(u8, input, word);
    std.debug.print("{s}\n", .{input});

    for (buffer, 0..) |value, i| {
        std.debug.print("{d}.{d} \n", .{ i, value });
    }
}
