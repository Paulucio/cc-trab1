all: flex gcc
	@echo "Done."

flex: scanner.l
	flex scanner.l

gcc: scanner.c
	gcc -Wall scanner.c -o trab1

clean:
	@rm -f scanner.c trab1
