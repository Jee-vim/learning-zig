// v = s /t
//
// v = speed
// s = how far (km)
// t = duration
const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    var buffer: [100]u8 = undefined;
    const stdout = std.io.getStdIn().writer();

    // using stdout is for I/O (can save to a file) and always use try
    try stdout.print("how far(km) : ", .{});
    const input_how_far = try stdin.readUntilDelimiterOrEof(&buffer, '\n');
    const how_far = if (input_how_far) |val| try std.fmt.parseFloat(f32, val) else {
        std.debug.print("input not valid \n", .{});
        return;
    };

    try stdout.print("duration(hour) : ", .{});
    const input_duration = try stdin.readUntilDelimiterOrEof(&buffer, '\n');
    const duration = if (input_duration) |val| try std.fmt.parseFloat(f32, val) else {
        std.debug.print("input duration not valid \n", .{});
        return;
    };

    // prevent zero division
    if (duration == 0) {
        std.debug.print("duration cannot be 0", .{});
    }

    const speed = how_far / duration;
    std.debug.print("calculation speed: {} km/hour\n", .{speed});
}
