const std = @import("std");
const skn = @import("sakana");
const rl = skn.raylib;

const Object = @import("object.zig");

pub fn main() !void {
    var debug_allocator = std.heap.DebugAllocator(.{}){};
    defer {
        _ = debug_allocator.deinit();
    }
    const allocator = debug_allocator.allocator();

    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "Reborn of Dream");
    defer rl.closeWindow();

    const iron = Object.init("assets/iron_ore.png", .{.x = 100, .y = 100});
    defer iron.deinit();

    var iron_ore_count: u32 = 0;

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        // Update

        // Draw
        rl.beginDrawing();

        rl.clearBackground(rl.raywhite);

        const iron_ore_count_str = try std.fmt.allocPrint(allocator, "Iron ore: {}", .{iron_ore_count});
        defer allocator.free(iron_ore_count_str);

        if (rl.isMouseButtonReleased(0)) {
            const mouse_position = rl.getMousePosition();
            if (rl.checkCollisionPointRec(mouse_position, iron.rectangle)) {
                iron_ore_count += 1;
            }
        }

        rl.drawText(iron_ore_count_str.ptr, 16, 16, 20, rl.light_gray);
        iron.draw();

        rl.endDrawing();
    }
}
