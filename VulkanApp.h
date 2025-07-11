#pragma once

#include <vulkan/vulkan.h>
#include <GLFW/glfw3.h>
#include <memory>
#include <vector>

class VulkanDevice;
class VulkanSwapChain;
class VulkanPipeline;

class VulkanApp {
public:
    VulkanApp();
    ~VulkanApp();

    void run();

private:
    GLFWwindow* window;
    std::unique_ptr<VulkanDevice> device;
    std::unique_ptr<VulkanSwapChain> swapChain;
    std::unique_ptr<VulkanPipeline> pipeline;

    void initWindow();
    void initVulkan();
    void mainLoop();
    void cleanup();

    static void framebufferResizeCallback(GLFWwindow* window, int width, int height);
    static void keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods);
};
