import wollok.game.*
import menu.*
import personaje.*
import turnos.*
import ataques.*


object enemigo {

	
	const property image = "enemigos/Cactrot.gif"
	var property position = game.at(2, 5)

	var hp = 100
	var property carga = 0
	const property fuerza = 50 // ataque fisico
	const property vigor = 15 // defensa fisica
	const property intelecto = 20 // ataque magico
	const property mente = 15 // defensa magica
	
	method animarAtaque() {
		self.position(game.at(3,5))
		game.schedule(1000, { => self.position(game.at(2,5))})
	}
	
	method estaMuerto() {
		return hp <= 0
	}
	method hp() = hp
	
	method reducirHP(danio) {
		hp -= danio.max(0)
		if (hp <= 0) {
			game.removeVisual(self)
			game.say(ladron, "Ganaste!")
			game.schedule(500, { => game.stop()})
		}
		if (game.hasVisual(self)) game.say(self, "Mi vida ahora es " + hp.toString())
	}

	method elegirAtaque() {
		var ataqueElegido
		if (carga < 3) {
			ataqueElegido = ataqueFisico
			carga++
		}
		else {
			ataqueElegido = hechizoFulgor
			carga = 0
		}
		return ataqueElegido
	}
}
