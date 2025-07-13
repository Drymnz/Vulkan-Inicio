CFLAGS = -std=c++17 -O2 -I.
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

SOURCES = main.cpp HelloTriangleApplication.cpp
OBJECTS = $(SOURCES:.cpp=.o)
EXECUTABLE = VulkanTest

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	g++ $(CFLAGS) -o $@ $(OBJECTS) $(LDFLAGS)

%.o: %.cpp HelloTriangleApplication.h
	g++ $(CFLAGS) -c $< -o $@

.PHONY: test clean

test: $(EXECUTABLE)
	./$(EXECUTABLE)

clean:
	rm -f $(EXECUTABLE) $(OBJECTS)

	SHADER_DIR = shaders
SHADER_SRCS = $(SHADER_DIR)/triangle.vert $(SHADER_DIR)/triangle.frag
SHADER_BINS = $(SHADER_SRCS:.vert=.vert.spv)
SHADER_BINS += $(SHADER_SRCS:.frag=.frag.spv)

GLSLANG_VALIDATOR = glslangValidator

all: $(EXECUTABLE) $(SHADER_BINS)

$(SHADER_DIR)/%.spv: $(SHADER_DIR)/%
	$(GLSLANG_VALIDATOR) -V $< -o $@

clean:
	rm -f $(EXECUTABLE) $(OBJECTS) $(SHADER_BINS)
