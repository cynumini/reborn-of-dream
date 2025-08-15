const std = @import("std");

const glfw = @import("glfw.zig");
const vulkan = @import("vulkan.zig");

const Self = @This();

const width = 800;
const height = 600;

window: ?*glfw.Window = null,

pub fn run(self: *Self) void {
    self.initWindow();
    self.initVulkan();
    self.mainLoop();
    self.cleanup();
}

pub fn initWindow(self: *Self) void {
    _ = glfw.init();

    glfw.windowHint(glfw.client_api, glfw.no_api);
    glfw.windowHint(glfw.resizable, false);

    self.window = glfw.Window.init(width, height, "Vulkan", null, null);
}

pub fn initVulkan(_: Self) void {}

pub fn mainLoop(self: Self) void {
    if (self.window) |window| {
        while (!window.shouldClose()) {
            glfw.pollEvents();
            break;
        }
    } else unreachable;
}

pub fn cleanup(self: *Self) void {
    if (self.window) |window| {
        window.deinit();
    } else unreachable;

    glfw.deinit();
}
