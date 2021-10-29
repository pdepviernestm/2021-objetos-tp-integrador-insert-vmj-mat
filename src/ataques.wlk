import personaje.*
import enemigo.*
import wollok.game.*
import turnos.*

class Habilidad {
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

object defensa{}
object ofensa{}

object reanimacion{
	const property rol = defensa
	method realizar(curador,curado){
		curado.reset()
	}
	
	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
	
}
object cura{
	const property rol = defensa
	method realizar(curador, curado){
		const potencia = curador.mente() * 0.3
		//salud.animar(curador, curado)
		curado.aumentarHP(potencia)
	}
	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
}

object fisico {	
	const property rol = ofensa
	method realizar(atacante, victima){
		const potencia = (atacante.fuerza() - victima.vigor()).max(0)
		victima.reducirHP(potencia)
		//atacante.animarHabilidad()
	}
	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
}

class Magia {
	const property rol = ofensa
	const elemento
	
	method realizar(atacante,victima){
		const potencia = (atacante.intelecto() * 3 - victima.mente()).max(0)
		victima.reducirHP(potencia)
		//elemento.animar(atacante.position(),victima.position())
		//atacante.animarHabilidad()
	}
	method esDefensiva() = rol == defensa
	method esOfensiva() = rol == ofensa
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

const fuego = new Elemento(image = "/ataques/Fireball.gif")
const hielo = new Elemento(image = "/ataques/IceBall.gif")
const aire = new Elemento(image = "/ataques/AeroExplode.gif")
const electro = new Elemento(image = "/ataques/ElectroExplode.gif")
const salud = new Elemento(image = "/ataques/curaThrow.gif")


const curacion = new Habilidad(tipoHabilidad = cura, position = game.at(3, 3), text = "Curacion")
const ataqueFisico = new Habilidad(tipoHabilidad = fisico, position = game.at(3, 2), text = "Golpe Fisico")
const ataqueEspada = new Habilidad(tipoHabilidad = fisico, position = game.at(3, 2), text = "Corte Sangriento")
const ataqueMagico = new Habilidad(tipoHabilidad = new Magia(elemento = fuego), position = game.at(3, 1), text = "Ataque Magico")
const ataquePiro= new Habilidad(tipoHabilidad = new Magia(elemento = fuego), position = game.at(3, 1), text = "Piro")
const ataqueHielo= new Habilidad(tipoHabilidad = new Magia(elemento = hielo), position = game.at(3, 1), text = "Golpe Helado")
const ataqueElectro = new Habilidad(tipoHabilidad = new Magia(elemento = electro), position = game.at(3, 1), text = "Rayo Electrico")
const ataqueAero = new Habilidad(tipoHabilidad = new Magia(elemento = aire), position = game.at(3, 1), text = "Rafaga Aerea")
const lazaro = new Habilidad(tipoHabilidad = reanimacion, position = game.at(3, 1), text = "Lazaro")





