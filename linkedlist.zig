// reference: https://pedropark99.github.io/zig-book/Chapters/09-data-structures.html
// there are 2 linkedlist (Singlylinked and Doublylinked)
const std = @import("std");
const NodeU32 = struct {
    data: u32,
    node: std.SinglyLinkedList.Node = .{},
};

pub fn main() !void {
    var list: std.SinglyLinkedList = .{};

    // setting the data
    var one: NodeU32 = .{ .data = 1 };
    var two: NodeU32 = .{ .data = 2 };
    var three: NodeU32 = .{ .data = 3 };
    var four: NodeU32 = .{ .data = 4 };
    var five: NodeU32 = .{ .data = 5 };

    // connect data betwen node
    list.prepend(&two.node); // {2}
    list.prepend(&five.node); // {2, 5}
    list.prepend(&three.node); // {2, 3, 5}
    list.prepend(&one.node); // {1, 2, 3, 5}
    three.node.insertAfter(&four.node);

    std.debug.print("len {}\n", .{list.len()});
    _ = list.popFirst();
    std.debug.print("removed first node, now len is {}", .{list.len()});

    // iterating
    std.debug.print("\n", .{});
    var it = list.first;
    while (it) |node| : (it = node.next) {
        const l: *NodeU32 = @fieldParentPtr("node", node);
        std.debug.print("curr value: {}\n", .{l.data});
    }

    // Doublylinkedlist
    // list.append(&one.node); // {1}
    // list.append(&three.node); // {1, 3}
    // list.insertAfter(
    //     &one.node,
    //     &five.node
    // ); // {1, 5, 3}
    // list.append(&two.node); // {1, 5, 3, 2}
}
