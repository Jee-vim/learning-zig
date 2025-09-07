//3️⃣ Analogi gampang
//
// Bayangin allocator itu “bank memory”:
// Kamu minta uang (memory) → bank kasih (alloc)
// Selesai pakai → balikin ke bank (free)
//
// Ada jenis bank berbeda:
// PageAllocator → ATM langsung tarik dari sistem
// GPA → bank umum fleksibel
// Arena → kasir sekali bagi, bisa reset semua sekaligus
//
// +------------------------+--------------------------+-----------------------------+
// | Allocator              | Kelebihan                | Kekurangan / Catatan         |
// +------------------------+--------------------------+-----------------------------+
// | std.heap.page_allocator | - Siap pakai langsung   | - Tidak fleksibel            |
// |                        | - Cocok untuk alokasi    | - Lebih lambat untuk banyak  |
// |                        |   besar / sementara      |   alokasi kecil              |
// +------------------------+--------------------------+-----------------------------+
// | GeneralPurposeAllocator | - Fleksibel             | - Perlu inisialisasi         |
// | (GPA)                  | - Bisa free tiap alokasi | - Sedikit overhead per alloc |
// |                        | - Thread-safe (opsional) |                             |
// +------------------------+--------------------------+-----------------------------+
// | ArenaAllocator          | - Cepat untuk banyak    | - Tidak bisa free per item   |
// |                        |   alokasi kecil         | - Harus reset untuk bersihin |
// |                        | - Reset sekaligus       |                             |
// |                        | - Bagus untuk memory    |                             |
// |                        |   sementara / batch     |                             |
// +------------------------+--------------------------+-----------------------------+
// Intinya:
// PageAllocator → “langsung pakai” untuk alokasi besar atau sekali pakai.
// GPA → fleksibel, alokasi & free per item, cocok untuk program umum.
// Arena → cepat untuk alokasi sementara banyak item, bersih sekaligus dengan reset().
//
//
// try alocator.alloc(u8, 10);
// [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ] [ 0 ]
//   ^    ^
//   u8   nilai maksimal per kotak = 255
//   dan panjang array nya 10

const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const file = try std.fs.cwd().openFile("./union.zig", .{});
    defer file.close();
    const stat = try file.stat();
    const file_size = stat.size;

    const buf = try allocator.alloc(u8, file_size);
    defer allocator.free(buf);

    _ = try file.readAll(buf);
    std.debug.print("./union.zig:\n{s}\n", .{buf});
}
