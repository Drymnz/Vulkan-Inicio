cmake_minimum_required(VERSION 3.10)
project(VulkanSquare)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Encontrar Vulkan
find_package(Vulkan REQUIRED)

# Encontrar GLFW
find_package(glfw3 REQUIRED)

# Encontrar GLM
find_package(glm REQUIRED)

# Archivos fuente
set(SOURCES
    src/main.cpp
    src/VulkanApp.cpp
)

# Crear ejecutable
add_executable(${PROJECT_NAME} ${SOURCES})

# Enlazar librerías
target_link_libraries(${PROJECT_NAME} 
    ${Vulkan_LIBRARIES}
    glfw
    glm::glm
)

# Incluir directorios
target_include_directories(${PROJECT_NAME} PRIVATE
    ${Vulkan_INCLUDE_DIRS}
    src/
)