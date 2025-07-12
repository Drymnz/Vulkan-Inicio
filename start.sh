#!/bin/bash
set -e

PROJECT_NAME="vulkan-square"
SRC_DIR="$PROJECT_NAME/shaders"

echo "📁 Creando estructura del proyecto..."
mkdir -p "$SRC_DIR"

echo "📄 Escribiendo CMakeLists.txt..."
cat > "$PROJECT_NAME/CMakeLists.txt" <<'EOF'
cmake_minimum_required(VERSION 3.10)
project(VulkanSquare)

set(CMAKE_CXX_STANDARD 17)

find_package(Vulkan REQUIRED)
find_package(glfw3 REQUIRED)

add_executable(VulkanSquare main.cpp)
target_link_libraries(VulkanSquare Vulkan::Vulkan glfw)
EOF

echo "🧠 Escribiendo main.cpp..."
cat > "$PROJECT_NAME/main.cpp" <<'EOF'
#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
#include <iostream>

int main() {
    glfwInit();
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    GLFWwindow* window = glfwCreateWindow(800, 600, "Vulkan Square", nullptr, nullptr);

    while (!glfwWindowShouldClose(window)) {
        glfwPollEvents();
    }

    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}
EOF

echo "🎨 Escribiendo shaders..."
cat > "$SRC_DIR/vert.glsl" <<'EOF'
#version 450
layout(location = 0) in vec2 inPosition;
void main() {
    gl_Position = vec4(inPosition, 0.0, 1.0);
}
EOF

cat > "$SRC_DIR/frag.glsl" <<'EOF'
#version 450
layout(location = 0) out vec4 outColor;
void main() {
    outColor = vec4(0.8, 0.1, 0.3, 1.0);
}
EOF

echo "🧪 Verificando glslc..."
if ! command -v glslc &> /dev/null; then
    echo "❌ Error: glslc no encontrado. Instala 'vulkan-tools' o el Vulkan SDK."
    exit 1
fi

echo "🛠️ Compilando shaders a SPIR-V..."
glslc -fshader-stage=vert "$SRC_DIR/vert.glsl" -o "$SRC_DIR/vert.spv"
glslc -fshader-stage=frag "$SRC_DIR/frag.glsl" -o "$SRC_DIR/frag.spv"

echo "✅ Proyecto '$PROJECT_NAME' creado exitosamente."
echo "➡️ Para compilar:"
echo "   cd $PROJECT_NAME"
echo "   mkdir build && cd build"
echo "   cmake .. && make"
echo "   ./VulkanSquare"
