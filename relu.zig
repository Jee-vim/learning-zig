const std = @import("std");

// ReLU = Rectified Linear Unit
// fungsi aktivasi yang sering dipakai di neural network.
//
// Sederhana → gampang dihitung.
// Bikin model bisa non-linear (penting di deep learning).
// Tidak menghancurkan nilai positif, tapi “membuang” nilai negatif jadi 0.
//
// Singkatnya:
// ReLU itu fungsi aktivasi yang dipakai buat nge-“hidupin” nilai positif dan matiin nilai negatif.

fn activationReLu(val_x:i8)i8 {
    return if (val_x > 0) val_x else 0;
}
pub fn main() void {
    const arr = [_]i8{-56, 0, 100, -22};
    for (arr) |i| {
        const output = activationReLu(i);
        std.debug.print("relu ({}) = {}\n", .{i, output});
    }
}
