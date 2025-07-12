#!/bin/bash

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para mostrar mensajes con color
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}==== $1 ====${NC}"
}

# Función para preguntar sí/no
ask_yes_no() {
    while true; do
        read -p "$1 (s/n): " yn
        case $yn in
            [Ss]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Por favor responde 's' para sí o 'n' para no.";;
        esac
    done
}

# Función para verificar si un paquete está instalado
is_package_installed() {
    pacman -Q "$1" &> /dev/null
}

# Función para instalar herramientas de desarrollo Vulkan
install_vulkan_tools() {
    print_header "INSTALACIÓN DE HERRAMIENTAS VULKAN"
    
    # Paquetes esenciales según el tutorial de Vulkan
    declare -a packages=(
        "vulkan-devel"      # Incluye loader, headers y validation layers
        "vulkan-tools"      # Utilities como vkcube y vulkaninfo
        "glfw-wayland"      # Para manejo de ventanas (wayland)
        "glm"               # Biblioteca de álgebra lineal
        "shaderc"           # Compilador de shaders
        "libxi"             # Dependencia X11
        "libxxf86vm"        # Dependencia X11
    )
    
    # Verificar paquetes instalados
    print_message "Verificando paquetes instalados..."
    for pkg in "${packages[@]}"; do
        if is_package_installed "$pkg"; then
            echo -e "  ✓ $pkg ${GREEN}[INSTALADO]${NC}"
        else
            echo -e "  ✗ $pkg ${RED}[NO INSTALADO]${NC}"
        fi
    done
    
    echo ""
    if ask_yes_no "¿Deseas instalar/actualizar las herramientas de desarrollo Vulkan?"; then
        print_message "Instalando herramientas de desarrollo Vulkan..."
        
        # Actualizar base de datos de paquetes
        sudo pacman -Sy
        
        # Instalar paquetes
        sudo pacman -S --needed "${packages[@]}"
        
        if [ $? -eq 0 ]; then
            print_message "Herramientas Vulkan instaladas correctamente."
            
            # Verificar instalación con vkcube
            print_message "Verificando instalación con vkcube..."
            if command -v vkcube &> /dev/null; then
                print_message "vkcube está disponible. Puedes ejecutar 'vkcube' para verificar que Vulkan funciona."
            else
                print_warning "vkcube no está disponible en PATH."
            fi
            
            # Verificar información de Vulkan
            if command -v vulkaninfo &> /dev/null; then
                print_message "Verificando soporte de Vulkan..."
                vulkaninfo --summary | head -10
            fi
        else
            print_error "Error al instalar las herramientas Vulkan."
            exit 1
        fi
    else
        print_warning "Instalación omitida por el usuario."
    fi
}

# Función para manejar archivos del proyecto
manage_project_files() {
    print_header "GESTIÓN DE ARCHIVOS DEL PROYECTO"
    
    # Verificar si existen archivos del proyecto
    files_exist=false
    if [ -f "main.cpp" ] || [ -f "Makefile" ] || [ -f "VulkanTest" ]; then
        files_exist=true
    fi
    
    if [ "$files_exist" = true ]; then
        print_warning "Se encontraron archivos del proyecto existentes:"
        [ -f "main.cpp" ] && echo "  - main.cpp"
        [ -f "Makefile" ] && echo "  - Makefile"
        [ -f "VulkanTest" ] && echo "  - VulkanTest (ejecutable)"
        
        echo ""
        echo "Opciones disponibles:"
        echo "1) Limpiar archivos existentes y crear nuevos"
        echo "2) Mantener archivos existentes (solo crear los faltantes)"
        echo "3) Cancelar"
        
        while true; do
            read -p "Selecciona una opción (1-3): " choice
            case $choice in
                1)
                    print_message "Limpiando archivos existentes..."
                    rm -f main.cpp Makefile VulkanTest
                    create_project_files
                    break
                    ;;
                2)
                    print_message "Manteniendo archivos existentes..."
                    create_project_files
                    break
                    ;;
                3)
                    print_message "Operación cancelada."
                    return
                    ;;
                *)
                    echo "Opción inválida. Por favor selecciona 1, 2 o 3."
                    ;;
            esac
        done
    else
        if ask_yes_no "¿Deseas crear los archivos del proyecto Vulkan?"; then
            create_project_files
        else
            print_warning "Creación de archivos omitida por el usuario."
        fi
    fi
}

