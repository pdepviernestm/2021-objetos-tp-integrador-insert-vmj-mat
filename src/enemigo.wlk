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
	var property fuerza 		// ataque fisico
	const property vigor  		// defensa fisica
	var property intelecto   	// ataque magico
	const property mente  		// defensa magica
	const formaDeElegirObjetivo
	const ataques

	method image() = imagenInicial
	
	method posicionOriginal(posicion){
		posicionOriginal = posicion
		position = posicion
	}
	
	method posicionOriginal() = posicionOriginal

	method posicionAtaque() = game.at(position.x() + 1, position.y())
	
	method estaMuerto() = hp <= 0
	
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
			const fuerzaInicial = fuerza
			const intelectoInicial = intelecto
			fuerza = fuerza * 2
			intelecto = intelecto * 2
			
			ataqueElegido = ataqueMagico.tipoHabilidad()
			carga = 0
			
			fuerza = fuerzaInicial
			intelecto = intelectoInicial
		}
		return ataqueElegido
	}
		
	method elegirObjetivo(objetivos) = formaDeElegirObjetivo.apply(objetivos)
	
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

object elegirObjetivoAlAzar {
	method apply(objetivos) = objetivos.anyOne()
}

object elegirObjetivoConMenosHP {
	method apply(objetivos) = objetivos.min{ objetivo => objetivo.hp() }
}

object elegirObjetivoConMenosVigor {
	method apply(objetivos) = objetivos.min{ objetivo => objetivo.vigor() }
}

object elegirObjetivoConMenosMente {
	method apply(objetivos) = objetivos.min{ objetivo => objetivo.mente() }
}

//que cada enemigo tenga su propia lista de ataques, y sacar un ataque de la lista según diferentes criterios

object elegirElementoAlAzar {
	method apply() {
		var ataque = [ataquePiro.tipoHabilidad(), ataqueHielo.tipoHabilidad(), ataqueElectro.tipoHabilidad(), ataqueAero.tipoHabilidad()]
		return ataque.anyOne()
	}
}

const jefeFinal = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/32-Mage-Master.gif",
		posicionOriginal = game.at(2, 8),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataquePiro,ataqueHielo,ataqueElectro,ataqueAero],
		maxHP = 3000,
		fuerza = 100, 
		vigor = 15, 
		intelecto = 100, 
		mente = 15 
		),
	text = "Mago Supremo",
	position = game.at(2, 1))
	
const shiva = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/12-Shiva.gif",
		posicionOriginal = game.at(2, 8),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueHielo,ataqueAero],
		maxHP = 500,
		fuerza = 50, 
		vigor = 15, 
		intelecto = 100, 
		mente = 15 
		),
	text = "Shiva",
	position = game.at(2, 1))

const dragoncito = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Pterodon.gif",
		posicionOriginal = game.at(2, 8),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataquePiro,ataqueFisico],
		maxHP = 500,
		fuerza = 100, 
		vigor = 15, 
		intelecto = 20, 
		mente = 15 
		),
	text = "Pterodon",
	position = game.at(2, 5))

const cactrot = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Cactrot.gif",
		posicionOriginal = game.at(2, 8),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueFisico],
		maxHP = 100,
		fuerza = 50, 
		vigor = 15, 
		intelecto = 20, 
		mente = 15 
		),
	text = "Cactrot",
	position = game.at(2, 1)
)

const flan = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Flan.gif",
		posicionOriginal = game.at(3, 7),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueFisico],
		maxHP = 150,
	 	fuerza = 70, 
		vigor = 30, 
		intelecto = 30, 
		mente = 10 
		),
	text = "Flan",
	position = game.at(2, 2)
)

const tomberi = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Tonberry.gif",
		posicionOriginal = game.at(5, 8),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueEspada,ataqueMagico],
		maxHP = 200,
		fuerza = 50, 
		vigor = 40, 
		intelecto = 100, 
		mente = 40
	), 
	text = "Tomberi",
	position = game.at(2, 3)
)

const duende = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		posicionOriginal = game.at(7, 9),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueFisico],
		maxHP = 200,
		fuerza = 40, 
		vigor = 50, 
		intelecto = 60, 
		mente = 35 
	),
	text = "Duende",
	position = game.at(2, 4)
)

const duendeInmortal = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		posicionOriginal = game.at(9, 7),
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		ataques = [ataqueFisico],
		maxHP = 170,
		fuerza = 40, 
		vigor = 200, 
		intelecto = 60, 
		mente = 200 
	),
	text = "Duende inmortal",
	position = game.at(2, 5)
)