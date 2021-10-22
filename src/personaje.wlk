import wollok.game.*
import enemigo.*
import menu.*
import turnos.*
import ataques.*

class Icono{
	const position
	const image
	method position() = position
	method image() = image
}

class Hp{
	const hpInicial 
	var property hpActual = hpInicial
	const property position 
	
	method hpActual() = hpActual
	method hpInicial() = hpInicial
	method text() = hpActual.toString() + "/" + hpInicial.toString()
	method textColor() = "ffffff"
	
}

class Personaje {
	const position
	const text
	const property atributos
	method position() = position
	method text() = text
	method textColor() = "ffffff"
	
	method pulsar(){
		turno.agregarAccion(self)
	}
}

class Atributos {
	const property position
	var property objetivo
	var property vida = new Hp(hpInicial = 0,position = game.at(0,0))
	var property icono
	const property maxHP
	var property hp = maxHP
	
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

	method estaMuerto() = hp == 0

	method reducirHP(danio) {
		hp = (hp - danio).max(0)
		vida.hpActual(hp)
		
		if (self.estaMuerto()) {
			game.removeVisual(self)
		}
	}
	
	method aumentarHP(cura) {
		hp = (hp + cura).min(maxHP)
		vida.hpActual(hp)
	}

}

const ladron = new Personaje (
	atributos = new Atributos(
		icono = new Icono(position = game.at(16,2),image = "personajes/Thief2M.gif"),
		imagenInicial = "personajes/Thief2M-SW.gif",
		imagenAtaque = "personajes/Thief2M-SW.gif",
		imagenMuerto = "personajes/Thief2M-SW.gif",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(5, 8),
		objetivo = cactrot,

		maxHP = 100,
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
		icono = new Icono(position = game.at(16,4),image = "personajes/WhiteMage2F.gif"),
		imagenInicial = "personajes/WhiteMage2F-SW.gif",
		imagenAtaque =  "personajes/WhiteMage2F-SW.gif",
		imagenMuerto =  "personajes/WhiteMage2F-SW.gif",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		
		// cambiar imágenes
		position = game.at(5, 6),
		objetivo = flan,
		
		maxHP = 120,
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
		icono = new Icono(position = game.at(13,2),image = "personajes/Summoner2M.gif"),
		//hp = new Hp(hpInicial = 150,position= game.at(14,2)),
		imagenInicial = "personajes/Summoner2M-SW.gif", 
		imagenAtaque = "personajes/Summoner2M-SW.gif",
		imagenMuerto = "personajes/Summoner2M-SW.gif",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(6, 10),
		objetivo = tomberi, // CAMBIAR A ENEMIGO INTERMEDIO
	
		
		//icono = new Icono(position = game.at(16,3),image = "images/WhiteMage2F2.gif"),
	
		maxHP = 150,
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
		icono= new Icono(position = game.at(13,4),image ="personajes/Knight3M.gif" ),
		//hp= new Hp(hpInicial = 120,position= game.at(14,2)),
		
		imagenInicial = "personajes/Knight3M-SW.gif", 
		imagenAtaque = "personajes/Knight3M-SW.gif",
		imagenMuerto = "personajes/Knight3M-SW.gif",
		
		imagenVida1 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida2 = "Bandits/Sprites/Vida/Corazon.png",
		imagenVida3 = "Bandits/Sprites/Vida/Corazon.png",
		position = game.at(9, 9),
		objetivo = duende, // CAMBIAR A ENEMIGO INTERMEDIO
		
		maxHP = 120,
		vida = new Hp(hpInicial = 120,position= game.at(11,4)),
		fuerza = 90,
		vigor = 50,
		intelecto = 40,
		mente = 70
	),
	text = "hercules",
	position = game.at(4, 4)
)

