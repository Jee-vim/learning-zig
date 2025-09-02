const std = @import("std");

pub fn main() void {
    defer std.debug.print("should be print after all done\n", .{});
    std.debug.print("hello world\n", .{});

    var numb: u8 = 10;
    defer numb += 10;
    std.debug.print("numb=10, defer numb + 10, numb value: {}\n", .{numb});

    // multi deffer
    defer std.debug.print("will be print reverse 2\n", .{});
    defer std.debug.print("will be print reverse 1\n", .{});
}
