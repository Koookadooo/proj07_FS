# Compiler
CC := gcc

# Compiler Flags
CFLAGS := -Wall -Wextra -Werror -g

# Executable Name
TARGET := testfs

# Source files and objects
SOURCES := $(wildcard *.c)
OBJECTS := $(SOURCES:.c=.o)

# Library Name
LIB := libvvsfs.a

# Default rule
all: $(TARGET)

# Build the executable
$(TARGET): $(LIB) testfs.o
	$(CC) testfs.o -L. -lvvsfs -o $@

# Create the static library
$(LIB): block.o image.o inode.o free.o pack.o
	ar rcs $@ $^

# Generic rule for compiling objects
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Test rule
test: $(TARGET)
	./$(TARGET)

# Clean rule
clean:
	rm -f *.o

# Pristine rule
pristine: clean
	rm -f $(TARGET) $(LIB) *.img

# Phony targets
.PHONY: all test clean pristine
