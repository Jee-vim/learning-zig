const std = @import("std");

// struct need to start with Pascal case
const Address = struct {
    // zig tidak ada "string" tipe bawaan, string cuma dianggap sebagai array of bytes (u8).
    street: []const u8,
    city: []const u8,
};
const Profile = struct {
    name: []const u8,
    age: u8,
    is_student: bool = false,
    address: Address,

    pub fn information(user: Profile) void {
        std.debug.print("\nusing fn inside struct\n", .{});
        std.debug.print("name: {s}\nage: {}\n", .{ user.name, user.age });
    }
};

const CalculateArea = struct {
    length: u16,
    width: u16,
    pub fn calculate_area(area: CalculateArea) u16 {
        return area.length * area.width;
    }
};
pub fn main() !void {
    const jhon = Profile{ .name = "Jhon", .age = 28, .is_student = false, .address = Address{ .street = "st. S Hatta 25", .city = "Bandung" } };
    const area = CalculateArea{ .width = 6, .length = 14 };

    std.debug.print("name : {s}\n", .{jhon.name});
    std.debug.print("steet address user: {s}\n", .{jhon.address.street});
    Profile.information(jhon);
    std.debug.print("\narea is: {} km\n ", .{CalculateArea.calculate_area(area)});
}
