import personaje.*
import enemigo.*
import atributos.*
import wollok.game.*
import turnos.*
/*
class Ataque {
	var property atributo

	method realizar(atacante, atacado) {
		var potencia

		if (atributo == fisico) {
			potencia = atacante.fuerza() - atacado.vigor()
		}
		else {
			potencia = atacante.intelecto() * 3 - atacado.mente()
		}

		atacante.animarAtaque()
		atacado.reducirHP(potencia)
	}
}

const ataqueFisico = new Ataque(atributo = fisico)
const hechizoFulgor = new Ataque(atributo = magico)
*/

/*
object cura {
	method realizar(curador,curado){
		const potencia = curador.mente() * 0.3 // + curado.hp()
		curado.aumentarHp(potencia)
	}
}
*/




//Con este archivo, podemos modelar muchos ataques y además reutilizarlos.
//Por ejemplo, ambos usan "ataqueFisico" porque es el ataque básico.

 class Habilidad {
	const property tipoHabilidad
	const property position 
	const property text
	method  textColor() = "ffffff" 
	
	method pulsar(origen,destino){
		
		turno1.rutina().add(tipoHabilidad)
	
	}
}



object fisico{
	
	method realizar(atacante,victima){
		var potencia = atacante.fuerza() - victima.vigor()
		victima.reducirHP(potencia)
		atacante.animarHabilidad()
	}
}

/*class Magia{
	
}*/

class Magia{
	const elemento
	
	method realizar(atacante,victima){
		var potencia = atacante.intelecto() * 3 - victima.mente()
		victima.reducirHP(potencia)
		elemento.animar(atacante.position(),victima.position())
		atacante.animarHabilidad()
	}
}
class Elemento{
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
	method realizar(curador,curado){
		var potencia = curador.mente() * 0.3
		salud.animar(curador,curado)
		curado.aumentarHP(potencia)
	}
}

const curacion = new Habilidad (tipoHabilidad = cura, position = game.at(3, 3),text = "Curacion")
const ataqueFisico = new Habilidad (tipoHabilidad = fisico, position = game.at(3, 2),text = "Ataque Fisico")
const ataqueMagico = new Habilidad (tipoHabilidad = new Magia(elemento = piro),position = game.at(3, 1),text = "Ataque Magico")