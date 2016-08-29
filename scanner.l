/* 1º Trabalho de compiladores */
/* Aluno: Leonardo Santos Paulucio */
/* Scanner para Linguagem C-Minus */

/* Opcoes flex */
%option outfile="scanner.c"
%option noyywrap
%option nounput
%option noinput

%{
    #include <stdio.h>
    #include <stdlib.h>

	void process(const char*);
	void process_error();
%}

/*Palavras Reservadas*/
ELSE "else"
IF "if"
INPUT "input"
INT "int"
OUTPUT "output"
RETURN "return"
VOID "void"
WHILE "while"
WRITE "write"
/*Operadores Aritmeticos e de comparacao*/
PLUS "+"
MINUS "-"
TIMES "*"
OVER "/"
LT "<"
LE "<="
GT ">"
GE ">="
EQ "=="
NEQ "!="
ASSIGN "="
/*Tokens*/
SEMI ";"
COMMA ","
LPAREN "("
RPAREN ")"
LBRACK "["
RBRACK "]"
LBRACE "{"
RBRACE "}"

ID [a-zA-Z]+[a-zA-Z0-9]*
NUM [0-9]+
STRING \".*\"

/* Multi-line comments are handled in the rules section. First we need to define a start condition. */
%x          L_COMMENT ML_COMMENT

%%
{ELSE} {process("ELSE");}
{IF} {process("IF");}
{INPUT} {process("INPUT");}
{INT} {process("INT");}
{OUTPUT} {process("OUTPUT");}
{RETURN} {process("RETURN");}
{VOID} {process("VOID");}
{WHILE} {process("WHILE");}
{WRITE} {process("WRITE");}

{PLUS} {process("PLUS");}
{MINUS} {process("MINUS");}
{TIMES} {process("TIMES");}
{OVER} {process("OVER");}
{LT} {process("LT");}
{LE} {process("LE");}
{GT} {process("GT");}
{GE} {process("GE");}
{EQ} {process("EQ");}
{NEQ} {process("NEQ");}
{ASSIGN} {process("ASSIGN");}

{SEMI} {process("SEMI");}
{COMMA} {process("COMMA");}
{LPAREN} {process("LPAREN");}
{RPAREN} {process("RPAREN");}
{LBRACK} {process("LBRACK");}
{RBRACK} {process("RBRACK");}
{LBRACE} {process("LBRACE");}
{RBRACE} {process("RBRACE");}
{NUM} {process("NUM");}
{ID} {process("ID");}
{STRING} { process("STRING");}

[ \t]+          /* eat up whitespace */
"\n"            yylineno++; /* eat up a single line */

"//"                 BEGIN(L_COMMENT); /* line comments */
<L_COMMENT>[^\n]* /* eat anything that’s not a \n */
<L_COMMENT>"\n"    yylineno++; BEGIN(INITIAL);

"/*"                 BEGIN(ML_COMMENT); /* multi-line comments */
<ML_COMMENT>[^\n] /* eat anything that’s not a \n */
<ML_COMMENT>"\n"    yylineno++;
<ML_COMMENT>"*/"    BEGIN(INITIAL);

. {process_error();}

%%
void process(const char* token)
	{
		printf("%d: %s -> %s\n",yylineno, yytext, token);
	}

void process_error() {
    printf("%d: %s -> %s\n", yylineno, yytext, "UNKNOWN");
}

int main() {
  yylex();

  return EXIT_SUCCESS;
}
