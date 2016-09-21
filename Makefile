# Makefile

OBJS	= bison.o lex.o

CC	= g++ 2> /dev/null
CFLAGS	= -g -ansi -pedantic

a.out:		$(OBJS)
		$(CC) $(CFLAGS) $(OBJS) -lfl

lex.o:		lex.c
		$(CC) $(CFLAGS) -c lex.c -o lex.o

lex.c:		Assignment2.l 
		flex Assignment2.l
		cp lex.yy.c lex.c

bison.o:	bison.c
		$(CC) $(CFLAGS) -c bison.c -o bison.o

bison.c:	Assignment2.y
		bison -d -v Assignment2.y
		cp Assignment2.tab.c bison.c
		cmp -s Assingment2.tab.h tok.h || cp Assignment2.tab.h tok.h

lex.o	: tok.h

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c tok.h Assignment2.tab.* Assignment2.output bison_output.txt

