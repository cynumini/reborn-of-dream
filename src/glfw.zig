const std = @import("std");

pub const c = @cImport({
    @cDefine("GLFW_INCLUDE_VULKAN", {});
    @cInclude("GLFW/glfw3.h");
});

const ABI = struct {
    pub const GLFW_TRUE: i32 = 1;
    pub const GLFW_FALSE: i32 = 0;

    pub const GLFW_CLIENT_API: i32 = 0x00022001;
    pub const GLFW_RESIZABLE: i32 = 0x00020003;

    pub const GLFW_NO_API: i32 = 0;

    pub extern fn glfwCreateWindow(width: c_int, height: c_int, title: [*c]const u8, monitor: ?*Monitor, share: ?*Window) ?*Window;
    pub extern fn glfwDestroyWindow(window: ?*Window) void;
    pub extern fn glfwInit() c_int;
    pub extern fn glfwPollEvents() void;
    pub extern fn glfwTerminate() void;
    pub extern fn glfwWindowHint(hint: c_int, value: c_int) void;
    pub extern fn glfwWindowShouldClose(window: ?*Window) c_int;
};
/// Context client API hint and attribute.
pub const client_api = ABI.GLFW_CLIENT_API;
/// Window resize-ability window hint and attribute.
pub const resizable = ABI.GLFW_RESIZABLE;
pub const no_api = ABI.GLFW_NO_API;
/// Initializes the GLFW library.
pub fn init() bool {
    return ABI.glfwInit() == ABI.GLFW_TRUE;
}
/// Terminates the GLFW library.
pub fn deinit() void {
    ABI.glfwTerminate();
}
/// Sets the specified window hint to the desired value.
pub fn windowHint(hint: i32, value: anytype) void {
    switch (@typeInfo(@TypeOf(value))) {
        .int, .comptime_int => ABI.glfwWindowHint(hint, value),
        .bool => ABI.glfwWindowHint(hint, @intFromBool(value)),
        else => unreachable,
    }
}
/// Opaque monitor object.
pub const Monitor = opaque {};
/// Opaque window object.
pub const Window = opaque {
    /// Creates a window and its associated context.
    pub fn init(width: i32, height: i32, title: []const u8, monitor: ?*Monitor, share: ?*Window) *Window {
        return ABI.glfwCreateWindow(width, height, title.ptr, monitor, share) orelse unreachable;
    }
    /// Destroys the specified window and its context.
    pub fn deinit(self: *Window) void {
        ABI.glfwDestroyWindow(self);
    }
    /// Checks the close flag of the specified window.
    pub fn shouldClose(self: *Window) bool {
        return ABI.glfwWindowShouldClose(self) == ABI.GLFW_TRUE;
    }
};
/// Processes all pending events.
pub fn pollEvents() void {
    ABI.glfwPollEvents();
}
