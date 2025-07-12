#pragma once

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <stdexcept>
#include <vector>
#include <optional>
#include <set>
#include <string>

class HelloTriangleApplication
{
public:
    void run();

private:
    // --- Vulkan handles
    GLFWwindow* window;
    VkInstance instance;
    VkSurfaceKHR surface;
    VkPhysicalDevice physicalDevice = VK_NULL_HANDLE;
    VkDevice device;

    // --- Queue handles
    VkQueue graphicsQueue;
    VkQueue presentQueue;

    // --- Window dimensions
    const uint32_t WIDTH = 800;
    const uint32_t HEIGHT = 600;

    // --- Validation layers
    const std::vector<const char*> validationLayers = {
        "VK_LAYER_KHRONOS_validation"
    };

    // --- Device extensions
    const std::vector<const char*> deviceExtensions = {
        VK_KHR_SWAPCHAIN_EXTENSION_NAME
    };

#ifdef NDEBUG
    const bool enableValidationLayers = false;
#else
    const bool enableValidationLayers = true;
#endif

    // --- Core functions
    void initWindow();
    void initVulkan();
    void mainLoop();
    void cleanup();

    // --- Vulkan setup steps
    void createInstance();
    void createSurface();
    void pickPhysicalDevice();
    void createLogicalDevice();

    // --- Support functions
    bool isDeviceSuitable(VkPhysicalDevice device);
    bool checkValidationLayerSupport();
    bool checkDeviceExtensionSupport(VkPhysicalDevice device);

    // --- Queue family discovery
    struct QueueFamilyIndices {
        std::optional<uint32_t> graphicsFamily;
        std::optional<uint32_t> presentFamily;

        bool isComplete() {
            return graphicsFamily.has_value() && presentFamily.has_value();
        }
    };

    QueueFamilyIndices findQueueFamilies(VkPhysicalDevice device);
};
