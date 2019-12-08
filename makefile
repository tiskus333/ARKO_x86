CC = gcc
CFLAGS = -Wall -m64

all: main.o getdec.o
	$(CC) $(CFLAGS) -o getdec main.o getdec.o

getdec.o: getdec.s
	nasm -f elf64 -o getdec.o getdec.s

main.o: main.c
	$(CC) $(CFLAGS) -c -o main.o main.c

clean:
	rm -f *.o

