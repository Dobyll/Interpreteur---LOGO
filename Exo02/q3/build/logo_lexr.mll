(*------------------------------------------------*)
(* Analyse lexicale pour le langage Logo          *)
(* Version avec boucles et opérations arithmétiques *)
(*------------------------------------------------*)

{
open Logo_parser

exception Not_recognized
exception Quit
}

(*----------------------------------------------*)
(* Expressions rationnelles utiles              *)
(*----------------------------------------------*)
let chiffre = ['0'-'9']
let minuscule = ['a'-'z']
let majuscule = ['A'-'Z']
let lettre = minuscule | majuscule
let ident = (minuscule | '_') (lettre | chiffre | '_')*
let entier = ('+' | '-')? chiffre+

(*----------------------------------------------*)
(* Lecture du prochain lexème                   *)
(*----------------------------------------------*)
rule read_lexeme = parse
  (* commentaires et espaces *)
  | "--" [^ '\n']* '\n' { read_lexeme lexbuf }
  | [' ' '\t']          { read_lexeme lexbuf }
  | '\n'                { read_lexeme lexbuf }

  (* mots-clefs *)
  | "Def"               { DEF }
  | "Avance"            { AVANCE }
  | "Recule"            { RECULE }
  | "Gauche"            { GAUCHE }
  | "Droite"            { DROITE }
  | "Efface"            { EFFACE }
  | "Dessine"           { DESSINE }
  | "Deplace"           { DEPLACE }
  | "Repete"            { REPETE }

  (* constantes et identificateurs *)
  | entier              { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ident               { IDENT (Lexing.lexeme lexbuf) }

  (* ponctuations et symboles *)
  | ':'                 { COLON }
  | ';'                 { SEMI }
  | '.'                 { DOT }
  | '['                 { CROOU }
  | ']'                 { CROFE }
  | '('                 { PAROU }
  | ')'                 { PARFE }

  (* opérateurs arithmétiques *)
  | '+'                 { PLUS }
  | '-'                 { MINUS }
  | '*'                 { MULT }
  | '/'                 { DIV }
  | '%'                 { MOD }

  (* fin de fichier et erreur lexicale *)
  | eof                 { raise Quit }
  | _                   { raise Not_recognized }