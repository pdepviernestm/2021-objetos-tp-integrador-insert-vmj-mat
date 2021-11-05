import wollok.game.*
import enemigo.*
import menu.*
//import aaaa.*
import turnos.*	
import ataques.*

class Icono{
	var property position
	const image
	method image() = image
	
	method posX() = self.position().x()
	method posY() = self.position().y()
}

class Hp{
	const hpInicial 
	var property hpActual = hpInicial
	var property position 
	
	
	method posicionar(x,y){
		self.position(game.at(x,y))
	}
	method hpActual() = hpActual
	method hpInicial() = hpInicial
	method text() = hpActual.toString() + "/" + hpInicial.toString()
	method textColor() = "ffffff"
	
}

class Personaje {
	var property position
	const text
	const property atributos
	var property textColor = "ffffff"

	method text() = text

	method fuerza() = atributos.fuerza()
	method vigor() = atributos.vigor()
	method intelecto() = atributos.intelecto()
	method mente() = atributos.mente()

	method estaMuerto() = atributos.estaMuerto()
	method reducirHP(danio) { atributos.reducirHP(danio) }
	method aumentarHP(restauracion) { atributos.aumentarHP(restauracion) }

	method animarAtaque() { atributos.animarAtaque() }

	method pulsar() {
		if(self.habilitado()) turno.agregarAccion(self)
	}

	method habilitado() = textColor == "ffffff"
	
	method inhabilitar() {
		textColor = "9b9b9b"
	}
	
	method reset(){
		self.aumentarHP(self.atributos().maxHP())
	}
	
	method agregarPersonaje() {
		game.addVisual(self.atributos())
	}
	
	method eliminarPersonaje() {
		game.removeVisual(self.atributos())
	}
	
	method habilidades() = atributos.habilidades()
	method estaElPersonaje() = game.hasVisual(atributos)
	
	//method hacerHabilidad(ataque, enemigo) { atributos.hacerHabilidad(ataque, enemigo) }
	method recibirHabilidad(ataque, potencia) { atributos.recibirHabilidad(ataque, potencia) }
	
	
	
	method hacerHabilidad(ataque, enemigo) {
		var potencia = 0
		if (ataque.esFisico()) potencia = ataque.potenciaInicial() + atributos.fuerza()
		else if (ataque.esMagico()) potencia = ataque.potenciaInicial() + atributos.intelecto()
		else if (ataque.esCurativo()) potencia = ataque.potenciaInicial() + atributos.mente()
		// else if (ataque.naturaleza() == lazaro) ...
		console.println(enemigo.toString())
		console.println(ataque.toString())
		console.println(potencia.toString())
		enemigo.recibirHabilidad(ataque, potencia)
		}
	
	
	// exclusivos para héroes
	method vida() = atributos.vida()
	method icono() = atributos.icono()

	// exclusivos para enemigos
	method elegirAtaque() = atributos.elegirAtaque()
	method elegirObjetivo(objetivos) = atributos.elegirObjetivo(objetivos)
}

class Atributos {
	const property position
	//var property objetivo
	var property vida = new Hp(hpInicial = 0, position = game.at(0,0))
	var property icono
	var property habilidades
	const property maxHP
	var property hp = maxHP
	
	const property fuerza 		// ataque fisico
	const property vigor		// defensa fisica
	const property intelecto   	// ataque magico
	const property mente  		// defensa magica

	const property imagenInicial
	const property imagenAtaque
	const property imagenMuerto

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
	
	method estaMuerto() = hp == 0

	method reducirHP(danio) {
		hp = (hp - danio).max(0)
		vida.hpActual(hp)
		
		if (self.estaMuerto()) {
			game.removeVisual(self)
		}
	}
	
	method aumentarHP(restauracion) {
		hp = (hp + restauracion).min(maxHP)
		vida.hpActual(hp)
	}
	
	method recibirHabilidad(ataque, potencia){
		var def = 0
		if (ataque.esFisico()){
			def = vigor
			self.reducirHP((potencia - def).max(ataque.potenciaInicial()))
		} 
		else if (ataque.esMagico()) {
			def = mente
			self.reducirHP((potencia - def).max(ataque.potenciaInicial()))
		}
		else if (ataque.esCurativo()) {
			self.aumentarHP(potencia)
		}
		// else if (ataque.naturaleza() == lazaro) ...
	}
}

const ladron = new Personaje (
	atributos = new Atributos(
		icono = new Icono(position = game.at(16,2),image = "personajes/Thief2M.gif"),
		imagenInicial = "personajes/Thief2M-SW.gif",
		imagenAtaque = "personajes/Thief2M-SW.gif",
		imagenMuerto = "personajes/Thief2M-SW.gif",

		position = game.at(5, 8),

		maxHP = 100,
		vida = new Hp(hpInicial = 100,position= game.at(14,2)),
		fuerza = 70,
		vigor = 70,
		intelecto = 25, 
		mente = 30,
		
		habilidades = [ataqueFisico]
		
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

		position = game.at(5, 6),
		
		maxHP = 120,
		vida = new Hp(hpInicial = 120,position= game.at(14,4)),
		fuerza = 20,
		vigor = 30,
		intelecto = 70,
		mente = 70,
		
		habilidades = [curacion, ataqueMagico]
		// cambiar estadísticas
		),
	text = "clerigo",
	position = game.at(4, 1)
)
const poseidon = new Personaje(
	atributos = new Atributos(
		icono = new Icono(position = game.at(13,2),image = "personajes/Summoner2M.gif"),
		//hp = new Hp(hpInicial = 150,position= game.at(14,2)),
		imagenInicial = "personajes/Summoner2M-SW.gif", 
		imagenAtaque = "personajes/Summoner2M-SW.gif",
		imagenMuerto = "personajes/Summoner2M-SW.gif",

		position = game.at(6, 10),	
		
		//icono = new Icono(position = game.at(16,3),image = "images/WhiteMage2F2.gif"),
	
		maxHP = 150,
		vida = new Hp(hpInicial = 150,position= game.at(11,2)),
		fuerza = 40,
		vigor = 20,
		intelecto = 60,
		mente = 10,
		
		habilidades = [ataquePiro, ataqueHielo,ataqueElectro,ataqueAero]
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

		position = game.at(9, 9),
		
		maxHP = 120,
		vida = new Hp(hpInicial = 120,position= game.at(11,4)),
		fuerza = 90,
		vigor = 50,
		intelecto = 40,
		mente = 70,
		
		habilidades = [ataqueFisico,ataqueEspada]
	),
	text = "hercules",
	position = game.at(4, 4)
)