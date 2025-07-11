#pragma once

#include <GLFW/glfw3.h>
#include <vulkan/vulkan.h>
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

    VkCommandPool commandPool;
    std::vector<VkCommandBuffer> commandBuffers;

    // Vertex data
    VkBuffer vertexBuffer;
    VkDeviceMemory vertexBufferMemory;
    VkBuffer indexBuffer;
    VkDeviceMemory indexBufferMemory;

    // Synchronization objects
    std::vector<VkSemaphore> imageAvailableSemaphores;
    std::vector<VkSemaphore> renderFinishedSemaphores;
    std::vector<VkFence> inFlightFences;
    std::vector<VkFence> imagesInFlight;

    size_t currentFrame;

    void initWindow();
    void initVulkan();
    void createVertexBuffer();
    void createIndexBuffer();
    void createCommandPool();
    void createCommandBuffers();
    void createSyncObjects();
    void recordCommandBuffer(VkCommandBuffer commandBuffer, uint32_t imageIndex);
    void drawFrame();
    void cleanup();

    uint32_t findMemoryType(uint32_t typeFilter, VkMemoryPropertyFlags properties);

    static void framebufferResizeCallback(GLFWwindow* window, int width, int height);
    static void keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods);
};