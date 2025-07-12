#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>

#include <iostream>
#include <stdexcept>
#include <cstdlib>

class HelloTriangleApplication
{
public:
    void run()
    {
        initWindow();
        initVulkan();
        mainLoop();
        cleanup();
    }

private:
    GLFWwindow *window; // <- Esta es la línea que faltaba
    
    void initWindow()
    {
        glfwInit();

        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API); // inicializa la biblioteca GLFW.
        glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);   // redimensionadas requiere un cuidado especial que analizaremos más adelante, deshabilítelo por ahora con otra llamada de sugerencia de ventana:

        window = glfwCreateWindow(800, 600, "Vulkan", nullptr, nullptr); // crea una ventana de GLFW con un tamaño de 800x600 y un título de "Vulkan".
    }
    void initVulkan()
    {
    }

    void mainLoop()
    {
        // mantener la aplicación ejecutándose hasta que ocurra un error o se cierre la ventana,
        while (!glfwWindowShouldClose(window))
        {
            glfwPollEvents();
        }
    }

    void cleanup()
    {
        // cerrada la ventana, necesitamos limpiar los recursos destruyéndola
        glfwDestroyWindow(window);

        glfwTerminate();
    }
};

int main()
{
    HelloTriangleApplication app;

    try
    {
        app.run();
    }
    catch (const std::exception &e)
    {
        std::cerr << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
