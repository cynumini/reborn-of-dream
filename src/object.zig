const std = @import("std");
const skn = @import("sakana");
const rl = skn.raylib;

const Self = @This();

texture: rl.Texture,

pub fn init(texture_path: []const u8) Self {
    return .{
        .texture = rl.loadTexture(texture_path.ptr),
    };
}

pub fn deinit(self: Self) void {
    rl.unloadTexture(self.texture);
}

pub fn draw(self: Self) void {
    rl.drawTexture(self.texture, 100, 100, rl.white);
}
