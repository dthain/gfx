example: example.o gfx.o
	gcc example.o gfx.o -o example -lX11 -lm

gfx.o: gfx.c gfx.h
	gcc gfx.c -o gfx.o -c

example.o: example.c
	gcc example.c -o example.o -c

clean:
	rm -f gfx.o example.o example
