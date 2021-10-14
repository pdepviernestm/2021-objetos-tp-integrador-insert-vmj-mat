import wollok.game.*
import enemigo.*
import menu.*
import turnos.*
import ataques.*

const ladron = new Personaje (
	imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png",
	imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
	imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
	
	imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	position = game.at(5, 5),
	objetivo = enemigo,

	hp = 100,
	fuerza = 20,
	vigor = 30,
	intelecto = 25, 
	mente = 30
)

const clerigo = new Personaje (
	imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png",
	imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
	imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
	
	imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	
	// cambiar imágenes
	position = game.at(5, 3),
	objetivo = enemigo,

	hp = 120,
	fuerza = 20,
	vigor = 30,
	intelecto = 25,
	mente = 30
	// cambiar estadísticas
)

class Personaje {
	const property position
	var property objetivo

	var hp
	const property fuerza 		// ataque fisico
	const property vigor  		// defensa fisica
	const property intelecto   	// ataque magico
	const property mente  		// defensa magica

	const property imagenInicial
	const property imagenAtaque
	const property imagenMuerto

	const property imagenVida1
	const property imagenVida2
	const property imagenVida3

	var image = imagenInicial

	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return imagenMuerto
		else return image  
	}

	method image(ruta) {
		image = ruta
	}

	method animarAtaque() {
		self.image(imagenAtaque)
		game.schedule(1000, { => self.image(imagenInicial) })
	}

	method estaMuerto() {
		return hp <= 0
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