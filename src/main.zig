const std = @import("std");

const HelloTriangleApplication = @import("hello_triangle_application.zig");

pub fn main() !void {
    var app: HelloTriangleApplication = .{};

    app.run();
}
