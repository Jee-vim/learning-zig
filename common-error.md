# Segmentation Faults at address

1. **Invalid memory (use-after-free)**  
   - The pointer refers to memory that was already `free`d or went out of scope.  
   - Example: freeing a buffer and then still trying to read/write it.  

2. **Unallocated memory (null / uninitialized pointer)**  
   - The pointer is `NULL` (0x0) or uninitialized (garbage address).  
   - Dereferencing it leads to an immediate crash.  

3. **Wrong access (out-of-bounds / overflow)**  
   - Accessing beyond the allocated size of a buffer or array.  
   - Miscalculating the size during allocation.  
   - Writing more data than the buffer can hold.  

## Quick Distinction
- **Case 1** → The memory *was valid*, but is now dead.  
- **Case 2** → The memory *was never valid* in the first place.  
- **Case 3** → The memory is valid, but you *step outside its boundaries*.  

---

# expected *mem.Allocator, found const mem.Allocator

1. **Passing a value instead of a pointer**  
   - You wrote `allocator` instead of `&allocator`.  
   - Example:  
     ```zig
     fn foo(alloc: *std.mem.Allocator) void { }
     foo(gpa.allocator); // ❌ wrong
     foo(&gpa.allocator); // ✅ correct
     ```

2. **Mixing `const mem.Allocator` with `*mem.Allocator`**  
   - Some APIs want a pointer (`*mem.Allocator`) to mutate or manage allocations.  
   - If you pass a `const mem.Allocator`, the compiler blocks it.  

3. **Double referencing (`&` when already a pointer)**  
   - Writing `&&gpa.allocator` gives you `**mem.Allocator`, which doesn’t match.  

3. **Using const instead of var**  

### Quick Distinction
- **Case 1** → Forgot `&` when function expects a pointer.  
- **Case 2** → Used `const mem.Allocator` where mutation is expected.  
- **Case 3** → Added `&` too many times.  

4.[expected type *T fund *const T](https://ziggit.dev/t/what-does-error-expected-type-t-found-const-t-mean-where-t-is-some-type/1320) 

---

# Ignored Return Value / Non-Void Value Error in Zig

1. **Function returns a value but it’s not used**  
   - In Zig, all functions that return a non-void value must have their return value either **used** or **explicitly discarded**.  
   - Example:
     ```zig
     const result = someFunction(); // ✅ value used
     someFunction();                // ❌ value ignored → compiler error
     ```

2. **Discarding a value intentionally**  
   - If you don’t need the returned value, assign it to `_` to explicitly discard it.
   - Example:
     ```zig
     _ = someFunction(); // ✅ explicitly discarding
     ```

3. **Function should return void if you don’t need a value**  
   - If your function is only performing side effects (like printing or logging) and you don’t care about a return value, make it return `void` instead of `![]u8` or any other type.  
   - Example:
     ```zig
     fn printLowercase(name: []const u8) !void {
         const buf = try allocator.alloc(u8, name.len);
         defer allocator.free(buf);
         std.ascii.toLower(buf, name);
         std.debug.print("{s}\n", .{buf});
     }
     ```

## Quick Distinction
- **Case 1** → The function returns a value, and you *didn’t use it*.  
- **Case 2** → You *want to ignore it intentionally*, assign it to `_`.  
- **Case 3** → The function should return `void` if no value is needed; avoids compiler complaints.

---


# consider omitting try
'it's a compiler hint` it show up when u have a fn that actually didn't return erorr
1. Example
```zig

fn foo() void {}
pub fn main() !void {
    try foo(); // note: expected type '!void', found 'void'
}
```

# remainder division with 'i32' and 'comptime_int': signed integers and floats must use @rem or @mod
error message indicates that you are trying to perform a remainder division
using the % operator with signed integers and a compile-time integer. 
In Zig, this operation is not allowed for signed integers.
