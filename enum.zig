const std = @import("std");

const Menu = enum { Chicken, Rice, Noodle };
const StatusMenu = enum(u16) { Ok = 200, NotFound = 404, Error = 500 };
const Compas = enum {
    North,
    South,
    East,
    West,

    // using fn
    pub fn reverse(compas: Compas) Compas {
        // access using struct with switch case
        return switch (compas) {
            .North => .South,
            .South => .North,
            .East => .West,
            .West => .East,
        };
    }
};

const Mode = enum(u8) { Off, On, Sleep };

const StatusOrder = enum {
    Pending,
    Success,
    Paid,
    Cancel,

    pub fn cancelOrder(status: StatusOrder) bool {
        return switch (status) {
            .Pending, .Paid => true,
            .Success, .Cancel => false,
        };
    }
};

pub fn main() !void {
    const menu = Menu.Chicken;
    const status_menu = StatusMenu.Error;
    const compas = Compas.reverse(.North);
    const status_order = StatusOrder.Success;
    const mode: Mode = @enumFromInt(1);
    const all_mode = @typeInfo(Mode);

    std.debug.print("menu: {s}\n", .{@tagName(menu)}); // tag name untuk mengubah jadi string
    std.debug.print("status menu: {}\n", .{@intFromEnum(status_menu)});
    std.debug.print("reverse North is: {s}\n", .{@tagName(compas)});
    std.debug.print("mode is: {}\n", .{@tagName(mode)});
    inline for (all_mode.@"enum".fields) |field| { // ERROR this
        std.debug.print("mode name : {any}, mode value: \n", .{field.name});
    }

    if (status_order.cancelOrder()) {
        std.debug.print("status order: ({s}), enable cancel order: true \n", .{
            @tagName(status_order),
        });
    } else std.debug.print("status order: ({s}), enable cancel order: false \n", .{
        @tagName(status_order),
    });
}
