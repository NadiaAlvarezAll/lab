%  ValheimBot - Proyecto N°2, Fundamentos de Inteligencia Artificial
%  Puntos 2 y 3: conocimiento en lógica de primer orden + chatbot en Prolo

:- set_prolog_flag(encoding, utf8).

% --- Biomas y orden de progresión ---
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