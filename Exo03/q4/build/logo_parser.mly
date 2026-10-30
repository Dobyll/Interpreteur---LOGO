
%{
open Logo_ast
%}

%token DEF AVANCE RECULE GAUCHE DROITE EFFACE DESSINE DEPLACE
%token REPETE CROOU CROFE
%token PAROU PARFE PLUS MINUS MULT DIV MOD
%token SI ALORS SINON FINSI
%token EQ GT LT
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
| REPETE expr CROOU seq CROFE { Repeat ($2, $4) }
| SI bexpr ALORS seq SINON seq FINSI { If ($2, $4, $6) }
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
| PAROU expr PLUS expr PARFE { Opbin (Plus, $2, $4) }
| PAROU expr MINUS expr PARFE { Opbin (Minus, $2, $4) }
| PAROU expr MULT expr PARFE { Opbin (Mult, $2, $4) }
| PAROU expr DIV expr PARFE { Opbin (Div, $2, $4) }
| PAROU expr MOD expr PARFE { Opbin (Mod, $2, $4) }
;

bexpr :
| PAROU expr EQ expr PARFE { Cmp (Eq, $2, $4) }
| PAROU expr GT expr PARFE { Cmp (Greater, $2, $4) }
| PAROU expr LT expr PARFE { Cmp (Lower, $2, $4) }
;