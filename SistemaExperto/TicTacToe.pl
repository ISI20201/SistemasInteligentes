
iniciarjuego :- nl, write('BIENVENIDO AL JUEGO DE X,0.'), nl, exp_mov, !, juegos,
!, nl, nl.
exp_mov:- nl, write('Visualiza la siguiente tabla para poder jugar,'), nl, write('para el movimiento que desees hacer:'), nl, nl,
write(' 1 | 2 | 3'), nl, imprime_linea,
write(' 4 | 5 | 6'), nl, imprime_linea,
write(' 7 | 8 | 9'), nl.

imprime_linea :- write(' -----------'), nl.
juegos:- juego,!, opcion_juego.
opcion_juego:- nl, write('Desea jugar otra partida (y/n)? '),
entrada_resp(Respuesta),!, proceso(Respuesta).
entrada_resp(Respuesta):- read(Contestacion), verif_resp(Contestacion,
Respuesta), !.

entrada_resp(Respuesta):- write('No es una entrada valida teclee y o n: '), entrada_resp(Respuesta). /* Vuelve a capturar la entrada*/

verif_resp(y, yes). verif_resp('Y', yes). verif_resp(yes, yes).
verif_resp('YES', yes). verif_resp('Yes', yes).
verif_resp(n, no). verif_resp('N', no). verif_resp(no, no).
verif_resp('NO', no). verif_resp('No', no).
proceso(no) :- !. 
proceso(yes) :- juegos. 
juego :- nl, write('con que deseas jugar x o 0? '), entrada_jugador(Jugador), nl,
write('Deseas jugar primero (y/n)? '), entrada_resp(Mov_jugador), !,
jugar(Jugador, Mov_jugador, 9, tablero(_,_,_,_,_,_,_,_,_)).

imprimir_tablero(tablero(V1, V2, V3, V4, V5, V6, V7, V8, V9)) :-
write(' '), escribir_Valor(V1), write('|'), escribir_Valor(V2), write('|'),
escribir_Valor(V3), nl, imprime_linea,
write(' '), escribir_Valor(V4), write('|'), escribir_Valor(V5), write('|'),
escribir_Valor(V6), nl, imprime_linea,
write(' '), escribir_Valor(V7), write('|'), escribir_Valor(V8), write('|'),
escribir_Valor(V9), nl, nl.
escribir_Valor(V) :- var(V), !, write(' ').
escribir_Valor(x) :- write(' x ').
escribir_Valor(0) :- write(' 0 ').
entrada_jugador(Jugador) :- read(Jugador), x_or_o(Jugador). 

entrada_jugador(Jugador) :- write('No es una respuesta valida teclee x o 0: '),
entrada_jugador(Jugador). 
x_or_o(x). x_or_o(0).
jugar(Jugador, Mov_jugador, Num_apertura, TABLERO) :-
primer_Movimiento(Jugador, Mov_jugador, TABLERO), !,
negacion(Mov_jugador, Nuevo_movjugador),
Apertura is Num_apertura - 1,
seguir_jugando(Jugador, Nuevo_movjugador, Apertura, TABLERO).
primer_Movimiento(Jugador, yes, TABLERO) :- !, movimiento_entrada(TABLERO,
Estado),
realiza_movimiento(m(Estado, Jugador), TABLERO). 
primer_Movimiento(Jugador, no, TABLERO) :- opuesto(Jugador, Ordenador),
generar_Mov(Ordenador, TABLERO, Estado),
write('Movimiento del ordenador: '), write(Estado), nl,
realiza_movimiento(m(Estado, Ordenador), TABLERO). 

negacion(yes, no). negacion(no, yes).
opuesto(x, 0). opuesto(0, x).
movimiento_entrada(TABLERO, Estado) :- nl, write('Movimiento del Jugador: '),
read(Estado),
estado_Tablero(Estado), argumentos_Tablero(Estado, TABLERO, Val), var(Val). 

movimiento_entrada(TABLERO, Estado) :- nl, write('No es valida la entrada.'),
movimiento_entrada(TABLERO, Estado). 
estado_Tablero(1). estado_Tablero(2). estado_Tablero(3). estado_Tablero(4).
estado_Tablero(5).
estado_Tablero(6). estado_Tablero(7). estado_Tablero(8). estado_Tablero(9).
argumentos_Tablero(1, tablero(Val,_,_,_,_,_,_,_,_), Val) :- !.
argumentos_Tablero(2, tablero(_,Val,_,_,_,_,_,_,_), Val) :- !.
argumentos_Tablero(3, tablero(_,_,Val,_,_,_,_,_,_), Val) :- !.
argumentos_Tablero(4, tablero(_,_,_,Val,_,_,_,_,_), Val) :- !.
argumentos_Tablero(5, tablero(_,_,_,_,Val,_,_,_,_), Val) :- !.
argumentos_Tablero(6, tablero(_,_,_,_,_,Val,_,_,_), Val) :- !.
argumentos_Tablero(7, tablero(_,_,_,_,_,_,Val,_,_), Val) :- !.
argumentos_Tablero(8, tablero(_,_,_,_,_,_,_,Val,_), Val) :- !.
argumentos_Tablero(9, tablero(_,_,_,_,_,_,_,_,Val), Val).
realiza_movimiento(m(Estado, Val), TABLERO) :- argumentos_Tablero(Estado,
TABLERO, Val),
imprimir_tablero(TABLERO).
generar_Mov(Ordenador, TABLERO, Estado) :- division(Pos1, Pos2, Pos3),
argumentos_Tablero(Pos1, TABLERO, Val1), argumentos_Tablero(Pos2,
TABLERO, Val2), argumentos_Tablero(Pos3, TABLERO, Val3),
movimiento_Ganador(Ordenador, Pos1, Pos2, Pos3, Val1, Val2, Val3, Estado), !.

