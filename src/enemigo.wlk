import wollok.game.*
import menu.*
import personaje.*
import turnos.*

object enemigo {
	const property image = "enemigos/Cactrot.gif"
	var property position = game.at(2, 5)

	var hp = 100
	const fuerza = 50 // ataque fisico
	const vigor = 15 // defensa fisica
	const intelecto = 20 // ataque magico
	const mente = 15 // defensa magica
	
	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		self.position(game.at(3,5))
		game.schedule(1000, { => self.position(game.at(2,5))})
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		if (hp <= 0) game.removeVisual(self)
		if (game.hasVisual(enemigo)) game.say(enemigo, "Mi vida ahora es " + enemigo.hp().toString())
		
	}

	method hp() = hp
}
