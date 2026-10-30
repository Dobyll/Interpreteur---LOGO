{
open Logo_parser

exception Not_recognized
exception Quit
}

let chiffre = ['0'-'9']
let minuscule = ['a'-'z']
let majuscule = ['A'-'Z']
let lettre = minuscule | majuscule
let ident = (minuscule | '_') (lettre | chiffre | '_')*
let entier = ('+' | '-')? chiffre+

rule read_lexeme = parse
  | [' ' '\t']      { read_lexeme lexbuf }
  | '\n'            { read_lexeme lexbuf }
  | "Def"           { DEF }
  | "Avance"        { AVANCE }
  | "Recule"        { RECULE }
  | "Gauche"        { GAUCHE }
  | "Droite"        { DROITE }
  | "Efface"        { EFFACE }
  | "Dessine"       { DESSINE }
  | "Deplace"       { DEPLACE }
  | entier          { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | ident           { IDENT (Lexing.lexeme lexbuf) }
  | ':'             { COLON }
  | ';'             { SEMI }
  | '.'             { DOT }
  | eof             { raise Quit }
  | _               { raise Not_recognized }