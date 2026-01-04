const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Heap allocation does NOT guarantee zero-initialized memory.
    // Use alloc() only if the buffer will be fully overwritten before any read.
    const buffAlloc = try allocator.alloc(u8, 5);
    defer allocator.free(buffAlloc);

    // Explicitly initialize every element to avoid reading undefined memory.
    // `id` is usize, so an explicit cast is required when assigning to u8.
    for (buffAlloc, 0..) |*value, id| {
        value.* = @intCast(id);
    }

    // Preferred way to zero-initialize a fixed-size stack array.
    // This is safer, clearer, and more optimizable than a manual loop or @memset.
    const buff = [_]u8{0} ** 5;

    // Avoid patterns like this unless there is a strong reason:
    // var buff: [5]u8 = undefined;
    // for (0..buff.len) |i| {
    //     buff[i] = 0;
    // }

    // @memset is appropriate for low-level memory operations.
    // On stack memory, use it only when:
    // - the size is determined at runtime, or
    // - the buffer already exists and must be reset.
    //
    // this below is wrong cz it reset to 0 not defined val 0
    var buffMemset: [5]u8 = undefined;
    @memset(buffMemset[0..], 0);

    for (buffAlloc) |value| {
        std.debug.print("buff alloc: {}\n", .{value});
    }
    for (buff) |value| {
        std.debug.print("buff: {}\n", .{value});
    }
    for (buffMemset) |value| {
        std.debug.print("buff memset: {}\n", .{value});
    }
}
// | Tujuan             | Cara benar        |
// | ------------------ | ----------------- |
// | Init awal stack    | `[_]u8{0} ** n`   |
// | Reset buffer byte  | `@memset(buf, x)` |
// | Set nilai non-byte | loop              |
// | Heap + zero        | `allocZeroed`     |
