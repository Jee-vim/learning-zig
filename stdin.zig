const std = @import("std");

fn inputNumber() !void {
    const stdin = std.io.getStdIn().reader();
    var buffer: [100]u8 = undefined;

    std.debug.print("input a number: ", .{});
    const input = try stdin.readUntilDelimiterOrEof(&buffer, '\n'); // it will read until end of line which is \n (Enter/New Line)

    if (input) |val| {
        // 2 = binnary
        // 16 = hexadecimal
        // 10 = decimal
        const number = std.fmt.parseInt(u8, val, 2) catch |err| {
            return std.debug.print("invalid input : {}\n", .{err});
        };
        std.debug.print("u type: {}\n", .{number});
    } else {
        std.debug.print("no input\n", .{});
    }
}

fn inputString() !void {
    const stdin = std.io.getStdIn().reader();
    var buffer: [100]u8 = undefined;

    std.debug.print("\ninput name: ", .{});
    const input = try stdin.readUntilDelimiterOrEof(&buffer, '\n');

    // cannot directly use optional values which is var input
    // this why i need to put |val| cause it guaranteed non-null
    if (input) |val| {
        if (val.len == 0) {
            std.debug.print("u didin't type anything\n", .{});
        } else {
            std.debug.print("hello {s}\n", .{val});
        }
    } else {
        std.debug.print("no input\n", .{});
    }
}

pub fn main() !void {
    try inputNumber();
    try inputString();
}
