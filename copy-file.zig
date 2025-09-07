const std = @import("std");

pub fn main() !void {
    try std.fs.cwd().copyFile("../union.zig", std.fs.cwd(), "copy.zig", .{});
    std.debug.print("copy union.zig to copy.zig success", .{});
    try std.fs.cwd().rename("copy.zig", "renamed-copy.zig");
    std.debug.print("renamed copy.zig to renamed-copy.zig success", .{});
}
