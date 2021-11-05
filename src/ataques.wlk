import personaje.*
import enemigo.*
import wollok.game.*
import turnos.*

class NombreHabilidad {
	const property tipoHabilidad
	var property position 
	const property text
	method textColor() = "ffffff" 
	
	method pulsar() {
		turno.proximaAccion(self.tipoHabilidad())
	}
	
	method esDefensiva() = tipoHabilidad.rol() == defensa
	method esOfensiva() = tipoHabilidad.rol() == ofensa
}

class Habilidad {
	const property rol
	const property naturaleza
	const property potenciaInicial

    const property animacion = { personaje => }

	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa

	method animar(personaje) = animacion.apply(personaje)
	
	
	method realizar(atacante, atacado) {
		if(!atacante.estaMuerto()){
			atacante.hacerHabilidad(self, atacado)
			self.animar(atacante)
		}
		
	}
	
	//method atributoPorNaturaleza(personaje) = naturaleza.atributoPorNaturaleza(personaje)
	
	
	
	method esFisico() = naturaleza == fisico
	method esMagico() = naturaleza == magico
	method esCurativo() = naturaleza == regenerativo
	
}

const cura = new Habilidad(naturaleza = regenerativo, rol = defensa, potenciaInicial = 20)
const basico = new Habilidad(naturaleza = fisico, rol = ofensa, potenciaInicial = 20, animacion = animacionFisico)
class Magia inherits Habilidad(naturaleza = magico, rol = ofensa,potenciaInicial = 20) {
	const elemento
}



object defensa{}
object ofensa{}
object fisico {}
/* 	method atributoPorNaturaleza(personaje) = personaje.vigor()
}

*/object magico {}
//	method atributoPorNaturaleza(personaje) = personaje.intelecto()
//}

object regenerativo {}
//	method atributoPorNaturaleza(personaje) = personaje.mente()
//}
//*/

class Elemento {
	const property image
	var property position = game.at(0,0)
	
	/*method animar(origen,destino){
		self.position(origen)
		game.addVisual(self)
		game.schedule(1000, { => self.position(destino) })
		game.removeVisual(self)
	}*/
}

const fuego = new Elemento(image = "/ataques/Fireball.gif")
const hielo = new Elemento(image = "/ataques/IceBall.gif")
const aire = new Elemento(image = "/ataques/AeroExplode.gif")
const electro = new Elemento(image = "/ataques/ElectroExplode.gif")
const salud = new Elemento(image = "/ataques/curaThrow.gif")

const curacion = new NombreHabilidad(tipoHabilidad = cura, position = game.at(3, 3), text = "Curacion")
const ataqueFisico = new NombreHabilidad(tipoHabilidad = basico, position = game.at(3, 2), text = "Golpe Fisico")
const ataqueEspada = new NombreHabilidad(tipoHabilidad = basico, position = game.at(3, 2), text = "Corte Sangriento")
const ataqueMagico = new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), position = game.at(3, 1), text = "Ataque Magico")
const ataquePiro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), position = game.at(3, 1), text = "Piro")
const ataqueHielo = new NombreHabilidad(tipoHabilidad = new Magia(elemento = hielo), position = game.at(3, 1), text = "Golpe Helado")
const ataqueElectro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = electro), position = game.at(3, 1), text = "Rayo Electrico")
const ataqueAero = new NombreHabilidad(tipoHabilidad = new Magia(elemento = aire), position = game.at(3, 1), text = "Rafaga Aerea")
//const lazaro = new NombreHabilidad(tipoHabilidad = reanimacion, position = game.at(3, 1), text = "Lazaro")

object animacionFisico{
	method apply (personaje){
		personaje.animarAtaque()
		//meter aca el sonido que se pueda escuchar mas de una vez
		//const punch = game.sound("assets/music/mixkit-hard-and-quick-punch-2143.wav")
		//punch.play()
	}
	
}	