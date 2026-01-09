% --------------------------
% Faits
% --------------------------
couleur(pomme, rouge).
couleur(ballon, bleu).
couleur(citron, jaune).
couleur(carotte, orange).

mange(romain, pomme).
mange(lea, citron).
mange(sarah, pomme).
mange(bob, carotte).
mange(claire, banane).

type(pomme, fruit).
type(citron, fruit).
type(banane, fruit).
type(carotte, legume).

homme(pierre).
homme(luc).
homme(andre).

femme(marie).
femme(sara).

parent(pierre, luc).
parent(marie, luc).
parent(andre, pierre).
parent(sara, marie).

% --------------------------
% Règles
% --------------------------

% X aime Y si X mange Y
aime(X, Y) :-
    mange(X, Y).

% Aime un fruit
aime_fruit(Personne) :-
    mange(Personne, Aliment),
    type(Aliment, fruit).

% Même couleur
meme_couleur(X, Y) :-
    couleur(X, C),
    couleur(Y, C),
    X \= Y.

% Mangent la même chose
aiment_la_meme_chose(A, B) :-
    mange(A, X),
    mange(B, X),
    A \= B.

% --------------------------
% Listes
% --------------------------

% Longueur d'une liste
longueur([], 0).
longueur([_|T], N) :-
    longueur(T, N1),
    N is N1 + 1.

% Somme d'une liste
somme([], 0).
somme([H|T], S) :-
    somme(T, S1),
    S is H + S1.

% Membre d'une liste
membre(X, [X|_]).
membre(X, [_|T]) :-
    membre(X, T).

% Maximum d'une liste
max_liste([X], X).
max_liste([H|T], Max) :-
    max_liste(T, MaxT),
    (H > MaxT -> Max = H ; Max = MaxT).

% --------------------------
% Relations familiales
% --------------------------

% Père
pere(P, E) :-
    homme(P),
    parent(P, E).

% Mère
mere(M, E) :-
    femme(M),
    parent(M, E).

% Grand-parent
grand_parent(GP, E) :-
    parent(GP, P),
    parent(P, E).

% Ancêtre (récursif)
ancetre(A, E) :-
    parent(A, E).
ancetre(A, E) :-
    parent(A, X),
    ancetre(X, E).

% Frère ou sœur
frere_ou_soeur(A, B) :-
    parent(P, A),
    parent(P, B),
    A \= B.


//?- couleur(X, rouge).
X = pomme.

?- aime_fruit(X).
X = romain .

?- grand_parent(sara, luc).
true.

?- somme([1,2,3], S).
S = 6.

?- max_liste([5,2,9,1], M).
M = 9 .

?- frere_ou_soeur(luc, X).
false.
//