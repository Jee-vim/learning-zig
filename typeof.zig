const std = @import("std");

// @TypeOf ini paling kepake kalau bikin generic function dengan anytype,
fn add(foo: anytype, bar: @TypeOf(foo)) @TypeOf(foo) {
    const T = @TypeOf(foo);
    std.debug.print("type: {s}\n", .{@typeName(T)});
    return foo + bar;
}

pub fn main() !void {
    // atau kalo pengen binding variabel lain supaya tipe-nya selalu ikut satu variabel utama.
    const a: u8 = 10;
    const b: @TypeOf(a) = 20;
    const c: f16 = 2.5;

    std.debug.print("u8 : {d}\n", .{add(a, b)});
    std.debug.print("f16 : {d}\n", .{add(c, 2.5)});
}
