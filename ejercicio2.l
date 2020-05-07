%{
#include <stdio.h>
%}

%option noyywrap

digito [0-9]
entero [0-9]+
punto_flot [0-9]{0,6}
punto_dob [0-9]{0,16}
letra [a-zA-Z]
espacio [ \t\n ]+
esps {espacio}

ID #({letra}|{digito})+
reservada if|else|while
aritmetico \+|-|\*|\/|\%
relacional <|>|<=|>=|==|<>
asignacion =
logico o|y|no
parentesis \(|\)|\{|\}|\;|\,
comentariomlinea "<*".*"*>"
%x comentariol
%x comentarioml
%%	

"--"	 BEGIN(comentariol);printf("<Comentario Línea, %s", yytext);
<comentariol>[^-\n]+	printf("< COMENTARIO : %s >", yytext);
<comentariol>\n 	printf(">\n");BEGIN(INITIAL);
"<*"	 BEGIN(comentarioml);printf("<Comentario M Línea, %s", yytext);
<comentarioml>[^*>]+	printf("< COMENTARIO : %s >", yytext);
<comentarioml>"*>" 	printf("< COMENTARIO : %s >", yytext);

{aritmetico} {printf("< ARITMÉTICO : %s > \n", yytext);}
{logico}+ {printf("< LÓGICO : %s > \n", yytext);}
{relacional} {printf("< RELACIONAL : %s > \n", yytext);}
{asignacion} {printf("< ASIGNACIÓN : %s > \n", yytext);}
@{reservada} {printf("< RESERVADA : %s > \n", yytext);}

{entero} {printf("< ENTERO : %s > \n", yytext);}
{entero}*"."{punto_dob} {printf("< DECIMAL : %s > \n", yytext);}
{ID} {printf("< IDENTIFICADOR : %s > \n", yytext);}
{espacio} {/*Ignorar los espacios en blanco*/}
{parentesis} {printf("< PUNTUACIÓN : %s > \n", yytext);}

"//"[^\n]*   {printf("< COMENTARIO : %s > \n", yytext);}
"/*"[^"*/"]*   {printf("< COMENTARIO : %s > \n", yytext);}
"\""[^"\""]*  {printf("< COMENTARIO : %s > \n", yytext);}
. {printf("Ha ocurrido un error léxico \n");}
%%

int main() {

	yylex();

}