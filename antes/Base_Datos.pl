%  ValheimBot - Proyecto N°2, Fundamentos de Inteligencia Artificial
%  Puntos 2 y 3: conocimiento en lógica de primer orden + chatbot en Prolo

% Trabajo de grupo 
% Alumnos 
% Nadia Álvarez  
% 
% 

% ESTRUCTURA DE CONOCIMIENTO EN LÓGICA DE PRIMER ORDEN
% BASE DE CONOCIMIENTO: Base_Datos.pl
% HECHOS 
% REGLAS
% CHATBOT 
% USUARIO Y SUS SUPER PREGUNTAS
% COSO BUSCA LA RESPUESTA EN LA BASE DE CONOCIMIENTO Y LE DEVUELVE AL USUARIO1

% ESTO PERMITE TRATAR LOS CARACTERES ESPECIALES COMO TILDES Y Ñ
:- set_prolog_flag(encoding, utf8).

% EL . LO USUAMOS PAR CADA HECHO O REGLA TERMINA CON UN PUNTO 
% EL :- ES UNA REGLA, NO UN HECHO, Y SE USA PARA DEFINIR RELACIONES ENTRE HECHOS
% EL , ES UN Y LÓGICO, SE USA PARA DECIR QUE AMBAS COSAS SON VERDADERAS
% EL ; ES UN O LÓGICO, SE USA PARA DECIR QUE UNA DE LAS COSAS ES VERDADERA
% EL _ ES UN VARIABLE ANÓNIMA, SE USA PARA DECIR QUE NO NOS IMPORTA EL VALOR DE ESA VARIABLE
% LAS VARIABLES EN PROLOG SON SENSIBLES A MAYÚSCULAS Y MINÚSCULAS, LAS VARIABLES EMPIEZAN CON MAYÚSCULA Y LOS HECHOS CON MINÚSCULA
% EL = ES PARA INTERTAR UNIFICAR DOS COSAS, SI SON IGUALES, SE UNIFICAN, SI NO, FALLA
% EL == ES PARA COMPARAR DOS COSAS, SI SON IGUALES, SE UNIFICAN, SI NO, FALLA

% HECHOS - BIOMA 
bioma(praderas).
bioma(bosque_negro).
bioma(pantano).
bioma(montaña).
bioma(llanuras).
bioma(tierras_de_niebla).

% ORDEN DE LOS BIOMAS
orden_bioma(praderas,          1).
orden_bioma(bosque_negro,      2).
orden_bioma(pantano,           3).
orden_bioma(montaña,           4).
orden_bioma(llanuras,          5).
orden_bioma(tierras_de_niebla, 6).

% JEFES 
jefe(eikthyr).
jefe(el_anciano).
jefe(bonemass).
jefe(moder).
jefe(yagluth).
jefe(la_reina).
 
% JEFE DEL BIOMA XXXXX
jefe_DE(eikthyr,    praderas).
jefe_DE(el_anciano, bosque_negro).
jefe_DE(bonemass,   pantano).
jefe_DE(moder,      montaña).
jefe_DE(yagluth,    llanuras).
jefe_DE(la_reina,   tierras_de_niebla).

% invoca(JEFE, OBJETO_INVOCACION, CANTIDAD)
invoca(eikthyr,    trofeo_de_ciervo,  2).
invoca(el_anciano, semilla_ancestral, 3).
invoca(bonemass,   huesos_marchitos,  10).
invoca(moder,      huevo_de_dragon,   3).
invoca(yagluth,    totem_fuling,      5).
invoca(la_reina,   tejido_blando,     3).

% botin(JEFE, OBJETO)
botin(eikthyr,    asta_dura).
botin(el_anciano, llave_del_pantano).
botin(bonemass,   hueso_de_los_deseos).
botin(moder,      lagrima_de_dragon).

% RECURSOS Y DONDE SE ENCUENTRAN
recurso_en(madera,          praderas).
recurso_en(pedernal,        praderas).
recurso_en(cobre,           bosque_negro).
recurso_en(estano,          bosque_negro).
recurso_en(chatarra_hierro, pantano).
recurso_en(mena_de_plata,   montaña).

% ENEMIGOS EN CADA BIOMA ,, SON MAS PERO TERMINO MAÑANA
enemigo_en(jabali,                praderas).
enemigo_en(nek,                   praderas).
enemigo_en(greydwarf,             bosque_negro).
enemigo_en(troll,                 bosque_negro).
enemigo_en(draugr,                pantano).
enemigo_en(blob,                  pantano).
enemigo_en(lobo,                  montaña).
enemigo_en(dragonete,             montaña).
enemigo_en(fuling,                llanuras).
enemigo_en(mosquito_de_la_muerte, llanuras).
enemigo_en(buscador,              tierras_de_niebla).

% receta(PRODUCTO, ESTACION, LISTA DE INGREDIENTES)
estacion(banco_de_trabajo).
estacion(forja).
estacion(fundidor).

% XATO DE TANTOS ESPACIOS PERO ES QUE NO SE ENTIENDO TODO JUNTO OC
receta(hacha_de_pedernal, banco_de_trabajo, [madera, pedernal]).
receta(pico_de_asta,      banco_de_trabajo, [madera, asta_dura]).
receta(bronce,            fundidor,         [cobre, estano]).
receta(hierro,            fundidor,         [chatarra_hierro]).
receta(plata,             fundidor,         [mena_de_plata]).
receta(hacha_de_bronce,   forja,            [madera, bronce]).
receta(espada_de_hierro,  forja,            [madera, hierro]).

