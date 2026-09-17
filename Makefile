CXX = clang++
CC = clang

CXXFLAGS = -std=c++17 -Wall -Wextra \
	-Iexternal/glad/include \
	$(shell pkg-config --cflags glfw3)

CFLAGS = -Iexternal/glad/include

TARGET = bin/OpenGLPractice

MAIN_OBJ = build/main.o
GLAD_OBJ = build/gl.o

all: $(TARGET)

$(TARGET): $(MAIN_OBJ) $(GLAD_OBJ)
	$(CXX) $(MAIN_OBJ) $(GLAD_OBJ) \
	$(shell pkg-config --libs glfw3) \
	-framework OpenGL \
	-o $(TARGET)

$(MAIN_OBJ): src/main.cpp
	$(CXX) $(CXXFLAGS) -c src/main.cpp -o $(MAIN_OBJ)

$(GLAD_OBJ): external/glad/src/gl.c
	$(CC) $(CFLAGS) -c external/glad/src/gl.c -o $(GLAD_OBJ)

clean:
	rm -f build/*.o bin/OpenGLPractice