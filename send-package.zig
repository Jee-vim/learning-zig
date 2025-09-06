const std = @import("std");

const ErrorShipping = error{ InvalidAddress, InvalidWeight, ServerError };
const Status = enum { Pending, InTransit, Delivered, Failed };

const Package = struct {
    name: []const u8,
    address: []const u8,
    weight: u8,
    status: Status,

    pub fn updateStatus(package: *Package, newStatus: Status) void {
        // NOTE:
        // package: *Package artinya function menerima POINTER ke struct Package
        // Tanpa *, function cuma akan mengubah COPY lokal → struct asli tidak berubah
        // Dengan *, function bisa langsung mengubah struct asli di memori
        package.status = newStatus;
    }
};

fn sendPackage(package: *Package) ErrorShipping!void {
    // input validation
    if (package.address.len == 0) {
        package.updateStatus(.Failed);
        return ErrorShipping.InvalidAddress;
    }
    if (package.weight == 0) {
        package.updateStatus(.Failed);
        return ErrorShipping.InvalidWeight;
    }

    // proses pengiriman
    package.updateStatus(.InTransit);

    // simulasi kemungkinan error server
    if (std.crypto.random.int(u8) % 10 == 0) {
        package.updateStatus(.Failed);
        return ErrorShipping.ServerError;
    }

    package.updateStatus(.Delivered);
}

fn formatStatus(status: Status) []const u8 {
    switch (status) {
        .Pending => return "Pending",
        .InTransit => return "In Transit",
        .Delivered => return "Delivered",
        .Failed => return "Failed",
    }
}

pub fn main() !void {
    var package = Package{
        .name = "Phone",
        .address = "St. Soekarnoe 666",
        .weight = 8,
        .status = .Pending,
    };

    std.debug.print("Starting shipment...\n", .{});

    sendPackage(&package) catch |err| {
        std.debug.print(
            "Shipment package {s} failed, reason: {s}\n",
            .{ package.name, @errorName(err) },
        );
    };
    std.debug.print("Package '{s}' → status: {any}\n", .{ package.name, package.status }); // raw
    std.debug.print("Package '{s}' → status: {s}\n", .{ package.name, formatStatus(package.status) }); // formatted status
}
