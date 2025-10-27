const std = @import("std");
const AutoHashMap = std.hash_map.AutoHashMap;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var hash_table = AutoHashMap(u16, u8).init(allocator);
    defer hash_table.deinit();

    try hash_table.put(55, 10);
    try hash_table.put(56, 20);
    try hash_table.put(58, 30);
    try hash_table.put(62, 40);

    std.debug.print("total value stored {}\n", .{hash_table.count()});
    std.debug.print("value key 55 is {}\n", .{hash_table.get(55).?}); // always using .? cz get is optional
    if (hash_table.remove(56)) {
        std.debug.print("value key 56 successfully removed\n", .{});
    }
    std.debug.print("total value stored {}\n", .{hash_table.count()});

    // iterating
    std.debug.print("\niterating\n", .{});
    var it = hash_table.iterator(); // must var
    while (it.next()) |kv| {
        std.debug.print("key: {}, value: {}\n", .{ kv.key_ptr.*, kv.value_ptr.* });
    }

    // iterate only key
    std.debug.print("\niterate only key\n", .{});
    var kit = hash_table.keyIterator();
    while (kit.next()) |key| {
        std.debug.print("Key: {d}\n", .{key.*});
    }
}
