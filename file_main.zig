const std = @import("std");
const cnt = @import("file_sec.zig");

pub fn main() !void {
    const calculate = cnt.calculate(20, 2);
    std.debug.print("calculate : {d}\n", .{calculate});
    std.debug.print("fixed decimal is : {d}", .{cnt.FIXED_DEC});
}

