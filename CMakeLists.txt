cmake_minimum_required(VERSION 3.10)
project(VulkanSquare)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Find all required packages
find_package(glfw3 REQUIRED)
find_package(Vulkan REQUIRED)
find_package(glm REQUIRED)  # Añadido para GLM

# Configuración para shaders
set(SHADER_DIR ${CMAKE_CURRENT_SOURCE_DIR}/shaders)
set(SHADER_OUTPUT_DIR ${CMAKE_BINARY_DIR}/shaders)

# Crear directorio para shaders compilados
file(MAKE_DIRECTORY ${SHADER_OUTPUT_DIR})

# Encontrar glslangValidator
find_program(GLSL_VALIDATOR glslangValidator)
if(GLSL_VALIDATOR)
    add_custom_command(
        OUTPUT ${SHADER_OUTPUT_DIR}/vert.spv
        COMMAND ${GLSL_VALIDATOR} -V ${SHADER_DIR}/shader.vert -o ${SHADER_OUTPUT_DIR}/vert.spv
        DEPENDS ${SHADER_DIR}/shader.vert
        COMMENT "Compiling vertex shader"
    )
    
    add_custom_command(
        OUTPUT ${SHADER_OUTPUT_DIR}/frag.spv
        COMMAND ${GLSL_VALIDATOR} -V ${SHADER_DIR}/shader.frag -o ${SHADER_OUTPUT_DIR}/frag.spv
        DEPENDS ${SHADER_DIR}/shader.frag
        COMMENT "Compiling fragment shader"
    )
    
    add_custom_target(shaders ALL 
        DEPENDS ${SHADER_OUTPUT_DIR}/vert.spv ${SHADER_OUTPUT_DIR}/frag.spv
    )
else()
    message(WARNING "glslangValidator not found - shaders won't be automatically compiled")
endif()

add_executable(VulkanSquare 
    main.cpp
    VulkanApp.cpp
    VulkanDevice.cpp
    VulkanSwapChain.cpp
    VulkanPipeline.cpp
)

# Configurar propiedades del objetivo
target_include_directories(VulkanSquare PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(VulkanSquare 
    glfw
    Vulkan::Vulkan
    glm::glm  # Añadido para GLM
)

# Copiar shaders al directorio de construcción
add_custom_command(TARGET VulkanSquare POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${SHADER_DIR}
    ${SHADER_OUTPUT_DIR}
    COMMENT "Copying shaders to build directory"
)