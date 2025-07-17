CXX = g++
CXXFLAGS = -std=c++17 -O2 -Wall -Wextra
LDFLAGS = -lglfw -lvulkan -ldl -lpthread -lX11 -lXxf86vm -lXrandr -lXi

TARGET = vulkan_square
SRCDIR = src
SOURCES = $(wildcard $(SRCDIR)/*.cpp)
OBJECTS = $(SOURCES:.cpp=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)

shaders:
	cd shaders && ./compile_shaders.sh

run: $(TARGET)
	./$(TARGET)

.PHONY: all clean shaders run