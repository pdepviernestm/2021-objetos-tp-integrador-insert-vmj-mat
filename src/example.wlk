import wollok.game.*

object personaje {
	var property image = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png"
	const property position = game.at(5, 5)
	
	var hp = 100
	const property fuerza = 20 // ataque fisico
	const property vigor = 30 // defensa fisica
	const property intelecto = 25 // ataque magico
	const property mente = 20 // defensa magica

	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		image = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png"
		// game.onTick(1000, "cambiar imagen", { => personaje.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png")})
		game.schedule(1000, { => personaje.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png")})
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		if (hp <= 0) {
			hp = 0
			image = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
			}
	}

	method hp() = hp
}

object enemigo {
	const property image = "enemigos/Cactrot.gif"
	const property position = game.at(2, 5)

	var hp = 100
	const fuerza = 50 // ataque fisico
	const vigor = 15 // defensa fisica
	const intelecto = 20 // ataque magico
	const mente = 15 // defensa magica
	
	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		if (hp <= 0) game.removeVisual(self)
	}

	method hp() = hp
}

object turno {
	method comenzarTurno(){
		personaje.atacar(enemigo)
		enemigo.atacar(personaje)
		if (game.hasVisual(personaje)) game.say(personaje, "Mi vida ahora es " + personaje.hp().toString())
		if (game.hasVisual(enemigo)) game.say(enemigo, "Mi vida ahora es " + enemigo.hp().toString())
	}
}

object menu{

}

object puntero{

}

object background {
	method image() = "background/fondo.jpeg"
}