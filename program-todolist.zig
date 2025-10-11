const std = @import("std");

const Todo = struct {
    items: std.ArrayList([]const u8),

    pub fn init(allocator: std.mem.Allocator) !Todo {
        const list = try std.ArrayList([]const u8).initCapacity(allocator, 20);
        return Todo{ .items = list };
    }

    pub fn deinit(self: *Todo) void {
        self.items.deinit();
    }

    pub fn add(self: *Todo, allocator: std.mem.Allocator, item: []const u8) !void {
        try self.items.append(allocator, item);
    }

    pub fn remove(self: *Todo, idx: usize) void {
        if (idx < self.items.items.len) {
            _ = self.items.orderedRemove(idx);
        }
    }

    pub fn showAll(self: *Todo) void {
        for (self.items.items, 0..) |task, i| {
            std.debug.print("{d}. {s}\n", .{ i, task });
        }
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var todo = try Todo.init(allocator);
    defer todo.deinit();

    try todo.add(allocator, "Learn Zig");
    try todo.add(allocator, "Build Todo List");
    try todo.add(allocator, "Profit!");

    std.debug.print("All Tasks ---\n", .{});
    todo.showAll();

    todo.remove(1);

    std.debug.print("Remove Todo idx 1 ---\n", .{});
    todo.showAll();
}
