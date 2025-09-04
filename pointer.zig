const std = @import("std");

const People = struct { name: []const u8, age: u8 };

pub fn main() !void {
    var numb: i32 = 40;
    const numb_ptr: *i32 = &numb;
    std.debug.print("value from numb is: {}\n", .{numb_ptr.*});
    numb_ptr.* = 100;
    std.debug.print("value from numb now is: {}\n\n", .{numb_ptr.*});

    const maybe_ptr: ?*i32 = null;
    if (maybe_ptr) |ptr| {
        std.debug.print("this pointer has value {}\n", .{ptr.*});
    } else {
        std.debug.print("this pointer is empty\n\n", .{});
    }

    var jhon = People{ .name = "jhon", .age = 22 }; // stack var (no need to free)
    const jhon_ptr: *People = &jhon;
    std.debug.print("name: {s}\n", .{jhon_ptr.name});
    jhon_ptr.*.name = "asep";
    std.debug.print("change name to: {s}\n\n", .{jhon_ptr.name});

    std.debug.print("pointer to heap:\n", .{});
    var allocator = std.heap.page_allocator; // heap var (must destroy when done)
    const ucup = try allocator.create(People);
    const udin = try allocator.create(People);
    ucup.* = People{ .name = "Ucup", .age = 26 };
    udin.* = People{ .name = "Udin", .age = 20 };
    std.debug.print("name: {s}\n", .{ucup.name});
    std.debug.print("name: {s}, age: {d}\n", .{ udin.name, udin.age });
    allocator.destroy(ucup); // destroy ucup
    allocator.destroy(udin); // destroy udin
    // If you allocator.create but forget to allocator.destroy,
    // the memory you got from the allocator is never returned → memory leak.

    var our_arr = [_]i32{ 1, 2, 3, 4, 5 };
    const our_arr_slice: []i32 = &our_arr;
    std.debug.print("idx 2 from arr is {}\n", .{our_arr_slice[2]});
}
