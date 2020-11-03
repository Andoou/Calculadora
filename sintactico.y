%{
  #include <stdio.h>
  #include <string.h>
  #define YYDEBUG 1
  extern int yylex(void);
  extern char *yytext;
  void yyerror (char*);
  %}

%union{
    struct complejo{
    float re;
    float im;
    } com;

  float re;
  float im; 

}

%token ID
%token FINLINEA
%token <re> ENTERO
%token <im> IMAGINARIO
%token PAR_DER PAR_IZQ
%token IGUAL
%left SUMA
%left RESTA
%left POR
%left ENTRE

%type <com> e


%%
s: e FINLINEA {if($1.im>0) printf("-> %.2f%+.2fi\n", $1.re, $1.im);
    else printf("-> %.2f%.2fi\n", $1.re, $1.im);}
;

e:  e SUMA e   { $$.re = $1.re + $3.re; $$.im = $1.im + $3.im;}
  | e RESTA e   { $$.re = $1.re - $3.re; $$.im = $1.im - $3.im;}
  | e POR e   { $$.re = ($1.re * $3.re) - ($1.im * $3.im); $$.im = ($1.re * $3.im) + ($1.im * $3.re);}
  | e ENTRE e   { $$.re = (($1.re * $3.re) + ($1.im * $3.im))/(($3.re*$3.re)+($3.im*$3.im));
                  $$.im = (($1.re * -1 * $3.im) + ($1.im * $3.re))/(($3.re*$3.re)+($3.im*$3.im));}
  | PAR_IZQ ENTERO IMAGINARIO PAR_DER  { $$.re=$2; $$.im=$3;}
  
;

%%

void yyerror(char *s)
{
  printf("Error sintactico %s",s);
}

int main(int argc,char **argv)
{
  yydebug = 0;
  yyparse();
  return 0;
}
