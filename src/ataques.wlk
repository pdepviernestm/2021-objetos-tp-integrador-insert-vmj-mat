import personaje.*
import enemigo.*
import wollok.game.*
import turnos.*
import batalla.*
import tocadiscos.*

class NombreHabilidad {
	const property tipoHabilidad
	var property position = game.at(0, 0)
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

	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
 	
	method realizar(atacante, atacado) {
		if(!atacante.estaMuerto()){
			atacante.hacerHabilidad(self, atacado)
			naturaleza.animacion(atacante)
		}
	}

	method hacerEfecto(personaje, potencia) { rol.hacerEfecto(personaje, potencia) }

	method objetivosPosibles(batalla) { rol.objetivosPosibles(batalla) }
}

const cura = new Habilidad(naturaleza = regenerativo, rol = defensa, potenciaInicial = 20)
const lazaro = new Habilidad(naturaleza = regenerativo, rol = defensa, potenciaInicial = 0)
const basico = new Habilidad(naturaleza = fisico, rol = ofensa, potenciaInicial = 20)
class Magia inherits Habilidad(naturaleza = magico, rol = ofensa, potenciaInicial = 20) {
	const elemento
	// para cuando estén las animaciones de los elementos:
	// override method realizar(atacante, atacado) {
	// 	super(atacante, atacado)
	// 	elemento.animar(atacante, atacado)
	// }
}

class Elemento {
	const property image
	var property position = game.at(0,0)
	
	/*method animar(origen,destino){
		self.position(origen)
		game.addVisual(self)
		game.schedule(1000, { => self.position(destino) game.removeVisual(self) })
		
	}*/
}

object defensa {
	method objetivosPosibles(batalla) {
		batalla.menuActivo(batalla.menuAliados())
	}

	method hacerEfecto(personaje, potencia) {
		personaje.aumentarHP(potencia)
	}
}

object ofensa {
	method objetivosPosibles(batalla) {
		batalla.menuActivo(batalla.menuEnemigos())
	}

	method hacerEfecto(personaje, potencia) {
		personaje.reducirHP(potencia)
	}
}

object fisico {
	method estadisticaDePotencia(atacante) = atacante.fuerza()
	method estadisticaDeDefensa(atacado) = atacado.vigor()
	method animacion(atacante) { atacante.animarAtaqueFisico() }
}
 
object magico {
	method estadisticaDePotencia(atacante) = atacante.intelecto()
	method estadisticaDeDefensa(atacado) = atacado.mente()
	method animacion(atacante) { atacante.animarAtaqueMagico() }
}
 
object regenerativo {
	method estadisticaDePotencia(atacante) = atacante.mente()
	method estadisticaDeDefensa(atacado) = 0
	method animacion(atacante) { atacante.animarAtaqueMagico() }
}

const fuego = new Elemento(image = "/ataques/Fireball.gif")
const hielo = new Elemento(image = "/ataques/IceBall.gif")
const aire = new Elemento(image = "/ataques/AeroExplode.gif")
const electro = new Elemento(image = "/ataques/ElectroExplode.gif")
const salud = new Elemento(image = "/ataques/curaThrow.gif")

const curacion = new NombreHabilidad(tipoHabilidad = cura, text = "Curacion")
const ataqueFisico = new NombreHabilidad(tipoHabilidad = basico, text = "Golpe Fisico")
const ataqueEspada = new NombreHabilidad(tipoHabilidad = basico, text = "Corte Sangriento")
const ataqueMagico = new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), text = "Ataque Magico")
const ataquePiro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), text = "Piro")
const ataqueHielo = new NombreHabilidad(tipoHabilidad = new Magia(elemento = hielo), text = "Golpe Helado")
const ataqueElectro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = electro), text = "Rayo Electrico")
const ataqueAero = new NombreHabilidad(tipoHabilidad = new Magia(elemento = aire), text = "Rafaga Aerea")
object hechizoLazaro inherits NombreHabilidad(tipoHabilidad = lazaro, text = "Lázaro") {
	override method pulsar() {
		super()
		turno.heroesMuertos().forEach{ personaje => personaje.habilitar() }
	}
}