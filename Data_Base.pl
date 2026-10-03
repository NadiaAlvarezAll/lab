% ValheimBot - Proyecto N°2, Fundamentos de Inteligencia Artificial
% Puntos 2 y 3: conocimiento en lógica de primer orden + chatbot en Prolog


:- set_prolog_flag(encoding, utf8).

% --- Biomas y orden de progresión
bioma(praderas).
bioma(bosque_negro).
bioma(pantano).
bioma(montana).
bioma(llanuras).
bioma(tierras_de_niebla).

orden_bioma(praderas, 1).
orden_bioma(bosque_negro, 2).
orden_bioma(pantano, 3).
orden_bioma(montana, 4).
orden_bioma(llanuras, 5).
orden_bioma(tierras_de_niebla, 6).

% jefe(jefes y donde estan)
jefe(eikthyr).
jefe(el_anciano).
jefe(bonemass).
jefe(moder).
jefe(yagluth).
jefe(la_reina).
jefe(jefe_6, tierras_de_niebla).

% dropea(nombre del boss, que te tira)
dropea(jefe_1, drop_clave_1).
dropea(jefe_2, drop_clave_2).
dropea(jefe_3, drop_clave_3).
dropea(jefe_4, drop_clave_4).
dropea(jefe_5, drop_clave_5).
dropea(jefe_6, drop_clave_6).


% 2. Recursos por cada zona

% recurso(NombreRecurso, Bioma de donde lo saco)
/*cada zona tiene un recurso porque es como progresion de mejorar items para pasar a otra
  zona falta colocar los items por zona*/
recurso(recurso_basico_1, praderas).
recurso(recurso_basico_2, praderas).

recurso(mineral_nivel_1, bosque_negro).
recurso(bosquenegro_obj, bosque_negro).

recurso(mineral_nivel_2, pantano).
recurso(objeto_pantano, pantano).

recurso(mineral_nivel_3, montana).
recurso(montaña_objeto, montana).

recurso(mineral_nivel_4, llanuras).
recurso(llanura_objeto, llanuras).

recurso(material_mistico_1, tierras_de_niebla).
recurso(material_mistico_2, tierras_de_niebla).


% 3. mesas de crafteo
mesacrafteo(mesa_nivel_1).
mesacrafteo(mesa_nivel_2).

% requiere_estacion(HerramientaOItem, mesa de crafteo que nescesitas :v)
/*aqui faltan mesas distintas porque hay una forja una mesa como de magia y que craftean
distintos items entre si*/

requiere_estacion(herramienta_1, mesa_nivel_1).
requiere_estacion(herramienta_2, mesa_nivel_2).
requiere_estacion(herramienta_3, mesa_nivel_2).

% receta(Itemcrafteado, que nescesitas)
/* faltan las relaciones de crafteos pero ni idea 
falta tener un orden porque los jefes sueltan cosas */
receta(herramienta_1, [drop_clave_1, recurso_basico_1]).
receta(herramienta_2, [mineral_nivel_1, bosquenegro_obj]).
receta(herramienta_3, [mineral_nivel_2, bosquenegro_obj]).

% herramienta_requerida(mineral que sacas, Herramienta minima para sacar)
herramienta_requerida(mineral_nivel_1, herramienta_1).
herramienta_requerida(mineral_nivel_2, herramienta_2).
herramienta_requerida(mineral_nivel_3, herramienta_3).