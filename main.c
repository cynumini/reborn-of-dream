#include <stdio.h>

#include "raylib.h"
#include "raymath.h"

#include "sakana.h"

int main(void) {
  const int screenWidth = 800;
  const int screenHeight = 450;

  InitWindow(screenWidth, screenHeight, "reborn of dream");

  SetTargetFPS(60);

  const Texture belt = LoadTexture("./assets/belt.png");

  DynamicArray belt_positions = da_init(Vector2);

  while (!WindowShouldClose()) {
    // Update
    if (IsMouseButtonPressed(0)) {
      // TODO: Check if there is belt in this cell already
      const Vector2 mouse_position = GetMousePosition();
      const Vector2 belt_position = (Vector2){
          .x = (int)(mouse_position.x / 32) * 32.0,
          .y = (int)(mouse_position.y / 32) * 32.0,
      };
      da_push(&belt_positions, belt_position);
      printf("%f %f\n", belt_position.x, belt_position.y);
    }

    // Draw
    BeginDrawing();

    ClearBackground(RAYWHITE);

    DrawText("Reborn of Dream", 310, 200, 20, LIGHTGRAY);

    for (size_t i = 0; i < belt_positions.len; i++) {
      DrawTexture(belt, da_get(&belt_positions, Vector2, i).x,
                  da_get(&belt_positions, Vector2, i).y, WHITE);
    }

    EndDrawing();
  }

  CloseWindow();

  return 0;
}
