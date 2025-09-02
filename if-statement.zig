const std = @import("std");

pub fn main() void {
    const a = true;
    var b:u8 = 0;
    var c:u8 = 0;

    // if statment
    if(a){
        b+=1;
    }
    else b+=2;

    // if statment expression
    c+= if (!a) 1 else 2;


    std.debug.print("result {}\n", .{b});
    std.debug.print("result expression {}", .{c});
}
