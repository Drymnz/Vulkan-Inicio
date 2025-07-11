#pragma once

#include <vulkan/vulkan.h>
#include <vector>
#include <memory>
VulkanPipeline.cpp
class VulkanDevice;

struct SwapChainSupportDetails {
    VkSurfaceCapabilitiesKHR capabilities;
    std::vector<VkSurfaceFormatKHR> formats;
    std::vector<VkPresentModeKHR> presentModes;
};

class VulkanSwapChain {
public:
    VulkanSwapChain(VulkanDevice* device, VkSurfaceKHR surface);
    ~VulkanSwapChain();

    void createSwapChain();
    void cleanupSwapChain();
    void recreateSwapChain();

    VkSwapchainKHR getSwapChain() const { return swapChain; }
    VkFormat getImageFormat() const { return swapChainImageFormat; }
    VkExtent2D getExtent() const { return swapChainExtent; }
    VkRenderPass getRenderPass() const { return renderPass; }
    std::vector<VkFramebuffer> getFramebuffers() const { return swapChainFramebuffers; }
    std::vector<VkImageView> getImageViews() const { return swapChainImageViews; }

private:
    VulkanDevice* device;
    VkSurfaceKHR surface;

    VkSwapchainKHR swapChain;
    std::vector<VkImage> swapChainImages;
    VkFormat swapChainImageFormat;
    VkExtent2D swapChainExtent;
    std::vector<VkImageView> swapChainImageViews;
    VkRenderPass renderPass;
    std::vector<VkFramebuffer> swapChainFramebuffers;

    void createImageViews();
    void createRenderPass();
    void createFramebuffers();

    SwapChainSupportDetails querySwapChainSupport(VkPhysicalDevice device);
    VkSurfaceFormatKHR chooseSwapSurfaceFormat(const std::vector<VkSurfaceFormatKHR>& availableFormats);
    VkPresentModeKHR chooseSwapPresentMode(const std::vector<VkPresentModeKHR>& availablePresentModes);
    VkExtent2D chooseSwapExtent(const VkSurfaceCapabilitiesKHR& capabilities);
};
