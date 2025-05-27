const std = @import("std");
const skn = @import("sakana");
const rl = skn.raylib;

const Object = @import("object.zig");

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "Reborn of Dream");
    defer rl.closeWindow();

    const iron = Object.init("assets/iron_ore.png");
    defer iron.deinit();

    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        // Update

        // Draw
        rl.beginDrawing();

        rl.clearBackground(rl.raywhite);
        rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.light_gray);
        iron.draw();

        rl.endDrawing();
    }
}
