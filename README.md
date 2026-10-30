# Interpréteur LOGO – Analyse lexicale et syntaxique en OCaml

Projet universitaire réalisé en binôme en L2 Informatique à l'Université de Poitiers (matière ITLP).

## Le projet
Interpréteur pour un petit langage de dessin « à la LOGO », avec des mots-clés en français. Les programmes déplacent une tortue qui dessine à l'écran. Le projet est construit en trois étapes : commandes de base, expressions arithmétiques, puis boucles et conditions.

Exemple de programme :

    Def cotes 10 ;
    Si (:cotes > 2) Alors Repete :cotes [Avance 60; Droite (360 / :cotes)]
    Sinon Avance 60 FinSi .

## Fonctionnalités
- Commandes de la tortue : `Avance`, `Recule`, `Gauche`, `Droite`, `Dessine`, `Deplace`, `Efface`
- Variables avec `Def`
- Expressions arithmétiques : `+`, `-`, `*`, `/`, `mod`
- Boucles (`Repete n [ ... ]`) et conditions (`Si ... Alors ... Sinon ... FinSi`)
- Boucle d'interaction (REPL) qui affiche l'état de la tortue et des variables après chaque programme

## Notions utilisées
- OCaml et programmation fonctionnelle
- Analyse lexicale avec ocamllex
- Analyse syntaxique avec ocamlyacc (grammaire)
- Arbre syntaxique abstrait (AST) et interprétation

## Répartition du code
- **Fournis par l'enseignant** : l'environnement des variables (`env.ml`), la géométrie et la tortue (`geometry.ml`, `turtle.ml`, `turtle_graphic.ml`), la boucle d'interaction (`repl_logo.ml`), le `Makefile` et le squelette de l'AST
- **Écrits par le binôme** : les analyseurs lexicaux (`.mll`), les grammaires (`.mly`), l'extension de l'AST et les fonctions d'interprétation, pour chaque étape (`Exo01` à `Exo03`)

## Lancer le projet
Avec OCaml installé, depuis un dossier `build` (par exemple `Exo03/q4/build`) :

    bash compile.sh
    ./repl_logo < test_exo3.logo

## Auteurs
- Folawe SABINO
- Kassim DIAKITE
