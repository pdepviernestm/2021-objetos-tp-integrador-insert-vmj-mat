import personaje.*
import enemigo.*
import wollok.game.*
import turnos.*
import batalla.*
import tocadiscos.*
import menu.*
import config.*

class NombreHabilidad {
	const property tipoHabilidad
	var property position = game.at(0, 0)
	const property text
	method textColor() = colorHabilitado
	
	method pulsar() {
		turno.proximaAccion(self.tipoHabilidad())
	}

}

class Habilidad {
	const property rol
	const property naturaleza
	const property potenciaInicial

	method realizar(atacante, atacado) {
		if(!atacante.estaMuerto()){
			atacante.hacerHabilidad(self, atacado)
			naturaleza.animacion(atacante)
		}
	}
	method hacerEfecto(personaje, potencia) { rol.hacerEfecto(personaje, potencia) }
	method objetivosPosibles(batalla) { rol.objetivosPosibles(batalla) }
}

class Elemento {
	const property image
	var property position = game.at(0,0)
	
	method animar(destino){
		position = destino.posicion()
		game.addVisual(self)
		game.schedule(1000, { => game.removeVisual(self) })
	}
	
}

/* Roles */
object defensa {
	method objetivosPosibles(batalla) {
		batalla.menuActivo(menuHeroes)
	}
	method hacerEfecto(personaje, potencia) {
		personaje.aumentarHP(potencia)
	}
}

object ofensa {
	method objetivosPosibles(batalla) {
		batalla.menuActivo(menuEnemigos)
	}
	method hacerEfecto(personaje, potencia) {
		personaje.reducirHP(potencia)
		personaje.animarRecepcion()
	}
}

/* Naturalezas */
class NaturalezaMagica {
	method estadisticaDePotencia(atacante) = atacante.intelecto()
	method estadisticaDeDefensa(atacado)
	method animacion(atacante, elemento, atacado) { atacante.animarAtaqueMagico(elemento, atacado) }
}
object magico inherits NaturalezaMagica {
	override method estadisticaDeDefensa(atacado) = atacado.mente()
}
 
object regenerativo inherits NaturalezaMagica {
	override method estadisticaDeDefensa(atacado) = 0
} 

object fisico {
	method estadisticaDePotencia(atacante) = atacante.fuerza()
	method estadisticaDeDefensa(atacado) = atacado.vigor()
	method animacion(atacante) { atacante.animarAtaqueFisico() }
}
object corte {
	method estadisticaDePotencia(atacante) = atacante.fuerza() + (-10 .. 10).anyOne()
	method estadisticaDeDefensa(atacado) = atacado.vigor()
	method animacion(atacante) { atacante.animarAtaqueEspada() }
}


/* Tipos de habilidad segun impacto */
const basico = new Habilidad(naturaleza = fisico, rol = ofensa, potenciaInicial = 20)
const espada = new Habilidad(naturaleza = corte, rol = ofensa, potenciaInicial = 30)
class Magia inherits Habilidad(naturaleza = magico, rol = ofensa, potenciaInicial = 20) {
	const elemento
	override method realizar(atacante, atacado) {
		if(!atacante.estaMuerto()) {
			atacante.hacerHabilidad(self, atacado)
			naturaleza.animacion(atacante, elemento, atacado)
		}
	}
}
const cura = new Magia(elemento = salud, naturaleza = regenerativo, rol = defensa, potenciaInicial = 20)
const lazaro = new Magia(elemento = fenix, naturaleza = regenerativo, rol = defensa, potenciaInicial = 0)
 
 /* Animaciones de los elementos */
const fuego = new Elemento(image = "ataques/Fireball.gif")
const hielo = new Elemento(image = "ataques/IceBall.gif")
const aire = new Elemento(image = "ataques/AeroExplode.gif")
const electro = new Elemento(image = "ataques/ElectroExplode.gif")
const salud = new Elemento(image = "ataques/Cura.gif")
const magiaBlanca = new Elemento(image = "ataques/cositoVerde.gif")
const fenix = new Elemento(image = "ataques/CuraThrow.gif" )

/* Habilidades */
const curacion = new NombreHabilidad(tipoHabilidad = cura, text = "Curaci??n")
const ataqueFisico = new NombreHabilidad(tipoHabilidad = basico, text = "Golpe F??sico")
const ataqueEspada = new NombreHabilidad(tipoHabilidad = espada, text = "Corte Sangriento")
const ataqueMagico = new NombreHabilidad(tipoHabilidad = new Magia(elemento = magiaBlanca), text = "Ataque M??gico")
const ataquePiro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = fuego), text = "Piro")
const ataqueHielo = new NombreHabilidad(tipoHabilidad = new Magia(elemento = hielo), text = "Golpe Helado")
const ataqueElectro = new NombreHabilidad(tipoHabilidad = new Magia(elemento = electro), text = "Rayo El??ctrico")
const ataqueAero = new NombreHabilidad(tipoHabilidad = new Magia(elemento = aire), text = "R??faga Aerea")
object hechizoLazaro inherits NombreHabilidad(tipoHabilidad = lazaro, text = "L??zaro") {
	override method pulsar() {
		super()
		turno.heroesMuertos().forEach{ personaje => personaje.habilitar() }
	}
}