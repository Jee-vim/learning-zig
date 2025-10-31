const std = @import("std");
const AutoHashMap = std.hash_map.AutoHashMap;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var auto_map = AutoHashMap(u16, u8).init(allocator);
    defer auto_map.deinit();

    try auto_map.put(55, 10);
    try auto_map.put(56, 20);
    try auto_map.put(58, 30);
    try auto_map.put(62, 40);

    std.debug.print("total value stored {}\n", .{auto_map.count()});
    std.debug.print("value key 55 is {}\n", .{auto_map.get(55).?}); // always using .? cz get is optional
    if (auto_map.remove(56)) {
        std.debug.print("value key 56 successfully removed\n", .{});
    }
    std.debug.print("total value stored {}\n", .{auto_map.count()});

    // iterating
    std.debug.print("\niterating\n", .{});
    var it = auto_map.iterator(); // must var
    while (it.next()) |kv| {
        std.debug.print("key: {}, value: {}\n", .{ kv.key_ptr.*, kv.value_ptr.* });
    }

    // iterate only key
    std.debug.print("\niterate only key\n", .{});
    var kit = auto_map.keyIterator();
    while (kit.next()) |key| {
        std.debug.print("Key: {d}\n", .{key.*});
    }
}

// hashmap / hashtable  ada beberapa type
// 1. autoHashMap (urutan acak, hash table, ukuran kecil)
// 2. autoArrayHashMap (sesuai urutan penambahan, hash table+array, lebih besar)
