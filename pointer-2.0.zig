const std = @import("std");

fn withoutPtr(x: u32) void {
    const y = x + 5;
    std.debug.print("inside fn: {}\n", .{y});
}
fn withPtr(x: *u32) void {
    x.* += 5;
    std.debug.print("inside fn ptr: {}\n", .{x.*});
}
pub fn main() !void {
    var a: u32 = 5;
    std.debug.print("real value a: {}\n", .{a});
    withoutPtr(a);
    std.debug.print("after fn: {}\n", .{a}); // still 5

    withPtr(&a);
    std.debug.print("after fn ptr: {}\n", .{a});
    // now 10, because withPtr() modified `a` through pointer
}
