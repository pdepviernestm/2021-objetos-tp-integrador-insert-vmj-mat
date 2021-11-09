import wollok.game.*
import enemigo.*
import menu.*
import turnos.*	
import ataques.*
import tocadiscos.*
import paleta.*

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
	var property textColor = paleta.blanco()
	
	
	method posicionar(x,y){
		self.position(game.at(x,y))
	}
		method cambiarColor(color){
		textColor = color
	}
	method hpActual() = hpActual
	method hpInicial() = hpInicial
	method text() = hpActual.toString() + "/" + hpInicial.toString()	
}

class Personaje {
	var property position
	const text
	const property atributos
	var property textColor = paleta.blanco()

	method text() = text
	
	//method agregarseAlMenu(){game.addVisual(self)}
	method fuerza() = atributos.fuerza()
	method vigor() = atributos.vigor()
	method intelecto() = atributos.intelecto()
	method mente() = atributos.mente()

	method estaMuerto() = atributos.estaMuerto()
	method reducirHP(danio) { atributos.reducirHP(danio) }
	method aumentarHP(restauracion) { atributos.aumentarHP(restauracion) }
	method maxHP() = atributos.maxHP()

	method pulsar() {
		if(self.habilitado()) {
			turno.agregarAccion(self)
			if(turno.proximaAccion() == lazaro) {
				turno.heroesMuertos().forEach{ personaje => personaje.inhabilitar() }
			}
		}
	}

	method posicionar(posicion) { atributos.posicionOriginal(posicion) }

	method habilitado() = textColor == paleta.blanco()
	
	method inhabilitar() {
		textColor = paleta.gris()
	}

	method habilitar() {
		textColor = paleta.blanco()
	}
	
	method cambiarColor(color) {
		atributos.vida().cambiarColor(color)
	}
	
	method reset() {
		if(self.estaMuerto()) {
			self.aumentarHP(self.maxHP())
			atributos.image()
			self.habilitar()
		}
	}
	
	method posicion() = atributos.position()
	
	method comenzarBatalla() {
		self.aumentarHP(self.maxHP())
		self.habilitar()
	}
	
	method agregarPersonaje() {
		game.addVisual(self.atributos())
	}
	
	method eliminarPersonaje() {
		game.removeVisual(self.atributos())
	}
	
	method habilidades() = atributos.habilidades()
	method estaElPersonaje() = game.hasVisual(atributos)
	
	method recibirHabilidad(ataque, potencia){
		if (ataque == lazaro) {
			//salud.animar(self)
			self.reset()
		}
		else atributos.recibirHabilidad(ataque, (potencia - self.defensaTotal(ataque)).max(ataque.potenciaInicial()))
	}
	
	method defensaTotal(ataque) = ataque.naturaleza().estadisticaDeDefensa(self)
	method potenciaTotal(ataque) = ataque.naturaleza().estadisticaDePotencia(self) + ataque.potenciaInicial()
	
	method hacerHabilidad(ataque, enemigo) {
		enemigo.recibirHabilidad(ataque, self.potenciaTotal(ataque))	
	}	
	
	// exclusivos para héroes
	method vida() = atributos.vida()
	method icono() = atributos.icono()

	// exclusivos para enemigos
	method elegirAtaque() = atributos.elegirAtaque()
	method elegirObjetivo(objetivos) = atributos.elegirObjetivo(objetivos)

	//method animarAtaqueFisico() { atributos.animarAtaqueFisico() }
	//method animarAtaqueMagico() { atributos.animarAtaqueMagico() }
	
	
	method animarAtaqueFisico() {
		tocadiscos.tocar(sonidoPunio)
		atributos.position(atributos.posicionAtaque()) 
		game.schedule(1000, { => atributos.position(atributos.posicionOriginal()) })
	}

	method animarAtaqueMagico(elemento,atacado) {
		elemento.animar(atacado)
		tocadiscos.tocar(sonidoMagia)
	}

}

class Atributos {
	var posicionOriginal
	var property position = posicionOriginal
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
	
	method posicionOriginal(posicion){
		posicionOriginal = posicion
		position = posicion
	}

	method posicionOriginal() = posicionOriginal

	method posicionAtaque() = game.at(position.x()-1, position.y())
	//method agregarseAlMenu(){game.addVisual(self)}
	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return imagenMuerto
		else return image  
	}

	method image(ruta) {
		image = ruta
	}
	
	method estaMuerto() = hp == 0

	method reducirHP(danio) {
		hp = (hp - danio).max(0)
		vida.hpActual(hp)
		self.image()
	}
	
	method aumentarHP(restauracion) {
		hp = (hp + restauracion).min(maxHP)
		vida.hpActual(hp)
	}

	method recibirHabilidad(ataque, potencia){
		ataque.hacerEfecto(self, potencia)
	}
	
	method animarRecepcion(){
		image = imagenAtaque
		game.schedule(1000, { => image = imagenInicial })
	}	
}

const ladron = new Personaje (
	atributos = new Atributos(
		icono = new Icono(position = game.at(16, 2),image = "personajes/Thief2M.gif"),
		imagenInicial = "personajes/Thief2M-SW.gif",
		imagenAtaque = "personajes/Thief2M-Weak-SW.gif",
		imagenMuerto = "personajes/Thief2M-Dead-SW.gif",

		posicionOriginal = game.at(5, 8),

		maxHP = 100,
		vida = new Hp(hpInicial = 100, position = game.at(14, 2)),
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
		icono = new Icono(position = game.at(16, 4),image = "personajes/WhiteMage2F.gif"),
		imagenInicial = "personajes/WhiteMage2F-SW.gif",
		imagenAtaque =  "personajes/WhiteMage2F-Weak-SW.gif",
		imagenMuerto =  "personajes/WhiteMage2F-Dead-SW.gif",

		posicionOriginal = game.at(5, 6),
		
		maxHP = 120,
		vida = new Hp(hpInicial = 120,position= game.at(14,4)),
		fuerza = 20,
		vigor = 30,
		intelecto = 70,
		mente = 70,
		
		habilidades = [curacion, ataqueMagico, hechizoLazaro]
		// cambiar estadísticas
		),
	text = "clerigo",
	position = game.at(4, 1)
)

const poseidon = new Personaje(
	atributos = new Atributos(
		icono = new Icono(position = game.at(13, 2), image = "personajes/Summoner2M.gif"),
		//hp = new Hp(hpInicial = 150,position= game.at(14,2)),
		imagenInicial = "personajes/Summoner2M-SW.gif", 
		imagenAtaque = "personajes/Summoner2M-Weak-SW.gif",
		imagenMuerto = "personajes/Summoner2M-Dead-SW.gif",

		posicionOriginal = game.at(6, 10),	
		
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
		imagenAtaque = "personajes/Knight3M-Weak-SW.gif",
		imagenMuerto = "personajes/Knight1M-Dead-SW.gif",

		posicionOriginal = game.at(9, 9),
		
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