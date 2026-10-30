
%{
open Logo_ast
%}


%token DEF AVANCE RECULE GAUCHE DROITE EFFACE DESSINE DEPLACE
%token COLON SEMI DOT
%token EOF
%token <int> INT
%token <string> IDENT


%start main
%type <unit> main

%%


main :
| seq DOT { print_string "La syntaxe est ok !\n" }
;


seq :
| instr { print_string "regle seq : instr\n" }
| instr SEMI seq { print_string "regle seq : instr SEMI seq\n" }
;


instr :
| DEF IDENT expr { print_string "regle instr : DEF IDENT expr\n" }
| cmd { print_string "regle instr : cmd\n" }
;


cmd :
| AVANCE expr { print_string "regle cmd : AVANCE expr\n" }
| RECULE expr { print_string "regle cmd : RECULE expr\n" }
| GAUCHE expr { print_string "regle cmd : GAUCHE expr\n" }
| DROITE expr { print_string "regle cmd : DROITE expr\n" }
| EFFACE { print_string "regle cmd : EFFACE\n" }
| DESSINE { print_string "regle cmd : DESSINE\n" }
| DEPLACE { print_string "regle cmd : DEPLACE\n" }
;


expr :
| INT { print_string "regle expr : INT\n" }
| COLON IDENT { print_string "regle expr : COLON IDENT\n" }
;