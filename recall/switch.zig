const std = @import("std");

fn ifStatment(val: i8) void {
    if (val < 0) {
        std.debug.print("Negative\n", .{});
    } else if (val == 0) {
        std.debug.print("zero\n", .{});
    } else {
        std.debug.print("positiive\n", .{});
    }
}

fn switcher() void {
    const val = -22;
    switch (val) {
        -100...-1 => std.debug.print("negative\n", .{}),
        0 => std.debug.print("zero\n", .{}),
        1...100 => std.debug.print("positive\n", .{}),
        else => std.debug.print("non of it reach the case", .{}),
    }
}

pub fn main() !void {
    _ = ifStatment(5);
    _ = ifStatment(-5);
    _ = ifStatment(0);
    _ = switcher();
    _ = switcher();
    _ = switcher();
}
