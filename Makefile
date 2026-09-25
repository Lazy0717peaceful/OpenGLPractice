CXX = clang++
CC = clang

CXXFLAGS = -std=c++17 -Wall -Wextra \
	-Iexternal/glad/include \
	-Iexternal/stb \
	-Isrc \
	$(shell pkg-config --cflags glfw3)

CFLAGS = -Iexternal/glad/include

TARGET = bin/OpenGLPractice

MAIN_OBJ = build/main.o
SHADER_OBJ = build/Shader.o
GLAD_OBJ = build/gl.o

OBJS = $(MAIN_OBJ) $(SHADER_OBJ) $(GLAD_OBJ)

all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p bin
	$(CXX) $(OBJS) \
	$(shell pkg-config --libs glfw3) \
	-framework OpenGL \
	-o $(TARGET)

$(MAIN_OBJ): src/main.cpp src/Shader.h
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -c src/main.cpp -o $(MAIN_OBJ)

$(SHADER_OBJ): src/Shader.cpp src/Shader.h
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -c src/Shader.cpp -o $(SHADER_OBJ)

$(GLAD_OBJ): external/glad/src/gl.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c external/glad/src/gl.c -o $(GLAD_OBJ)

clean:
	rm -f build/*.o bin/OpenGLPractice