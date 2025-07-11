#pragma once

#include <vulkan/vulkan.h>
#include <vector>
#include <string>

class VulkanDevice;
class VulkanSwapChain;

struct Vertex {
    glm::vec2 pos;
    glm::vec3 color;

    static VkVertexInputBindingDescription getBindingDescription();
    static std::array<VkVertexInputAttributeDescription, 2> getAttributeDescriptions();
};

class VulkanPipeline {
public:
    VulkanPipeline(VulkanDevice* device, VulkanSwapChain* swapChain);
    ~VulkanPipeline();

    void createGraphicsPipeline();
    void destroyGraphicsPipeline();

    VkPipeline getPipeline() const { return graphicsPipeline; }
    VkPipelineLayout getLayout() const { return pipelineLayout; }
    VkDescriptorSetLayout getDescriptorSetLayout() const { return descriptorSetLayout; }

private:
    VulkanDevice* device;
    VulkanSwapChain* swapChain;

    VkPipeline graphicsPipeline;
    VkPipelineLayout pipelineLayout;
    VkDescriptorSetLayout descriptorSetLayout;

    void createDescriptorSetLayout();
    VkShaderModule createShaderModule(const std::vector<char>& code);
};
