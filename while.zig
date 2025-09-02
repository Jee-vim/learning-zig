const std = @import("std");

pub fn main() void {
    whileFn();
    whileContinueExpression();
    whileContinue();
    whileBreak();
}

fn whileFn() void {
    std.debug.print("\nwhile \n", .{});
    var i: u8 = 2;
    while (i < 100) {
        i *= 2;
        std.debug.print("result {}\n", .{i});
    }
}
fn whileContinueExpression() void {
    std.debug.print("\nwhile with continue expression \n", .{});
    var sum: u8 = 0;
    var i: u8 = 1;
    while (i <= 10) : (i += 1) {
        sum += i;
        std.debug.print("result sum {} and i {}\n", .{ sum, i });
    }
}
fn whileContinue() void {
    std.debug.print("\nwhile with continue \n", .{});
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) {
            std.debug.print("reach 2, do some thing here\n", .{});
            continue;
        }
        sum += i;
        std.debug.print("result {}\n", .{sum});
    }
}
fn whileBreak() void {
    std.debug.print("\nwhile with break \n", .{});
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i <= 3) : (i += 1) {
        if (i == 2) {
            std.debug.print("reach 2, do some thing here\n", .{});
            break;
        }
        sum += i;
        std.debug.print("result {}\n", .{sum});
    }
}
