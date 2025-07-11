#pragma once

#include <vulkan/vulkan.h>
#include <GLFW/glfw3.h>  // Incluir GLFW antes que otras dependencias
#include <vector>
#include <optional>
#include <memory>

struct QueueFamilyIndices {
    std::optional<uint32_t> graphicsFamily;
    std::optional<uint32_t> presentFamily;

    bool isComplete() {
        return graphicsFamily.has_value() && presentFamily.has_value();
    }
};

class VulkanDevice {
public:
    VulkanDevice(GLFWwindow* window);
    ~VulkanDevice();

    VkDevice getDevice() const { return device; }
    VkPhysicalDevice getPhysicalDevice() const { return physicalDevice; }
    VkQueue getGraphicsQueue() const { return graphicsQueue; }
    VkQueue getPresentQueue() const { return presentQueue; }
    VkSurfaceKHR getSurface() const { return surface; }
    uint32_t getGraphicsQueueFamily() const { return graphicsQueueFamily; }
    uint32_t getPresentQueueFamily() const { return presentQueueFamily; }
    GLFWwindow* getWindow() const { return window; }

private:
    GLFWwindow* window;
    VkInstance instance;
    VkDebugUtilsMessengerEXT debugMessenger;
    VkPhysicalDevice physicalDevice;
    VkDevice device;
    VkQueue graphicsQueue;
    VkQueue presentQueue;
    VkSurfaceKHR surface;
    uint32_t graphicsQueueFamily;
    uint32_t presentQueueFamily;

    void createInstance();
    void setupDebugMessenger();
    void createSurface();
    void pickPhysicalDevice();
    void createLogicalDevice();

    bool isDeviceSuitable(VkPhysicalDevice device);
    QueueFamilyIndices findQueueFamilies(VkPhysicalDevice device);
    bool checkDeviceExtensionSupport(VkPhysicalDevice device);
    std::vector<const char*> getRequiredExtensions();
    bool checkValidationLayerSupport();
};