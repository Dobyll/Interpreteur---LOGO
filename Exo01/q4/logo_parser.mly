%{
open Logo_ast
%}

%token DEF AVANCE RECULE GAUCHE DROITE EFFACE DESSINE DEPLACE
%token COLON SEMI DOT
%token EOF
%token <int> INT
%token <string> IDENT

%start main
%type <Logo_ast.t_instr> main

%%

main :
| seq DOT { $1 }
;

seq :
| instr { $1 }
| instr SEMI seq { Seq ($1, $3) }
;

instr :
| DEF IDENT expr { Define ($2, $3) }
| cmd { Cmd $1 }
;

cmd :
| AVANCE expr { Forward $2 }
| RECULE expr { Backward $2 }
| GAUCHE expr { Left $2 }
| DROITE expr { Right $2 }
| EFFACE { Clear }
| DESSINE { PenDown }
| DEPLACE { PenUp }
;

expr :
| INT { Cst $1 }
| COLON IDENT { Var $2 }
;