(*------------------------------------------------*)
(* Analyse lexicale de test pour le langage Logo  *)
(* Affiche les lexèmes reconnus dans l'entrée     *)
(*------------------------------------------------*)

{
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
(* Lecture et affichage des lexèmes             *)
(*----------------------------------------------*)
rule read_lexeme = parse
  (* espaces et retours à la ligne *)
  | [' ' '\t']      { read_lexeme lexbuf }
  | '\n'            { print_string "fin de ligne" ;
                      print_newline () ;
                      read_lexeme lexbuf }

  (* mots-clefs et commandes *)
  | "Def"           { print_string "mot-clef Def" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Avance"        { print_string "commande Avance" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Recule"        { print_string "commande Recule" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Gauche"        { print_string "commande Gauche" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Droite"        { print_string "commande Droite" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Efface"        { print_string "commande Efface" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Dessine"       { print_string "commande Dessine" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | "Deplace"       { print_string "commande Deplace" ;
                      print_newline () ;
                      read_lexeme lexbuf }

  (* constantes et identificateurs *)
  | entier          { print_string ("entier : " ^ (Lexing.lexeme lexbuf)) ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | ident           { print_string ("identificateur : " ^ (Lexing.lexeme lexbuf)) ;
                      print_newline () ;
                      read_lexeme lexbuf }

  (* ponctuations *)
  | ':'             { print_string "deux-points" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | ';'             { print_string "point-virgule" ;
                      print_newline () ;
                      read_lexeme lexbuf }
  | '.'             { print_string "point final" ;
                      print_newline () ;
                      read_lexeme lexbuf }

  (* fin de fichier et erreur lexicale *)
  | eof             { raise Quit }
  | _               { print_string ("lexeme non reconnu : " ^ (Lexing.lexeme lexbuf)) ;
                      print_newline () ;
                      read_lexeme lexbuf }