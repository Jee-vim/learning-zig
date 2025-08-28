const std = @import("std");

pub fn main() !void {
    const case = 25;

    switch (case) {
        1 => std.debug.print("this case 1\n", .{}),
        2 => std.debug.print("this case 2\n", .{}),
        4, 5, 6, 7, 8 => std.debug.print("this case 4,5,6,7,8\n", .{}), // multiple value
        10...50 => std.debug.print("this case 10...50\n", .{}), // range value
        else => std.debug.print("case numb not valid", .{}),
    }
}
