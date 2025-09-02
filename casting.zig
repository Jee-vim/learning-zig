const std = @import("std");

pub fn main() void {
    const int: u8 = 100;
    const int_float: f16 = @as(f16, int);

    std.debug.print("value int {}\n", .{int});
    std.debug.print("value int float {}\n", .{int_float});

    const val_f16: f32 = 22.50;
    const val_u16: u16 = @intFromFloat(val_f16);
    std.debug.print("\ncasting type f16 {} ke u16 {}\n", .{ val_f16, val_u16 });

    const val_i32: i32 = 100;
    const val_u8: u8 = @intCast(val_i32);
    std.debug.print("\ncasting type i32 ke u8 {}\n", .{val_u8});
}
