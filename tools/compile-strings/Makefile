TARGET = ../compile-str
SRC = $(wildcard *.c)
OBJ = $(patsubst %.c, %.o, $(SRC))
CC = cc

all: clean $(TARGET)

clean:
	rm -f *.o
	rm -f $(TARGET)

$(TARGET): $(OBJ)
	$(CC) -o $@ $?

obj/%.o: src/%.c
	$(CC) -c $< -o $@