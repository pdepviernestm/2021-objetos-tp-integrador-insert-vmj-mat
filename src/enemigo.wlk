import wollok.game.*
import menu.*
import personaje.*
import turnos.*
import ataques.*
import tocadiscos.*

class AtributosEnemigo {
	const property imagenInicial
	var posicionOriginal
	var property position = posicionOriginal
	var property hp = maxHP
	const property maxHP
	var property carga = 0
	const property fuerza 		// ataque fisico
	const property vigor  		// defensa fisica
	const property intelecto   	// ataque magico
	const property mente  		// defensa magica

	method image() = imagenInicial
	
	/*method animarAtaque() {
		position = game.at(position.x()+1, position.y())
		game.schedule(1000, { => position = game.at(position.x()-1, position.y()) })
	}*/

	method posicionOriginal(posicion){
		posicionOriginal = posicion
		position = posicion
	}
	//method agregarseAlMenu(){game.addVisual(self)}
	method posicionOriginal() = posicionOriginal

	method posicionAtaque() = game.at(position.x() + 1, position.y())
	
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
	
	method recibirHabilidad(ataque, potenciaTotal){
		self.reducirHP(potenciaTotal)
	}
	
	method animarAtaqueFisico() {
		tocadiscos.tocar(sonidoPunio)
		position = self.posicionAtaque()
		game.schedule(1000, { => position = self.posicionOriginal() })
	}

	method animarAtaqueMagico() {
		tocadiscos.tocar(sonidoMagia)
	}
}

const cactrot = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Cactrot.gif",
		posicionOriginal = game.at(2, 8),
	
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
		posicionOriginal = game.at(3, 7),
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
		posicionOriginal = game.at(5, 8),
	
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
		posicionOriginal = game.at(7, 9),
	
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

const duendeInmortal = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		posicionOriginal = game.at(9, 7),
	
		maxHP = 170,
		carga = 0,
		fuerza = 40, // ataque fisico
		vigor = 200, // defensa fisica
		intelecto = 60, // ataque magico
		mente = 200 // defensa magica
	),
	text = "Duende inmortal",
	position = game.at(2, 5)
)