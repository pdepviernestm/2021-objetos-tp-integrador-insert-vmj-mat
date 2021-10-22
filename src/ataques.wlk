import personaje.*
import enemigo.*
import wollok.game.*
import turnos.*

class Habilidad {
	const property tipoHabilidad
	const property position 
	const property text
	method textColor() = "ffffff" 
	
	method pulsar() {
		turno.proximaAccion(self.tipoHabilidad())
	}
}



object fisico {	
	method realizar(atacante, victima){
		var potencia = (atacante.atributos().fuerza() - victima.atributos().vigor()).max(0)
		victima.atributos().reducirHP(potencia)
		//atacante.animarHabilidad()
	}
}

class Magia {
	const elemento
	
	method realizar(atacante,victima){
		var potencia = (atacante.atributos().intelecto() * 3 - victima.atributos().mente()).max(0)
		victima.atributos().reducirHP(potencia)
		//elemento.animar(atacante.position(),victima.position())
		//atacante.animarHabilidad()
	}
}
class Elemento {
	const property image
	var property position = game.at(0,0)
	
	method animar(origen,destino){
		self.position(origen)
		game.addVisual(self)
		game.schedule(1000, { => self.position(destino) })
		game.removeVisual(self)
	}
}

const piro = new Elemento(image = "/ataques/Fireball.gif")
const hielo = new Elemento(image = "/ataques/IceBall.gif")
const aero = new Elemento(image = "/ataques/AeroExplode.gif")
const electro = new Elemento(image = "/ataques/ElectroExplode.gif")
const salud = new Elemento(image = "/ataques/curaThrow.gif")

object cura{
	method realizar(curador, curado){
		var potencia = curador.atributos().mente() * 0.3
		//salud.animar(curador, curado)
		curado.atributos().aumentarHP(potencia)
	}
}

const curacion = new Habilidad(tipoHabilidad = cura, position = game.at(3, 3), text = "Curacion")
const ataqueFisico = new Habilidad(tipoHabilidad = fisico, position = game.at(3, 2), text = "Ataque Fisico")
const ataqueMagico = new Habilidad(tipoHabilidad = new Magia(elemento = piro), position = game.at(3, 1), text = "Ataque Magico")