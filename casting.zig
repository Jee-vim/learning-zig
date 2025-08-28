const std = @import("std");

pub fn main() void {
    const int:u8 = 100;
    const int_float:f16 = @as(f16, int);

    std.debug.print("value int {}\n", .{int});
    std.debug.print("value int float {}\n", .{int_float});
}
