import wollok.game.*
import enemigo.*
import menu.*
import turnos.*
import ataques.*

object personaje {
	var image = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png"
	const property position = game.at(5, 5)
	var property objetivo = enemigo		// en el caso de que haya mas enemigos puedo elegir cual, o si quiero curar un companiero tambien
	
	var hp = 100
	const property fuerza = 20 // ataque fisico
	const property vigor = 30 // defensa fisica
	const property intelecto = 25 // ataque magico
	const property mente = 20 // defensa magica
	
	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
		else return image  
	}

	method image(ruta) {
		image = ruta
	}
	
	method estaMuerto(){
		return hp <= 0
	}
	
	method animarAtaque() {
		self.image("Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png")
		game.schedule(1000, { => self.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png") })
	}

	method hp() = hp
	
	method reducirHP(danio) {
		hp -= danio.max(0)
		if (self.estaMuerto()) {
			game.removeVisual(self)
			game.say(enemigo, "Game over...")
			game.schedule(500, { => game.stop() })
			}
		if (game.hasVisual(self)) game.say(self, "Mi vida ahora es " + hp.toString())
	}
}