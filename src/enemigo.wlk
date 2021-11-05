import wollok.game.*
import menu.*
import personaje.*
import turnos.*
import ataques.*

class AtributosEnemigo {
	const property imagenInicial

	var property position
	var property hp = maxHP
	const property maxHP
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
	
	method reducirHP(n) {
		hp = (hp - n).max(0)
		if (self.estaMuerto()) game.removeVisual(self)
	} 
	
	method aumentarHP(restauracion) {
		hp = (hp + restauracion).min(maxHP)
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
		return objetivos.min({ objetivo => objetivo.atributos().hp() })
	}

	method recibirHabilidad(ataque, potencia){
		
		var def = 0
		if (ataque.esFisico()){
			def = vigor
			self.reducirHP((potencia - def).max(ataque.potenciaInicial()))
		} 
		else if (ataque.esMagico()) {
			def = mente
			self.reducirHP((potencia - def).max(ataque.potenciaInicial()))
		}
		else if (ataque.esCurativo()) {
			self.aumentarHP(potencia)
		}
		// else if (ataque.naturaleza() == lazaro) ...
	}
}

const cactrot = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Cactrot.gif",
		position = game.at(2, 8),
	
		maxHP = 100,
		carga = 0,
		fuerza = 50, // ataque fisico
		vigor = 15, // defensa fisica
		intelecto = 20, // ataque magico
		mente = 15 // defensa magica
		),
	text = "Cactrot",
	position = game.at(2, 1)
)

const flan = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Flan.gif",
		position = game.at(3, 7),
		maxHP = 150,
		carga = 0,
	 	fuerza = 70, // ataque fisico
		vigor = 30, // defensa fisica
		intelecto = 30, // ataque magico
		mente = 10 // defensa magica
		),
	text = "Flan",
	position = game.at(2, 2)
)

const tomberi = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Tonberry.gif",
		position = game.at(5, 8),
	
		maxHP = 200,
		carga = 0,
		fuerza = 50, // ataque fisico
		vigor = 40, // defensa fisica
		intelecto = 30, // ataque magico
		mente = 40 // defensa magica
	), 
	text = "Tomberi",
	position = game.at(2, 3)
)

const duende = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		position = game.at(7, 9),
	
		maxHP = 170,
		carga = 0,
		fuerza = 40, // ataque fisico
		vigor = 50, // defensa fisica
		intelecto = 60, // ataque magico
		mente = 35 // defensa magica
	),
	text = "Duende",
	position = game.at(2, 4)
)