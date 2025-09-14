# Common Causes of Segmentation Faults

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

---

## Quick Distinction
- **Case 1** → The memory *was valid*, but is now dead.  
- **Case 2** → The memory *was never valid* in the first place.  
- **Case 3** → The memory is valid, but you *step outside its boundaries*.  

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

---

### Quick Distinction
- **Case 1** → Forgot `&` when function expects a pointer.  
- **Case 2** → Used `const mem.Allocator` where mutation is expected.  
- **Case 3** → Added `&` too many times.  
