const std = @import("std");
const SocketConf = @import("config.zig");
const Request = @import("request.zig");

pub fn main() !void {
    const socket = try SocketConf.Socket.init();
    std.debug.print("server address: {any}\n", .{socket._address});
    var server = try socket._address.listen(.{});
    const connection = try server.accept();

    var buffer: [1000]u8 = undefined; // why i use undefined, cause fastest (but unsaafe if u read before writing)
    for (0..buffer.len) |val| buffer[val] = 0;

    _ = try Request.readRequest(connection, buffer[0..buffer.len]);
    std.debug.print("{s}", .{buffer});
}
