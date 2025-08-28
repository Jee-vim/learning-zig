const std = @import("std");

pub fn main() void {
    const angka = [_]i32{1,2,3,4,5};
    for (angka) |new_var| {
        std.debug.print("{}\n", .{new_var});
    }

    // other way
    for (1..9) |new_var| {
        std.debug.print("{}", .{new_var});
    }

    // continue and break
    for (1..9) |new_var| {
        if(new_var == 3){
            std.debug.print("already reach 3", .{});
            continue;
        }
        if(new_var == 7){
            std.debug.print("stop at 7", .{});
            break;
        }
        std.debug.print("\n{}\n", .{new_var});
    }
    
}
