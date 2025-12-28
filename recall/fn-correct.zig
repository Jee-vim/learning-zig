const std = @import("std");

fn add(a: u8, b: u8) u8 {
    const sum = @addWithOverflow(a, b); // safe overflow
    // sum[0] result
    // if result  overflow  it  will  return the overflow int ex: 255+5 = 260 the overflow int is 4 so it will return 4
    // sum[1] true/false  (1/0) flag
    return sum[0];
}

pub fn main() !void {
    const a: u8 = 5;
    const b: u8 = 255;
    std.debug.print("{}", .{add(a, b)});
}
