#pragma once

#include <vulkan/vulkan.h>
#include <GLFW/glfw3.h>
#include <memory>
#include <vector>
#include <cstdint>  // ← necesario para uint32_t

class VulkanDevice;
class VulkanSwapChain;
class VulkanPipeline;

class VulkanApp
{
public:
    VulkanApp();
    ~VulkanApp();

    void run();

private:
    GLFWwindow *window;
    std::unique_ptr<VulkanDevice> device;
    std::unique_ptr<VulkanSwapChain> swapChain;
    std::unique_ptr<VulkanPipeline> pipeline;

    VkCommandPool commandPool;
    std::vector<VkCommandBuffer> commandBuffers;

    // Sincronización por frame
    std::vector<VkSemaphore> imageAvailableSemaphores;
    std::vector<VkSemaphore> renderFinishedSemaphores;
    std::vector<VkFence> inFlightFences;

    // Sincronización por imagen (nuevo)
    std::vector<VkFence> imagesInFlight;

    uint32_t currentFrame = 0;

    void initWindow();
    void initVulkan();
    void mainLoop();
    void cleanup();
    void drawFrame();
    void createCommandPool();
    void createCommandBuffers();
    void createSyncObjects();

    static void framebufferResizeCallback(GLFWwindow *window, int width, int height);
    static void keyCallback(GLFWwindow *window, int key, int scancode, int action, int mods);
};
