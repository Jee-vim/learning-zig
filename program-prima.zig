const std = @import("std");

pub fn main() !void {
    var idx: u8 = 1;

    while (idx < 100) : (idx += 1) {
        if (idx % 2 == 0) {
            std.debug.print("prime: {}\n", .{idx});
        }
    }
}
