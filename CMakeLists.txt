cmake_minimum_required(VERSION 3.10)
project(VulkanSquare)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find dependencies
find_package(glfw3 REQUIRED)
find_package(Vulkan REQUIRED)

# Shader compilation
find_program(GLSL_VALIDATOR glslangValidator)
if(GLSL_VALIDATOR)
    add_custom_command(
        OUTPUT shaders/vert.spv shaders/frag.spv
        COMMAND ${GLSL_VALIDATOR} -V shaders/shader.vert -o shaders/vert.spv
        COMMAND ${GLSL_VALIDATOR} -V shaders/shader.frag -o shaders/frag.spv
        DEPENDS shaders/shader.vert shaders/shader.frag
    )
    add_custom_target(shaders ALL DEPENDS shaders/vert.spv shaders/frag.spv)
endif()

# Add executable
add_executable(VulkanSquare 
    main.cpp
    VulkanApp.cpp
    VulkanDevice.cpp
    VulkanSwapChain.cpp
    VulkanPipeline.cpp
)

target_link_libraries(VulkanSquare glfw Vulkan::Vulkan)

# Copy shaders to build directory
file(COPY shaders DESTINATION ${CMAKE_BINARY_DIR})
