const std = @import("std");
const cwd = std.fs.cwd();

pub fn main() !void {
    const nFile = try cwd.createFile("new-file.txt", .{});
    defer nFile.close();
    // _ = try nFile.writeAll("Helo new  write");  //  u can write imidetly
    const file = try cwd.openFile("./new-file.txt", .{ .mode = .write_only });
    defer file.close();

    try file.seekFromEnd(0);
    _ = try file.writeAll("Helo new  write");

    // try cwd.copyFile("./fn.zig", cwd, "./fn-copy.zig", .{});
    // try cwd.deleteFile("./fn-copy.zig");

    // read file
    var buffer: [300]u8 = undefined;
    @memset(buffer[0..], 0); // for initial memory

    try file.seekTo(0);
    var read_buffer: [1024]u8 = undefined;
    var fr = file.reader(&read_buffer);
    var reader = &fr.interface;
    _ = reader.readSliceAll(buffer[0..]) catch 0;
    std.debug.print("{s}", .{buffer});
}
