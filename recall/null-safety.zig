const std = @import("std");
fn findEven(n: i32) ?i32 {
    if (@rem(n, 2) == 0) return n;
    return null;
}

pub fn main() !void {
    std.debug.print("{any}", .{findEven(21)});
}
