#include "raylib.h"

int main(void) {
  const int screenWidth = 800;
  const int screenHeight = 450;

  InitWindow(screenWidth, screenHeight, "reborn of dream");

  SetTargetFPS(60);

  Texture belt = LoadTexture("./assets/belt.png");

  while (!WindowShouldClose()) {
    // Update

    // Draw
    BeginDrawing();

    ClearBackground(RAYWHITE);

    DrawText("Reborn of Dream", 310, 200, 20, LIGHTGRAY);

    DrawTexture(belt, 100, 100, WHITE);

    EndDrawing();
  }

  CloseWindow();

  return 0;
}
