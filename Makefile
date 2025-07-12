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