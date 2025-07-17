#!/bin/bash

# Script para compilar shaders de Vulkan
# Requiere glslc (viene con Vulkan SDK)

echo "Compilando shaders de Vulkan..."

# Verificar que glslc está disponible
if ! command -v glslc &> /dev/null; then
    echo "Error: glslc no está instalado"
    echo "Instala el Vulkan SDK o ejecuta: sudo pacman -S shaderc"
    exit 1
fi

# Crear directorio shaders si no existe
mkdir -p shaders

# Verificar que los archivos fuente existen
if [ ! -f "vertex.vert" ]; then
    echo "Error: vertex.vert no encontrado"
    exit 1
fi

if [ ! -f "fragment.frag" ]; then
    echo "Error: fragment.frag no encontrado"
    exit 1
fi

# Compilar vertex shader
echo "Compilando vertex.vert..."
glslc vertex.vert -o shaders/vertex.spv
if [ $? -eq 0 ]; then
    echo "✓ shaders/vertex.spv creado exitosamente"
else
    echo "✗ Error compilando vertex.vert"
    exit 1
fi

# Compilar fragment shader
echo "Compilando fragment.frag..."
glslc fragment.frag -o shaders/fragment.spv
if [ $? -eq 0 ]; then
    echo "✓ shaders/fragment.spv creado exitosamente"
else
    echo "✗ Error compilando fragment.frag"
    exit 1
fi

echo ""
echo "Shaders compilados exitosamente!"
echo "Archivos generados en directorio shaders/:"
ls -la shaders/*.spv 2>/dev/null || echo "No se encontraron archivos .spv"