import wollok.game.*
import enemigo.*
import menu.*
import turnos.*

object personaje {
	var image = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png"
	const property position = game.at(5, 5)
	var property objetivo = enemigo		// en el caso de que haya mas enemigos puedo elegir cual, o si quiero curar un companiero tambien
	// var property turno = true		// si le toca
	
	
	var hp = 100
	const property fuerza = 20 // ataque fisico
	const property vigor = 30 // defensa fisica
	const property intelecto = 25 // ataque magico
	const property mente = 20 // defensa magica

	var property proximaAccion
	
	
	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
		else return image  
	}

	method image(ruta) {
		image = ruta
	}
	
	method estaMuerto(){
		return if (hp <= 0) true else false
	}

	method realizarAccion() {
		if (proximaAccion == "atacar") self.atacar(objetivo)
		// if (proximaAccion == "piro") self.piro(objetivo)
	}
	
	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		self.image("Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png")
		game.schedule(1000, { => self.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png") })
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		/*if (hp <= 0) {
			hp = 0
			image = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
			}*/
		if (game.hasVisual(personaje)) game.say(personaje, "Mi vida ahora es " + personaje.hp().toString())
	}

	method hp() = hp
}