% APODOS PA CACHAR QUE SE HABLA DE LO MISMO, PORQUE EL USUARIO NO VA A ESCRIBIR EXACTAMENTE COMO ESTA EN LA BASE DE DATOS DAAAA
alias(anciano,  el_anciano).
alias(elder,    el_anciano).
alias(reina,    la_reina).
alias(bosque,   bosque_negro).
alias(niebla,   tierras_de_niebla).
alias(montanas, montaña).

% ----------------------------------------------------------------------------------

% REGLAS
% IDEA DADA ES - "A" ES UN JEFE ANTERIOR A "B" SI EL BIOMA DE "A" APARECE ANTES QUE EL BIOMA DE "B"
jefe_previo(A, B) :-
    jefe_de(A, BiomaA),
    jefe_de(B, BiomaB),
    orden(BiomaA, NA),
    orden(BiomaB, NB), 
    NA < NB.
 
% bases(Item, Bases): materiales basicos (que no se fabrican) para hacer Item.
% si un ingrediente tambien tiene receta, se desarma too
bases(Item, Bases) :-
    receta(Item, _, Ingredientes),
    findall(B, (member(X, Ingredientes), base_de(X, B)), Lista),
    sort(Lista, Bases).
 
base_de(X, B) :- receta(X, _, _), !, bases(X, Bs), member(B, Bs). % X se fabrica: desarmarlo
base_de(X, X).  % X ya es basico



% --- CHAT BOT ¿Preguntas tengo entendido? ---
chatbot :-
    % MENSAJITO DEAAA muy literal el escribir ln sjjsjs
    writeln('ValheimBot: Hola vikingo, pregunta algo de Valheim, sin tildes, porfa. Escribe "ayuda" o "salir"'),
    bucle.
 
% Lee una linea,,, la pasa a minusculas y responde,,, Se repite hasta "salir"
bucle :-
    write('> '),
    read_line_to_string(user_input, Texto),
    (   Texto == end_of_file
    ->  true
    ;   downcase_atom(Texto, Linea),
        (   contiene(Linea, salir)
        ->  writeln('ValheimBot: xao vikingo, vuelve pronto')
        ;   responder(Linea),
            bucle
        )
    ).
 
% contiene(Linea, Palabra): la Palabra aparece dentro de la Linea.
contiene(Linea, Palabra) :- sub_atom(Linea, _, _, _, Palabra).
 
% --- responder --- REGLA POR PREGUNTA ---
% Se prueban en orden. El "!" (corte) hace que, apenas una funciona,
% no se pruebe ninguna de las siguientes.
 
% "como invoco a eikthyr"
responder(L) :-
    contiene(L, invoc),
    jefe_de(J, _), contiene(L, J), !,
    invoca(J, Objeto, N),
    format('ValheimBot: Para invocar a ~w necesitas ~w x~w.~n', [J, Objeto, N]).
 
% "que jefes van antes de moder"
responder(L) :-
    contiene(L, antes),
    jefe_de(J, _), contiene(L, J), !,
    findall(A, jefe_previo(A, J), Lista),
    format('ValheimBot: Antes de ~w van: ~w.~n', [J, Lista]).
 
% "que suelta el anciano"
responder(L) :-
    ( contiene(L, suelta) ; contiene(L, botin) ),
    jefe_de(J, _), contiene(L, J), !,
    findall(O, botin(J, O), Lista),
    format('ValheimBot: ~w deja: ~w.~n', [J, Lista]).
 
% "cual es el jefe del pantano"
responder(L) :-
    contiene(L, jefe),
    bioma(B), contiene(L, B), !,
    jefe_de(J, B),
    format('ValheimBot: El jefe de ~w es ~w.~n', [B, J]).
 
% "que enemigos hay en las llanuras"
responder(L) :-
    contiene(L, enemigo),
    bioma(B), contiene(L, B), !,
    findall(E, enemigo_en(E, B), Lista),
    format('ValheimBot: En ~w hay: ~w.~n', [B, Lista]).
 
% "que necesito para fabricar hacha de bronce"
responder(L) :-
    ( contiene(L, fabric) ; contiene(L, necesit) ; contiene(L, receta) ),
    receta(Item, Estacion, Ingredientes), contiene(L, Item), !,
    bases(Item, Bases),
    format('ValheimBot: ~w se hace en ~w con ~w.~n', [Item, Estacion, Ingredientes]),
    format('ValheimBot: Materiales basicos: ~w.~n', [Bases]).
 
% "donde consigo cobre"
responder(L) :-
    ( contiene(L, donde) ; contiene(L, consig) ),
    material(M), contiene(L, M), !,
    (   receta(M, _, _) -> bases(M, Bases) ; Bases = [M] ),
    forall(member(B, Bases), decir_origen(B)).
 
responder(L) :-
    contiene(L, ayuda), !,
    writeln('Ejemplos'),
    writeln('  cual es el jefe del pantano'),
    writeln('  como invoco a eikthyr'),
    writeln('  que jefes van antes de moder'),
    writeln('  que suelta el anciano'),
    writeln('  que enemigos hay en llanuras'),
    writeln('  que necesito para fabricar hacha de bronce'),
    writeln('  donde consigo cobre').
 
% Si ninguna regla anterior funciono:
responder(_) :-
    writeln('ValheimBot: No te entendi. Escribe "ayuda" para ver ejemplos.').
 
% material(M): cosas por las que se puede preguntar "donde consigo..."
material(M) :- receta(M, _, _).
material(M) :- recurso_en(M, _).
material(M) :- botin(_, M).
 
decir_origen(M) :-
    (   recurso_en(M, Bioma)
    ->  format('ValheimBot: ~w se encuentra en ~w.~n', [M, Bioma])
    ;   botin(Jefe, M)
    ->  format('ValheimBot: ~w lo suelta ~w.~n', [M, Jefe])
    ;   format('ValheimBot: No se donde conseguir ~w.~n', [M])
    ).