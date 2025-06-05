#include <stdio.h>

#include "raylib.h"
#include "raymath.h"

int main(void) {
  const int screenWidth = 800;
  const int screenHeight = 450;

  InitWindow(screenWidth, screenHeight, "reborn of dream");

  SetTargetFPS(60);

  const Texture belt = LoadTexture("./assets/belt.png");
  Vector2 belt_position = Vector2Zero();

  while (!WindowShouldClose()) {
    // Update
    if (IsMouseButtonPressed(0)) {
      const Vector2 mouse_position = GetMousePosition();
      belt_position = mouse_position;
      printf("fuck %f %f\n", mouse_position.x, mouse_position.y);
    }

    // Draw
    BeginDrawing();

    ClearBackground(RAYWHITE);

    DrawText("Reborn of Dream", 310, 200, 20, LIGHTGRAY);

    DrawTexture(belt, belt_position.x, belt_position.y, WHITE);

    EndDrawing();
  }

  CloseWindow();

  return 0;
}
