const std = @import("std");
const Allocator = std.mem.Allocator;
const Stack = struct {
    items: []u32,
    capacity: usize,
    length: usize,
    allocator: Allocator,

    pub fn init(alloctor: Allocator, capacity: usize) !Stack {
        var buf = try alloctor.alloc(u32, capacity);
        return .{
            .items = buf[0..],
            .capacity = capacity,
            .length = 0,
            .allocator = alloctor,
        };
    }

    pub fn deinit(self: *Stack) void {
        self.allocator.free(self.items);
    }

    pub fn push(self: *Stack, val: u32) !void {
        if ((self.length + 1) > self.capacity) {
            var new_buf = try self.allocator.alloc(u32, self.capacity * 2);
            // copy old items into the first portion of new_buf
            @memcpy(new_buf[0..self.capacity], self.items);
            self.allocator.free(self.items);
            self.items = new_buf;
            self.capacity = self.capacity * 2;
        }

        self.items[self.length] = val;
        self.length += 1;
    }

    pub fn pop(self: *Stack) void {
        if (self.length == 0) return;
        // set undefined to indicate this el is "empty"
        // and decrease the length
        self.items[self.length - 1] = undefined;
        self.length -= 1;
    }
};

// generic stack structure
fn GenStack(comptime T: type) type {
    return struct {
        items: []T,
        capacity: usize,
        length: usize,
        allocator: Allocator,
        const Self = @This();

        pub fn init(alloctor: Allocator, capacity: usize) !GenStack(T) {
            var buf = try alloctor.alloc(T, capacity);
            return .{
                .items = buf[0..],
                .capacity = capacity,
                .length = 0,
                .allocator = alloctor,
            };
        }

        pub fn deinit(self: *GenStack(T)) void {
            self.allocator.free(self.items);
        }

        pub fn push(self: *GenStack(T), val: T) !void {
            if ((self.length + 1) > self.capacity) {
                var new_buf = try self.allocator.alloc(T, self.capacity * 2);
                @memcpy(new_buf[0..self.capacity], self.items);
                self.allocator.free(self.items);
                self.items = new_buf;
                self.capacity = self.capacity * 2;
            }

            self.items[self.length] = val;
            self.length += 1;
        }

        pub fn pop(self: *GenStack(T)) void {
            if (self.length == 0) return;
            self.items[self.length - 1] = undefined;
            self.length -= 1;
        }
    };
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    const Stacku8 = GenStack([]const u8);
    var stack = try Stacku8.init(allocator, 10);
    defer stack.deinit();
    try stack.push("ab");
    try stack.push("cd");
    try stack.push("ef");
    try stack.push("gh");

    std.debug.print("stack len: {}\n", .{stack.length});
    std.debug.print("stack cap: {}\n", .{stack.capacity});
    stack.pop();
    std.debug.print("stack len: {}\n", .{stack.length});
    stack.pop();
    std.debug.print("stack cap: {}\n\n", .{stack.capacity});
    for (stack.items, 0..) |value, i| {
        std.debug.print("{d}. {s}\n", .{ i, value });
    }
    std.debug.print("\nstack len: {}\n", .{stack.length});
}