generar_Mov(_, TABLERO, Estado) :- division(Pos1, Pos2, Pos3),
argumentos_Tablero(Pos1, TABLERO, Val1), argumentos_Tablero(Pos2,
TABLERO, Val2), argumentos_Tablero(Pos3, TABLERO, Val3),
movimiento_Obligado(Pos1, Pos2, Pos3, Val1, Val2, Val3, Estado), !.

generar_Mov(Ordenador, TABLERO, Pos3) :- diagonal(Pos1, Pos2, Pos3),
argumentos_Tablero(Pos1, TABLERO, Val1), argumentos_Tablero(Pos2,
TABLERO, Val2), argumentos_Tablero(Pos3, TABLERO, Val3),
proximo(Pos3, NbrA, NbrB),
argumentos_Tablero(NbrA, TABLERO, ValA), argumentos_Tablero(NbrB,
TABLERO, ValB),
movimiento_Especial(Ordenador, Val1, Val2, Val3, ValA, ValB), !.


generar_Mov(Ordenador, TABLERO, Pos3) :- diagonal(Pos1, Pos2, Pos3),
argumentos_Tablero(Pos1, TABLERO, Val1), argumentos_Tablero(Pos2,
TABLERO, Val2), argumentos_Tablero(Pos3, TABLERO, Val3),
proximo(Pos3, NbrA, NbrB),
argumentos_Tablero(NbrA, TABLERO, ValA), argumentos_Tablero(NbrB,
TABLERO, ValB),
movimiento_Especial2(Ordenador, Val1, Val2, Val3, ValA, ValB), !.


generar_Mov(Ordenador, TABLERO, Estado) :- division(Pos1, Pos2, Pos3),
argumentos_Tablero(Pos1, TABLERO, Val1), argumentos_Tablero(Pos2,
TABLERO, Val2), argumentos_Tablero(Pos3, TABLERO, Val3),
movimiento_Bueno(Ordenador, Pos1, Pos3, Val1, Val2, Val3, Estado),!.

generar_Mov(_, TABLERO, 5) :- argumentos_Tablero(5, TABLERO, Val), var(Val),!.

generar_Mov(_, TABLERO, Estado) :- esquina_Abierta(TABLERO, Estado), !.

generar_Mov(_, TABLERO, Estado) :- estado_Tablero(Estado),
argumentos_Tablero(Estado, TABLERO, Val), var(Val), !. 
division(1,2,3). division(4,5,6). division(7,8,9). division(1,4,7).
division(2,5,8). division(3,6,9). division(9,5,1). division(7,5,3).
diagonal(1,5,9). diagonal(9,5,1).
diagonal(3,5,7). diagonal(7,5,3).
proximo(1,2,4). proximo(3,2,6).
proximo(7,4,8). proximo(9,6,8).


movimiento_Ganador(Ordenador, Pos1,_,_, Val1, Val2, Val3, Pos1) :- var(Val1),
nonvar(Val2), Val2 == Ordenador, nonvar(Val3), Val3 == Ordenador, !.
movimiento_Ganador(Ordenador,_, Pos2,_, Val1, Val2, Val3, Pos2) :- var(Val2),
nonvar(Val1), Val1 == Ordenador, nonvar(Val3), Val3 == Ordenador, !.
movimiento_Ganador(Ordenador,_,_, Pos3, Val1, Val2, Val3, Pos3) :- var(Val3),
nonvar(Val1), Val1 == Ordenador, nonvar(Val2), Val2 == Ordenador, !.


