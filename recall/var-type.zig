const std = @import("std");

pub fn main() !void {
    const a: i32 = 10;
    const b: u32 = 20;
    const b_u32: u32 = @intCast(b);

    std.debug.print("result {}", .{a + b_u32});
}
