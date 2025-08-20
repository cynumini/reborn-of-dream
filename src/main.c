#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

const int WIDTH = 800;
const int HEIGHT = 600;

typedef struct HelloTriangleApplication {
  GLFWwindow *window;
} HelloTriangleApplication;

void initWindow(HelloTriangleApplication *app) {
  glfwInit();

  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);

  app->window = glfwCreateWindow(WIDTH, HEIGHT, "Vulkan", NULL, NULL);
}

void initVulkan() {}

void mainLoop(HelloTriangleApplication *app) {
  while (!glfwWindowShouldClose(app->window)) {
    glfwPollEvents();
  }
}

void cleanup(HelloTriangleApplication *app) {
  glfwDestroyWindow(app->window);

  glfwTerminate();
}

int run(HelloTriangleApplication *app) {
  initWindow(app);
  initVulkan();
  mainLoop(app);
  cleanup(app);
  return 0;
}

int main() {
  HelloTriangleApplication app;

  if (run(&app) == -1) {
    fprintf(stderr, "errno: %i\n", errno);
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}
