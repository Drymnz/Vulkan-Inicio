#!/bin/bash

# Script para crear estructura básica de proyecto Vulkan
# Para Arch Linux

echo "Creando estructura del proyecto Vulkan..."

# Crear directorio principal
mkdir -p vulkan_square_project
cd vulkan_square_project

# Crear subdirectorios
mkdir -p src
mkdir -p shaders
mkdir -p build

# Crear archivos principales
touch src/main.cpp
touch src/VulkanApp.h
touch src/VulkanApp.cpp
touch CMakeLists.txt
touch Makefile

# Crear shaders básicos
touch shaders/vertex.vert
touch shaders/fragment.frag
touch shaders/compile_shaders.sh

echo "Estructura del proyecto creada:"
echo "vulkan_square_project/"
echo "├── src/"
echo "│   ├── main.cpp"
echo "│   ├── VulkanApp.h"
echo "│   └── VulkanApp.cpp"
echo "├── shaders/"
echo "│   ├── vertex.vert"
echo "│   ├── fragment.frag"
echo "│   └── compile_shaders.sh"
echo "├── build/"
echo "├── CMakeLists.txt"
echo "└── Makefile"

echo ""
echo "Proyecto creado exitosamente!"
echo "Ahora puedes compilar los shaders ejecutando:"
echo "  cd shaders && chmod +x compile_shaders.sh && ./compile_shaders.sh"
echo ""
echo "Para compilar el proyecto:"
echo "  make"
echo ""
echo "Para ejecutar:"
echo "  ./vulkan_square"