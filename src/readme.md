Ataque fisico personaje = daño fisico + daño arma
Ataque magico = daño magico + daño arma 

Personaje.ataqueMagico(elemento) -> enemigo.recibirAtaqueMagico(elemento,N)
Personaje.ataqueFisico() -> enemigo.recibirAtaqueFisico(N)
Personaje.tirarEncantamiento() -> enemigo.recibirEncantamiento(encantamiento)

Personaje.recibirAtaqueFisico(N) = hp personaje  - (N - DefFisica) * random (0.85-1)
Personaje.recibirAtaqueMagico(N) = hp personaje  - (N - DefMagica) * random (0.85-1)
Personaje.recibirEncantamiento(encantamiento) = encantamiento.efecto(personaje)

Enemigo.recibirAtaqueFisico(N) = hp enemigo -  (N - DefFisica)
Enemigo.recibirAtaqueMagico(elemento,N) = hp enemigo - vulnerabilidadElemental(elemento) * N
Enemigo.recibirEncantamiento(encantamiento) = encantamiento.efecto(enemigo)


Se elige un rol antes de la batalla se comienza con:

Fulminador 
Castigador


**Pociones**

Panacea
Ultrapocion
Pocion
Cola de fenix

**Clases** 

Personaje
Enemigo
Artefacto (equipables)
Arma (equipables)
ObjetoConsumible (Consumibles)
Encantamiento (tiene un efecto)


Si un personaje esta ko, ponerlo en gris
Seleccionar con color la opcion en el menu

Ataques fisicos
Ataque normal

**Ataques magicos**
Piro
Hielo
Electro
Aero

**Encantamientos**
antiCoraza
Antimagia
Bio



**Objetivos para 01/10**



✅ Primer objetivo: tener una pelea entre 2 personajes en el que se pueda elegir que ataque usar. El oponente podría hacer siempre lo mismo (lo más simple posible).

✅ Segundo objetivo: el oponente puede tener varios ataques y puede elegir entre ellos.
Por ahora, podemos limitar a una cantidad hardcodeada de ataques/opciones en el menú.

✅ Tercer objetivo: que el daño de los ataques sea calculado a partir de los ataques en sí y de las características de los personajes.

✅ Cuarto objetivo: Tener diferentes personajes que puedan pelear y que se pueda elegir cuales usar.

✅ Quinto objetivo: tener al menos 2 tipos de ataques (podría ser por ej. físicos y mágicos) que calculen su daño de manera distinta.

Bonus: si el enemigo tiene alguna forma aleatoria de calcular sus ataques, como testeamos eso.

