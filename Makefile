CXX = g++
CXXFLAGS = -std=c++17 -g -O0 -Wall -Wextra -I. -Ilibs
LIBS = -lsfml-graphics -lsfml-window -lsfml-system

SOURCES = main.cpp \
          $(wildcard Entities/*.cpp) \
          $(wildcard Field/*.cpp) \
          $(wildcard Managers/*.cpp) \
          $(wildcard Systems/*.cpp) \
          $(wildcard Spells/*.cpp)

OBJECTS = $(SOURCES:.cpp=.o)
DEPENDS = $(OBJECTS:.o=.d)

TARGET = game

MAKEFLAGS += -j$(shell nproc)

$(TARGET): $(OBJECTS)
	$(CXX) $(OBJECTS) -o $(TARGET) $(LIBS)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP -c $< -o $@

-include $(DEPENDS)

clean:
	rm -f $(OBJECTS) $(DEPENDS) $(TARGET)

rebuild: clean $(TARGET)

.PHONY: clean rebuild