#pragma once

#include <vulkan/vulkan.h>
#include <vector>
#include <string>
#include <array>        // ✅ NECESARIO para std::array
#include <glm/glm.hpp>  // Para glm::vec2 y glm::vec3

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

    // ✅ DECLARACIÓN QUE FALTABA
    static std::vector<char> readFile(const std::string& filename);

private:
    VulkanDevice* device;
    VulkanSwapChain* swapChain;

    VkPipeline graphicsPipeline;
    VkPipelineLayout pipelineLayout;
    VkDescriptorSetLayout descriptorSetLayout;

    void createDescriptorSetLayout();
    VkShaderModule createShaderModule(const std::vector<char>& code);
};

