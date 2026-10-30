#!/bin/bash

# Nettoyage
rm -f *.cmi *.cmo repl_logo logo_lexr.ml logo_parser.ml logo_parser.mli

# Génération
ocamllex logo_lexr.mll
ocamlyacc logo_parser.mly

# Compilation
ocamlc -c env.ml
ocamlc -c geometry.ml
ocamlc -c turtle.ml
ocamlc -c logo_ast.ml
ocamlc -c logo_parser.mli
ocamlc -c logo_parser.ml
ocamlc -c logo_lexr.ml


ocamlc -o repl_logo env.cmo geometry.cmo turtle.cmo logo_ast.cmo logo_parser.cmo logo_lexr.cmo repl_logo.ml

echo "Compilation terminée"
