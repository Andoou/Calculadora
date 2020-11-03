%{
    #include"sintactico.tab.h"
%}

digito [0-9]
entero  "-"?{digito}+("."{digito}+)?
imaginario [+-]?{digito}+("."{digito}+)?"i"

%%

{entero}       {yylval.im= atof(yytext);return ENTERO;}
{imaginario}    {yylval.re= atof(yytext); return IMAGINARIO;}
"\n"    {return FINLINEA;}
"("     {return PAR_IZQ;}
")"     {return PAR_DER;}
"+"     {return SUMA;}
"-"     {return RESTA;}
"*"     {return POR;}
"/"     {return ENTRE;}
"="     {return IGUAL;}
" "     ;

%%
int yywrap(){ return 0;}
