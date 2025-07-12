cmake_minimum_required(VERSION 3.10)
project(VulkanSquare)

set(CMAKE_CXX_STANDARD 17)

find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)

add_executable(VulkanSquare main.cpp)
target_link_libraries(VulkanSquare Vulkan::Vulkan glfw)
