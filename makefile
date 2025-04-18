# Detect OS (Linux/Windows(WSL) vs. macOS)
UNAME_S := $(shell uname -s)

# Project settings
TARGET = main
SRC_DIR = src
SRCS = $(SRC_DIR)/main.c
OBJS = $(SRCS:.c=.o)

# Your exact compiler flags (applied everywhere)
CFLAGS = -Wall -Werror -pedantic -ansi

# Only use -lm linker flag on Linux/WSL (not macOS)
ifeq ($(UNAME_S),Linux)
    LDFLAGS = -lm
else
    LDFLAGS = 
endif

# Default build target
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(TARGET)

run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run