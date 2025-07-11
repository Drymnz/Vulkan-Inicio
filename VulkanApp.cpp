#include "VulkanApp.h"
#include "VulkanDevice.h"
#include "VulkanSwapChain.h"
#include "VulkanPipeline.h"
#include <stdexcept>
#include <iostream>

VulkanApp::VulkanApp() {
    initWindow();
    initVulkan();
}

VulkanApp::~VulkanApp() {
    cleanup();
}

void VulkanApp::run() {
    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }
}

void VulkanApp::initWindow() {
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    window = glfwCreateWindow(800, 600, "Vulkan Square", nullptr, nullptr);
    glfwSetWindowUserPointer(window, this);
    glfwSetFramebufferSizeCallback(window, framebufferResizeCallback);
    glfwSetKeyCallback(window, keyCallback);
}

void VulkanApp::initVulkan() {
    device = std::make_unique<VulkanDevice>(window);
    swapChain = std::make_unique<VulkanSwapChain>(device.get(), device->getSurface());
    pipeline = std::make_unique<VulkanPipeline>(device.get(), swapChain.get());
}

void VulkanApp::cleanup() {
    glfwDestroyWindow(window);
    glfwTerminate();
}

void VulkanApp::framebufferResizeCallback(GLFWwindow* window, int width, int height) {
    auto app = reinterpret_cast<VulkanApp*>(glfwGetWindowUserPointer(window));
    // Handle resize if needed
}

void VulkanApp::keyCallback(GLFWwindow* window, int key, int scancode, int action, int mods) {
    auto app = reinterpret_cast<VulkanApp*>(glfwGetWindowUserPointer(window));
    
    if (action == GLFW_PRESS || action == GLFW_REPEAT) {
        if (key == GLFW_KEY_EQUAL || key == GLFW_KEY_KP_ADD) {
            std::cout << "+ pressed - increase scale" << std::endl;
        } else if (key == GLFW_KEY_MINUS || key == GLFW_KEY_KP_SUBTRACT) {
            std::cout << "- pressed - decrease scale" << std::endl;
        }
    }
}
