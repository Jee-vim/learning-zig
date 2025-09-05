const std = @import("std");

const ErrorMsg = error{
    WrongAddress,
    AddressNotClear,
    PackageLost,
};

fn sendPackage(adds: []const u8) ErrorMsg!void {
    if (adds.len == 0) {
        return ErrorMsg.WrongAddress;
    }
    if (adds.len < 5) {
        return ErrorMsg.AddressNotClear;
    } else {
        std.debug.print("package sending to your address.\n", .{});
    }
}

pub fn main() !void {
    sendPackage("st. soekarnoe hatta 26") catch |err| {
        std.debug.print("package not sending, error: {s}\n", .{@errorName(err)});
    };
    sendPackage("") catch |err| {
        std.debug.print("package 2 not sending, error: {s}\n", .{@errorName(err)});
    };
    sendPackage("bla") catch |err| {
        std.debug.print("package 3 not sending, error: {s}\n", .{@errorName(err)});
    };
}
