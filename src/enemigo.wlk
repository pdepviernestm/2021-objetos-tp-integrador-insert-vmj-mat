import wollok.game.*
import menu.*
import personaje.*
import turnos.*
import ataques.*

class Enemigo {
	const property imagenInicial
	const property imagenVida1
	const property imagenVida2
	const property imagenVida3
	
	var property position
	var hp
	var property carga
	const property fuerza 		// ataque fisico
	const property vigor  		// defensa fisica
	const property intelecto   	// ataque magico
	const property mente  		// defensa magica

	method image() = imagenInicial

	method animarAtaque() {
		position = game.at(position.x()+1, position.y())
		game.schedule(1000, { => position = game.at(position.x()-1, position.y()) })
	}
	method estaMuerto() {
		return hp <= 0
	}
	method hp() = hp
	method hp(nuevosHP){ //  PARA TEST
		hp = nuevosHP
	}
	method elegirAtaque() {
		var ataqueElegido
		if (carga < 3) {
			ataqueElegido = ataqueFisico
			carga++
		}
		else {
			ataqueElegido = hechizoFulgor
			carga = 0
		}
		return ataqueElegido
	}
}

const enemigo1 = new Enemigo(
	 imagenInicial = "enemigos/Cactrot.gif",
	 imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	 position = game.at(2, 5),

	 hp = 100,
	 carga = 0,
	 fuerza = 50, // ataque fisico
	 vigor = 15, // defensa fisica
	 intelecto = 20, // ataque magico
	 mente = 15 // defensa magica
)

const enemigo2 = new Enemigo(
	 imagenInicial = "enemigos/Cactrot.gif",
	 imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	 position = game.at(3, 4),

	 hp = 150,
	 carga = 0,
	 fuerza = 70, // ataque fisico
	 vigor = 30, // defensa fisica
	 intelecto = 30, // ataque magico
	 mente = 10 // defensa magica
)

const enemigo3 = new Enemigo (
	
	 imagenInicial = "enemigos/Cactrot.gif",
	 imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	 position = game.at(2, 4),

	 hp = 200,
	 carga = 0,
	 fuerza = 50, // ataque fisico
	 vigor = 70, // defensa fisica
	 intelecto = 30, // ataque magico
	 mente = 40 // defensa magica
)

const enemigo4 = new Enemigo(
	
	 imagenInicial = "enemigos/Cactrot.gif",
	 imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	 imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	 position = game.at(3, 5),

	 hp = 170,
	 carga = 0,
	 fuerza = 40, // ataque fisico
	 vigor = 80, // defensa fisica
	 intelecto = 60, // ataque magico
	 mente = 35 // defensa magica
)