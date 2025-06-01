const std = @import("std");
const skn = @import("sakana");
const rl = skn.raylib;

const Self = @This();

texture: rl.Texture,
rectangle: rl.Rectangle,

pub fn init(texture_path: []const u8, position: rl.Vector2) Self {
    const texture = rl.loadTexture(texture_path.ptr);
    const rectangle: rl.Rectangle = .{
        .x = position.x,
        .y = position.y,
        .width = @floatFromInt(texture.width),
        .height = @floatFromInt(texture.height),
    };
    return .{
        .texture = texture,
        .rectangle = rectangle,
    };
}

pub fn deinit(self: Self) void {
    rl.unloadTexture(self.texture);
}

pub fn draw(self: Self) void {
    rl.drawTexture(self.texture, @intFromFloat(self.rectangle.x), @intFromFloat(self.rectangle.y), rl.white);
}
