const std = @import("std");
// All function arguments are immutable - if a copy is desired the user must explicitly make one.
fn add(x: u16) u16 {
    return x + 6;
}

// Recursion is allowed
fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// using const T
// means i can only access not modify the value
fn foo(comptime T: type, n: *const T) void {
    std.debug.print("{s} {n}\n", .{ @typeName(T), n });
}

pub fn main() void {
    const y = add(6);
    const other_y = add(4);
    std.debug.print("(6) \ny {}\nother_y {}\nfn itself {}\n", .{ y, other_y, add(2) });

    const x = fibonacci(10);
    std.debug.print("\nfn recursion {}\n", .{x});

    var z: f64 = 3.14;
    foo(f64, &z);
}
