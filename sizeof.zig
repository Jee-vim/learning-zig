const std = @import("std");

pub fn main() !void {
    const alocator = std.heap.page_allocator;
    const size_element = @sizeOf(u32);
    const total_size = size_element * 10;

    const buffer = try alocator.alloc(u8, total_size);
    defer alocator.free(buffer);

    std.debug.print("alocation {d} byte", .{total_size});
}
