const std = @import("std");

// NOTE array dynamic on runtime
fn sum(numb: []i32) void {
    for (numb) |value| {
        if (value > 0) {
            std.debug.print("positive numb: {}\n", .{value});
        }
    }
}

// NOTE array sttic on comptime
fn sumStatic(numb: [5]i32) void {
    for (numb) |value| {
        if (value > 0) {
            std.debug.print("positive numb: {}\n", .{value});
        }
    }
}

pub fn main() !void {
    var arr = [_]i32{ -56, 0, 100, -22, 255 };
    _ = sum(arr[0..]);

    const arrStatic = [5]i32{ -56, 0, 100, -22, 255 };
    _ = sumStatic(arrStatic);
}
