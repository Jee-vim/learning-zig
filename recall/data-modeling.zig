const std = @import("std");

const UserStruct = struct { id: i32, active: bool };

pub fn main() !void {
    const user1 = UserStruct{ .id = 2121, .active = true };
    // const user2 = UserStruct{ .id = 2121, .active = true };
    std.debug.print("id: {}, active: {}", .{ user1.id, user1.active });
}
