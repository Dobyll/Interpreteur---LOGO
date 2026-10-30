(***************************************)
(*                                     *)
(*  Syntaxe abstraite pour un langage  *)
(*  "à la Logo"                        *)
(*                                     *)
(***************************************)

open Env
;;

open Turtle

(* Decommenter si tortue graphique *)
(*
open Turtle_graphic
;;
*)

(*--------------------------------------------*)
(* type pour représenter l'état de la mémoire *)
(* La mémoire est l'ensemble des liaisons     *)
(* (variable, valeur) et une tartue           *)
(*--------------------------------------------*)
type t_state =
  Env.t_env * Turtle.t_turtle
;;

(*---------------------------------------------*)
(* types pour représenter la syntaxe abstraite *)
(* du langage                                  *)
(*---------------------------------------------*)

(*--------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des opérateurs binaires    *)
(* arithmétiques                                                *)
(*--------------------------------------------------------------*)
type t_opbin =
  | Plus
  | Minus
  | Mult
  | Div
  | Mod
;;

(*--------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des expressions            *)
(* Pour le moment, il n'y a que les constantes et les variables *)
(*--------------------------------------------------------------*)
type t_expr =
  | Cst of int
  | Var of t_ident
  | Opbin of t_opbin * t_expr * t_expr
;;

(*--------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des commandes de la tortue *)
(*--------------------------------------------------------------*)
type t_cmd =
  | Forward of t_expr
  | Backward of t_expr
  | Right of t_expr
  | Left of t_expr
  | PenUp
  | PenDown
  | Clear
;;

(*--------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des opérateurs             *)
(* de comparaison                                               *)
(*--------------------------------------------------------------*)

type t_opcmp =
  | Eq
  | Greater
  | Lower
;;

(*--------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des expressions            *)
(* booléennes, ici des comparaisons                             *)
(*--------------------------------------------------------------*)

type t_bexpr =
  | Cmp of t_opcmp * t_expr * t_expr
;;

(*-------------------------------------------------------------------*)
(* Le type pour la syntaxe abstraite des instructions du langage     *)
(* Pour le moment, il y a la définition de la valeur d'une variable, *)
(* une commande pour la tartue et une suite d'instructions           *)
(*-------------------------------------------------------------------*)
type t_instr =
  | Define of t_ident * t_expr
  | Cmd of t_cmd
  | Seq of t_instr * t_instr
  | Repeat of t_expr * t_instr
  | If of t_bexpr * t_instr * t_instr
;;


(*------------------------------------------------------------------------*)
(* Fonctions d'interprétation                                             *)
(*------------------------------------------------------------------------*)

(*------------------------------------------------*)
(* Interprétation d'une expression                *)
(*   @param env : environnement qui contient les  *)
(*                valeurs des variables           *)
(*   @param e   : l'expression à interpéter       *)
(*                                                *)
(*   @return    : valeur de l'expression          *)
(*------------------------------------------------*)
let rec interp_expr (env : t_env) (e : t_expr) : int =
  match e with
  | Cst n -> n
  | Var id -> value_of id env
  | Opbin (op, e1, e2) ->
      let v1 = interp_expr env e1 in
      let v2 = interp_expr env e2 in
      match op with
      | Plus -> v1 + v2
      | Minus -> v1 - v2
      | Mult -> v1 * v2
      | Div -> v1 / v2
      | Mod -> v1 mod v2
;;

(*-----------------------------------------------------*)
(* Interprétation d'une expression booléenne           *)
(*   @param env : environnement qui contient les       *)
(*                valeurs des variables                *)
(*   @param b   : l'expression booléenne à interpréter *)
(*                                                     *)
(*   @return    : valeur booléenne de l'expression     *)
(*-----------------------------------------------------*)

let interp_bexpr (env : t_env) (b : t_bexpr) : bool =
  match b with
  | Cmp (op, e1, e2) ->
      let v1 = interp_expr env e1 in
      let v2 = interp_expr env e2 in
      match op with
      | Eq -> v1 = v2
      | Greater -> v1 > v2
      | Lower -> v1 < v2
;;


(*-----------------------------------------------------*)
(* Interprétation d'une commande                       *)
(*   @param c   : la commande à interpéter             *)
(*   @param s   : un état composé d'un environnement   *) 
(*                et de la tortue courante             *)
(*                                                     *)
(*   @return    : la nouvelle tortue après l'exécution *)
(*                de la commande                       *)
(*-----------------------------------------------------*)
let interp_cmd (c : t_cmd) (s : t_state) : t_turtle =
  let (env, t) = s in
  match c with
  | Forward e  -> move_fwd t (interp_expr env e)
  | Backward e -> move_bck t (interp_expr env e)
  | Right e    -> turn_right t (interp_expr env e)
  | Left e     -> turn_left t (interp_expr env e)
  | PenUp      -> nodraw t
  | PenDown    -> draw t
  | Clear      -> reset()
;;


(*-----------------------------------------------------*)
(* Itération d'une fonction                            *)
(*   @param n : nombre d'itérations                    *)
(*   @param f : fonction à appliquer                   *)
(*   @param a : valeur initiale                        *)
(*                                                     *)
(*   @return  : résultat de n applications de f à a    *)
(*-----------------------------------------------------*)

let rec iterate n f a =
  if n > 0
  then iterate (n - 1) f (f a)
  else a
;;

(*-----------------------------------------------------*)
(* Interprétation d'une instruction                    *)
(*   @param c   : l'instruction à interpéter           *)
(*   @param s   : un état composé d'un environnement   *) 
(*                et de la tortue courante             *)
(*                                                     *)
(*   @return    : le nouvel état après l'exécution     *)
(*                de l'instruction                     *)
(*-----------------------------------------------------*)

let rec interp_instr (i : t_instr) (s : t_state) : t_state =
  let (env, t) = s in
  match i with
  | Define (id, e) -> let v = interp_expr env e in (add_binding env id v, t)
  | Cmd c -> (env, interp_cmd c s)
  | Seq (i1, i2) -> let s1 = interp_instr i1 s in interp_instr i2 s1
  | Repeat (e, i1) ->  let f s1 = interp_instr i1 s1 in iterate (interp_expr env e) f s
  | If (b, i1, i2) -> if interp_bexpr env b
                      then interp_instr i1 s
                      else interp_instr i2 s
;;


 
