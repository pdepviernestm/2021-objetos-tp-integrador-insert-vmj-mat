import wollok.game.*
import personaje.*
import turnos.*
import ataques.*
import tocadiscos.*
import posiciones.*

class AtributosEnemigo {
	const property imagenInicial
	var posicionOriginal = game.origin()
	var property position = posicionOriginal
	const property maxHP
	var property hp = maxHP
	var property carga = 0
	const property formaDeElegirObjetivo
	const property formaDeElegirAtaque
	const property habilidades

	method image() = imagenInicial
	
	method posicionOriginal(posicion){
		posicionOriginal = posicion
		position = posicion
	}
	
	method posicionOriginal() = posicionOriginal
	method posicionAtaque() = derecha.mover(position,1)
	
	method estaMuerto() = hp <= 0
	
	method reducirHP(n) {
		hp = (hp - n).max(0)
		if (self.estaMuerto() && game.hasVisual(self)) game.removeVisual(self)
	} 
	
	method aumentarHP(restauracion) {
		hp = (hp + restauracion).min(maxHP)
	}
	
	method elegirAtaque() = formaDeElegirAtaque.apply(habilidades).tipoHabilidad()
			
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

 /* Formas de elegir objetivo */

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

/* Formas de elegir ataque */

class Ciclar {
	var indice = 0
	method apply(ataques) {
		if (indice + 1 == ataques.size()) indice = 0
		else indice++
		return ataques.get(indice)
	} 
}

class Cargar { 
// este método debe usarse con listas de 2 ataques, 
// el débil primero, el fuerte último
	var property carga = 0
	method apply(ataques) {
		if (ataques.size() != 2) 
			self.error("Este método sólo se usa para listas de 2 ataques")
		if (carga < 2) {
			carga++
			return ataques.head()
		}
		else {
			carga = 0
			return ataques.last()
		}
	} 
}

/* Enemigos */

const jefeFinal = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/32-Mage-Master.gif",
		formaDeElegirObjetivo = elegirObjetivoAlAzar,
		formaDeElegirAtaque = new Ciclar(),
		maxHP = 1000,
		habilidades = [ataquePiro, ataqueHielo, ataqueElectro, ataqueAero]
		),
		fuerza = 100, 
		vigor = 15, 
		intelecto = 100, 
		mente = 15,
		text = "Mago Supremo")
	
const shiva = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/12-Shiva.gif",
		formaDeElegirObjetivo = elegirObjetivoConMenosMente,
		formaDeElegirAtaque = new Ciclar(),
		habilidades =  [ataqueHielo, ataqueAero],
		maxHP = 500
		),
		fuerza = 50, 
		vigor = 15, 
		intelecto = 100, 
		mente = 15,
		text = "Shiva")

const dragoncito = new Personaje(atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Pterodon.gif",
		formaDeElegirObjetivo = elegirObjetivoConMenosVigor,
		formaDeElegirAtaque = new Cargar(),
		habilidades = [ataquePiro,ataqueFisico],
		maxHP = 500
		),
		fuerza = 100, 
		vigor = 15, 
		intelecto = 20, 
		mente = 15,
		text = "Pterodon")

const cactrot = new Personaje(
		atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Cactrot.gif",
		formaDeElegirObjetivo = elegirObjetivoAlAzar,
		formaDeElegirAtaque = new Ciclar(),
		habilidades = [ataqueFisico],
		maxHP = 100
		),
		fuerza = 50, 
		vigor = 15, 
		intelecto = 20, 
		mente = 15,
		text = "Cactrot"
)

const flan = new Personaje(
	atributos = new AtributosEnemigo(
		imagenInicial = "enemigos/Flan.gif",
		formaDeElegirObjetivo = elegirObjetivoAlAzar,
		formaDeElegirAtaque = new Ciclar(),
		habilidades = [ataqueFisico],
		maxHP = 150
		),
		fuerza = 70, 
		vigor = 30, 
		intelecto = 30, 
		mente = 10, 
		text = "Flan"
)

const tomberi = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Tonberry.gif",
		formaDeElegirObjetivo = elegirObjetivoConMenosHP,
		formaDeElegirAtaque = new Cargar(),
		habilidades = [ataqueEspada, ataqueMagico],
		maxHP = 200
	), 
		fuerza = 50, 
		vigor = 40, 
		intelecto = 30, 
		mente = 40,
		text = "Tomberi"
)

const duende = new Personaje (
	atributos = new AtributosEnemigo (
		imagenInicial = "enemigos/Goblin2.gif",
		formaDeElegirObjetivo = elegirObjetivoAlAzar,
		formaDeElegirAtaque = new Ciclar(),
		habilidades = [ataqueFisico],
		maxHP = 170
	),
		
		fuerza = 50, 
		vigor = 50, 
		intelecto = 60, 
		mente = 35 ,
		text = "Duende"
)




