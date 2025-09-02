const std = @import("std");

pub fn main() void {
    const angka = [_]i32{ 1, 2, 3, 4, 5 };
    std.debug.print("normal\n", .{});
    for (angka, 0..) |new_var, index| {
        std.debug.print("value:{} index:{}\n", .{ new_var, index });
    }

    // other way
    std.debug.print("\n using reach\n", .{});
    for (1..9) |new_var| {
        std.debug.print("{}", .{new_var});
    }

    // continue and break
    std.debug.print("\n continue and break\n", .{});
    for (1..9) |new_var| {
        if (new_var == 3) {
            std.debug.print("already reach 3", .{});
            continue;
        }
        if (new_var == 7) {
            std.debug.print("stop at 7", .{});
            break;
        }
        std.debug.print("\n{}\n", .{new_var});
    }
}
