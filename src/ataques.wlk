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
	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
	method realizar(atacante, atacado) {
		if (!atacante.estaMuerto()) {
			atacante.hacerHabilidad(self, atacado)
		}
	}
}

const cura = new Habilidad(naturaleza = regenerativo, rol = defensa)
const basico = new Habilidad(naturaleza = fisico, rol = ofensa)
class Magia inherits Habilidad(naturaleza = magico, rol = ofensa) {
	const elemento
}

object defensa{}
object ofensa{}
object fisico{}
object magico{}
object regenerativo{}

/*object reanimacion inherits Ataque (rol = defensa){
	method realizar(curador, curado){
		if(self.esPosibleAtacar(curador)) {			
			curado.reset()
		}
	}
}*/
// object cura inherits Ataque(rol = defensa) {
// 	method realizar(curador, curado){
// 		if(self.esPosibleAtacar(curador)){
// 			const potencia = curador.mente() * 0.3
// 			//salud.animar(curador, curado)
// 			curado.aumentarHP(potencia)
// 		}
// 	}
// }


// object fisico inherits Ataque(rol = ofensa, naturaleza = fisico) {	
// 	method realizar(atacante, victima){
// 		if(self.esPosibleAtacar(atacante)){
// 			//const punch = game.sound("assets/music/mixkit-hard-and-quick-punch-2143.wav")
// 			//punch.play()
// 			const potencia = (atacante.fuerza() - victima.vigor()).max(0)
// 			//const potencia = atacante.obtenerFuerzaPara(self)
// 			//...
// 			//atacante method obtenerFuerzaPara(ataque)
// 			//if ataque == fisico return self.fuerza()
// 			//if ataque == magico return self.intelecto()
// 			//if ataque == electro return self.intelecto() * 2
// 			victima.reducirHP(potencia)
// 			//atacante.animarHabilidad()
// 		}
// 	}
// }

// class Magia inherits Ataque(rol = ofensa, naturaleza = magico) {
// 	const elemento
// 	method realizar(atacante,victima){
// 		if(self.esPosibleAtacar(atacante)){
// 			const potencia = (atacante.intelecto() * 3 - victima.mente()).max(0)
// 			victima.reducirHP(potencia)
// 			//elemento.animar(atacante.position(),victima.position())
// 			//atacante.animarHabilidad()
// 		}
// 	}
// }
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
const ataquePiro= new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), position = game.at(3, 1), text = "Piro")
const ataqueHielo= new NombreHabilidad(tipoHabilidad = new Magia(elemento = hielo), position = game.at(3, 1), text = "Golpe Helado")
const ataqueElectro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = electro), position = game.at(3, 1), text = "Rayo Electrico")
const ataqueAero = new NombreHabilidad(tipoHabilidad = new Magia(elemento = aire), position = game.at(3, 1), text = "Rafaga Aerea")
//const lazaro = new NombreHabilidad(tipoHabilidad = reanimacion, position = game.at(3, 1), text = "Lazaro")