# Función para crear archivos del proyecto
create_project_files() {
    print_message "Creando archivos del proyecto..."
    
    # Crear main.cpp
    if [ ! -f "main.cpp" ]; then
        print_message "Creando main.cpp..."
        cat > "main.cpp" <<'EOF'
#include <vulkan/vulkan.h>

#include <iostream>
#include <stdexcept>
#include <cstdlib>

class HelloTriangleApplication {
public:
    void run() {
        initVulkan();
        mainLoop();
        cleanup();
    }

private:
    void initVulkan() {

    }

    void mainLoop() {

    }

    void cleanup() {

    }
};

int main() {
    HelloTriangleApplication app;

    try {
        app.run();
    } catch (const std::exception& e) {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
EOF
        print_message "main.cpp creado exitosamente."
    else
        print_warning "main.cpp ya existe, omitiendo..."
    fi

    # Crear Makefile
    if [ ! -f "Makefile" ]; then
        print_message "Creando Makefile..."
        cat > "Makefile" <<'EOF'
CFLAGS = -std=c++17 -O2
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

VulkanTest: main.cpp
	g++ $(CFLAGS) -o VulkanTest main.cpp $(LDFLAGS)

.PHONY: test clean

test: VulkanTest
	./VulkanTest

clean:
	rm -f VulkanTest
EOF
        print_message "Makefile creado exitosamente."
    else
        print_warning "Makefile ya existe, omitiendo..."
    fi

    print_message "Archivos del proyecto creados exitosamente."
    
    # Compilar y probar
    if ask_yes_no "¿Deseas compilar y probar el proyecto ahora?"; then
        print_message "Compilando el proyecto..."
        if make; then
            print_message "Compilación exitosa."
            if ask_yes_no "¿Deseas ejecutar el programa de prueba?"; then
                print_message "Ejecutando VulkanTest..."
                ./VulkanTest
            fi
        else
            print_error "Error en la compilación."
        fi
    fi
}

# Función para mostrar información útil
show_info() {
    print_header "INFORMACIÓN ÚTIL"
    echo ""
    echo "Comandos útiles para verificar Vulkan:"
    echo "  - vulkaninfo          : Muestra información detallada de Vulkan"
    echo "  - vkcube             : Ejecuta una demo de cubo rotatorio"
    echo "  - make               : Compila el proyecto"
    echo "  - make test          : Compila y ejecuta el proyecto"
    echo "  - make clean         : Limpia archivos compilados"
    echo ""
    echo "Archivos del proyecto:"
    echo "  - main.cpp           : Código fuente principal"
    echo "  - Makefile           : Archivo de compilación"
    echo "  - VulkanTest         : Ejecutable compilado"
    echo ""
    echo "Documentación:"
    echo "  - Tutorial oficial: https://vulkan-tutorial.com/"
    echo "  - Documentación API: https://docs.vulkan.org/"
}

# Función principal
main() {
    print_header "CONFIGURACIÓN DE ENTORNO DE DESARROLLO VULKAN"
    echo "Este script configurará tu entorno de desarrollo Vulkan en Arch Linux"
    echo "basado en las recomendaciones del tutorial oficial de Vulkan."
    echo ""
    
    # Verificar que estamos en Arch Linux
    if [ ! -f "/etc/arch-release" ]; then
        print_warning "Este script está diseñado para Arch Linux."
        if ! ask_yes_no "¿Deseas continuar de todos modos?"; then
            print_message "Script cancelado."
            exit 0
        fi
    fi
    
    # Verificar que pacman está disponible
    if ! command -v pacman &> /dev/null; then
        print_error "pacman no está disponible. Este script requiere pacman."
        exit 1
    fi
    
    # Ejecutar funciones principales
    install_vulkan_tools
    echo ""
    manage_project_files
    echo ""
    show_info
    
    print_message "Configuración completada."
}

# Ejecutar función principal
main "$@" GLFWwindow* window; // <- Esta es la línea que faltaba