const std = @import("std");
const skn = @import("sakana");
const rl = skn.raylib;

pub fn main() !void {
    const screen_width = 800;
    const screen_height = 450;

    rl.initWindow(screen_width, screen_height, "Reborn of Dream");
    defer rl.closeWindow();

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.windowShouldClose()) // Detect window close button or ESC key
    {
        // Update
        //----------------------------------------------------------------------------------
        // TODO: Update your variables here
        //----------------------------------------------------------------------------------

        // Draw
        //----------------------------------------------------------------------------------
        rl.beginDrawing();

        rl.clearBackground(rl.raywhite);

        rl.drawText("Congrats! You created your first window!", 190, 200, 20, rl.light_gray);

        rl.endDrawing();
        //----------------------------------------------------------------------------------
    }
}