movimiento_Obligado(_,_, Pos3, Val1, Val2, Val3, Pos3) :- var(Val3),
nonvar(Val1), nonvar(Val2), Val1 == Val2, !.
movimiento_Obligado(_, Pos2,_, Val1, Val2, Val3, Pos2) :- var(Val2),
nonvar(Val1), nonvar(Val3), Val1 == Val3, !.
movimiento_Obligado(Pos1,_,_, Val1, Val2, Val3, Pos1) :- var(Val1),
nonvar(Val2), nonvar(Val3), Val2 == Val3, !.
movimiento_Especial(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val2), var(Val3), nonvar(Val1), Val1 == Ordenador,
nonvar(ValA), ValA == Ordenador, nonvar(ValB), ValB == Ordenador, !.
movimiento_Especial(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val1), var(Val3), nonvar(Val2), Val2 == Ordenador,
nonvar(ValA), ValA == Ordenador, nonvar(ValB), ValB == Ordenador, !.
movimiento_Especial2(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val2), var(Val3), nonvar(Val1), Val1 == Ordenador,
nonvar(ValA), ValA == Ordenador, var(ValB), !.
movimiento_Especial2(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val1), var(Val3), nonvar(Val2), Val2 == Ordenador,
var(ValA), nonvar(ValB), ValB == Ordenador, !.
movimiento_Especial2(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val2), var(Val3), nonvar(Val1), Val1 == Ordenador,
var(ValA), nonvar(ValB), ValB == Ordenador, !.
movimiento_Especial2(Ordenador, Val1, Val2, Val3, ValA, ValB) :-
var(Val1), var(Val3), nonvar(Val2), Val2 == Ordenador,
nonvar(ValA), ValA == Ordenador, var(ValB), !.


movimiento_Bueno(Ordenador,_, Pos3, Val1, Val2, Val3, Pos3) :- var(Val2),
var(Val3), nonvar(Val1), Val1 == Ordenador, !.
movimiento_Bueno(Ordenador, Pos1,_, Val1, Val2, Val3, Pos1) :- var(Val1),
var(Val3), nonvar(Val2), Val2 == Ordenador, !.
movimiento_Bueno(Ordenador, Pos1, _, Val1, Val2, Val3, Pos1) :- var(Val1),
var(Val2), nonvar(Val3), Val3 == Ordenador, !.
esquina_Abierta(TABLERO, Estado) :- esquina(Estado),
argumentos_Tablero(Estado, TABLERO, Val), var(Val).
esquina(1). esquina(3). esquina(7). esquina(9).
seguir_jugando(Jugador,_,_, TABLERO) :- gano(Quien, TABLERO), 
!, perdedor(Quien, Jugador).
seguir_jugando(Jugador, Mov_jugador, Num_apertura, TABLERO) :-
Num_apertura < 3,
conseguir_Mov(Jugador, Mov_jugador, Mover),
    cuadro_Abierto(TABLERO, Posicion),
empate(Mover, Posicion, TABLERO), !,
write('Has empatado,No hay ganador.'), nl.

seguir_jugando(Jugador, Mov_jugador, Num_apertura, TABLERO) :-
jugar(Jugador, Mov_jugador, Num_apertura, TABLERO).

gano(Quien, TABLERO) :- division(Pos1, Pos2, Pos3), argumentos_Tablero(Pos1,
TABLERO, Val1),
nonvar(Val1), Quien = Val1, 
argumentos_Tablero(Pos2, TABLERO, Val2), nonvar(Val2), Val1 == Val2,
argumentos_Tablero(Pos3, TABLERO, Val3), nonvar(Val3), Val1 == Val3.
perdedor(Jugador, Jugador) :- !, write('Has ganado FELICIDADES!'), nl.
perdedor(_,_) :- write('Ha ganado el ordenador!'), nl.


conseguir_Mov(Jugador, yes, Jugador) :- !.
conseguir_Mov(Jugador, no, Ordenador) :- opuesto(Jugador, Ordenador).
cuadro_Abierto(TABLERO, Posicion) :-
findall(Pos, posicion_Abierta(TABLERO, Pos), Posicion).

posicion_Abierta(TABLERO, Pos) :- estado_Tablero(Pos),
argumentos_Tablero(Pos, TABLERO, Val), var(Val).
empate(Mover, Posicion, TABLERO) :-
not(verif_Ganador(Mover, Posicion, TABLERO)).
verif_Ganador(Mover, [Pos1, Pos2], TABLERO) :-
test2(Mover, Pos1, Pos2, TABLERO), !.

verif_Ganador(Mover, [Pos1, Pos2], TABLERO) :- !,
test2(Mover, Pos2, Pos1, TABLERO).
verif_Ganador(Mover, [Pos], TABLERO) :- test1(Mover, Pos, TABLERO).

test2(Mover, Pos1, Pos2, TABLERO) :- argumentos_Tablero(Pos1, TABLERO,
Mover),
opuesto(Mover, Next), argumentos_Tablero(Pos2, TABLERO, Next),
ganar(TABLERO).

test1(Mover, Pos, TABLERO) :- argumentos_Tablero(Pos,TABLERO, Mover),
ganar(TABLERO).

ganar(TABLERO) :- gano(x, TABLERO), !.
ganar(TABLERO) :- gano(0, TABLERO).