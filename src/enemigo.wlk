import wollok.game.*
import menu.*
import personaje.*
import turnos.*
import ataques.*

class AtributosEnemigo {
	const property imagenInicial
	const property imagenVida1
	const property imagenVida2
	const property imagenVida3
	var property position
	var property hp
	var property carga = 0
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
	
	method reducirHP(n){
		hp = (hp - n).max(0)
		if (self.estaMuerto()) game.removeVisual(self)
	} 

	method elegirAtaque() {
		var ataqueElegido
		if (carga < 3) {
			ataqueElegido = ataqueFisico.tipoHabilidad()
			carga++
		}
		else {
			ataqueElegido = ataqueMagico.tipoHabilidad()
			carga = 0
		}
		return ataqueElegido
	}

		
	method elegirObjetivo(objetivos){
		var objetivo = objetivos.min({ objetivo => objetivo.atributos().hp() })
		return objetivo
	}
}

const cactrot = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Cactrot.gif",
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(2, 8),
	
		hp = 100,
		carga = 0,
		fuerza = 50, // ataque fisico
		vigor = 15, // defensa fisica
		intelecto = 20, // ataque magico
		mente = 15 // defensa magica
		),
	text = "cactrot",
	position = game.at(2, 1)
)

const flan = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Flan.gif",
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(3, 7),
		hp = 150,
		carga = 0,
	 	fuerza = 70, // ataque fisico
		vigor = 30, // defensa fisica
		intelecto = 30, // ataque magico
		mente = 10 // defensa magica
		),
	text = "flan",
	position = game.at(2, 2)
)

const tomberi = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Tonberry.gif",
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(5, 8),
	
		hp = 200,
		carga = 0,
		fuerza = 50, // ataque fisico
		vigor = 70, // defensa fisica
		intelecto = 30, // ataque magico
		mente = 40 // defensa magica
	), 
	text = "tomberi",
	position = game.at(2, 3)
)

const duende = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(7, 9),
	
		hp = 170,
		carga = 0,
		fuerza = 40, // ataque fisico
		vigor = 80, // defensa fisica
		intelecto = 60, // ataque magico
		mente = 35 // defensa magica
	),
	text = "duende",
	position = game.at(2, 4)
)