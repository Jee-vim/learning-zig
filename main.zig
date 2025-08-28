const std = @import("std");

pub fn main() void {
    const number:u8 = 65;
    const letter:u8 = 'A';
    const name: []const u8 = "yaues";
    std.debug.print("number: {d}\nletter: {c}\nletter number:{}\nname: {s}\nname index: {c}\n", .{number, letter, letter, name, name[0]});

    const biner:u8 = 0b1101_11;
    std.debug.print("biner value: {}", .{biner});
}
