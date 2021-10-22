import wollok.game.*
import enemigo.*
import menu.*
import turnos.*
import ataques.*

class Icono{
	const  position
	const  image
	method position() = position
	method image() = image
}

class Hp{
	var property rol = ataque
	const hpInicial 
	var hpActual = hpInicial
	const property position 
	
	method hpActual() = hpActual
	method hpInicial() = hpInicial
	method text() = hpInicial.toString() + "/" + hpActual.toString()
	method textColor() = "ffffff"
	method perderHP(n){
		hpActual -= n
	}
	method ganarHP(n){
		hpActual += n
	}
}

class Personaje {
	const position
	const text
	const property atributos
	method position() = position
	method text() = text
	method textColor() = "ffffff"
	
	method pulsar(){
		turno1.objetivoTurno(self)
	}
}

class Atributos {
	const property position
	var property objetivo
	var property vida = new Hp(hpInicial = 0,position = game.at(0,0))
	var property icono
	var property hp
	
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

	var imageVida = imagenVida1
	var imageVida2 = imagenVida2
	var imageVida3 = imagenVida3

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
		return hp == 0
	}

	
	method reducirHP(danio) {
		hp -= danio
		vida.perderHP(danio)
		
		if (self.estaMuerto()) {
			game.removeVisual(self)
			game.say(enemigo1, "Game over...")
			game.schedule(500, { => game.stop() })
			}
		if (game.hasVisual(self)) {
			game.say(self, "Mi vida ahora es " + hp.toString())}
	}
	
	method aumentarHP(cura){
		if (!self.estaMuerto()){
		hp += cura	
		vida.ganarHp(cura)
		}
		else{}
	}

	
}

const ladron = new Personaje (
	atributos = new Atributos(
	icono = new Icono(position = game.at(16,2),image = "menu/WhiteMage2F2.gif"),
	//hp = new Hp(hpInicial = 100,position= game.at(14,2)),
	imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png",
	imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
	imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
	
	imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
	imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
	position = game.at(5, 8),
	objetivo = enemigo1,

	hp = 100,
	vida = new Hp(hpInicial = 100,position= game.at(14,2)),
	fuerza = 20,
	vigor = 30,
	intelecto = 25, 
	mente = 30
	),
	text = "ladron",
	position = game.at(4, 2)
)


const clerigo = new Personaje (
	atributos = new Atributos(	
		icono = new Icono(position = game.at(16,4),image = "menu/WhiteMage2F2.gif"),
		//hp = new Hp(hpInicial = 120,position= game.at(14,2)),
		imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png",
		imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
		imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		
		// cambiar imágenes
		position = game.at(5, 6),
		objetivo = enemigo1,
		
		hp = 120,
		vida = new Hp(hpInicial = 120,position= game.at(14,4)),
		fuerza = 20,
		vigor = 30,
		intelecto = 25,
		mente = 30
		// cambiar estadísticas
		),
	text = "clerigo",
	position = game.at(4, 1)
)
const poseidon = new Personaje(
	//CAMBIAR IMAGENES 
	atributos = new Atributos(
		icono = new Icono(position = game.at(13,2),image = "menu/WhiteMage2F2.gif"),
		//hp = new Hp(hpInicial = 150,position= game.at(14,2)),
		imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png", 
		imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
		imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(6, 6),
		objetivo = enemigo1, // CAMBIAR A ENEMIGO INTERMEDIO
	
		
		//icono = new Icono(position = game.at(16,3),image = "images/WhiteMage2F2.gif"),
	
		hp = 150,
		vida = new Hp(hpInicial = 150,position= game.at(11,2)),
		fuerza = 40,
		vigor = 20,
		intelecto = 60,
		mente = 10
	),
	text = "poseidon",
	position = game.at(4, 3)
)

const hercules = new Personaje(
	//CAMBIAR IMAGENES 
	atributos = new Atributos(
		icono= new Icono(position = game.at(13,4),image = "menu/WhiteMage2F2.gif"),
		//hp= new Hp(hpInicial = 120,position= game.at(14,2)),
		
		imagenInicial = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png", 
		imagenAtaque = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png",
		imagenMuerto = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(7, 7),
		objetivo = enemigo1, // CAMBIAR A ENEMIGO INTERMEDIO
		
		hp = 120,
		vida = new Hp(hpInicial = 120,position= game.at(11,4)),
		fuerza = 90,
		vigor = 50,
		intelecto = 40,
		mente = 70
	),
	text = "hercules",
	position = game.at(4, 4)
)




/*class Personaje {
	var property vida //= new Hp(hpInicial = 100)
	var property icono //= new Icono(position = game.at(16,4),image = "images/WhiteMage2F.gif")
	
}*/