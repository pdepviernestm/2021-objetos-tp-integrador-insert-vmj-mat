import wollok.game.*
import enemigo.*
import menu.*
import turnos.*	
import ataques.*
import tocadiscos.*
import paleta.*

class Icono{
	var property position = game.origin()
	const image
	method image() = image
	
	method posX() = self.position().x()
	method posY() = self.position().y()
}

class Hp{
	const hpInicial 
	var property hpActual = hpInicial
	var property position = game.origin()
	var property textColor = colorHabilitado
	
	
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
	var property position = game.origin()
	var property habilitado = true
	const text
	const property atributos
	var property textColor = colorHabilitado

	method text() = text
	method hp() = atributos.hp()
	method fuerza() = atributos.fuerza()
	method vigor() = atributos.vigor()
	method intelecto() = atributos.intelecto()
	method mente() = atributos.mente()

	method estaMuerto() = atributos.estaMuerto()
	method reducirHP(danio) { atributos.reducirHP(danio) }
	method aumentarHP(restauracion) { atributos.aumentarHP(restauracion) }
	method maxHP() = atributos.maxHP()

	method pulsar() {
		if(habilitado) {
			turno.agregarAccion(self)
			if(turno.proximaAccion() == lazaro) {
				turno.heroesMuertos().forEach{ personaje => personaje.inhabilitar() }
			}
		}
	}

	method posicionar(posicion) { atributos.posicionOriginal(posicion) }
	
	method inhabilitar() {
		habilitado = false
		textColor = colorInhabilitado
	}

	method habilitar() {
		habilitado = true
		textColor = colorHabilitado
	}
	
	method cambiarColor(color) {
		atributos.vida().cambiarColor(color)
	}
	
	method reset() {
		if(self.estaMuerto()) {
			self.aumentarHP((self.maxHP() * 2 / 3).roundUp())
			self.habilitar()
		}
	}
	
	method posicion() = atributos.position()
	
	method comenzarBatalla() {
		self.aumentarHP(self.maxHP())
		self.habilitar()
	}
	
	method agregarPersonaje() {
		self.posicionar(atributos.position())
		game.addVisual(self.atributos())
	}
	
	method eliminarPersonaje() {
		game.removeVisual(self.atributos())
	}
	
	method habilidades() = atributos.habilidades()
	method estaElPersonaje() = game.hasVisual(atributos)
	
	method recibirHabilidad(ataque, potencia){
		if (ataque == lazaro) {
			self.reset()
		}
		else atributos.recibirHabilidad(ataque, (potencia - self.defensaTotal(ataque)).max(ataque.potenciaInicial()))
	}
	
	method defensaTotal(ataque) = ataque.naturaleza().estadisticaDeDefensa(self)
	method potenciaTotal(ataque) = ataque.naturaleza().estadisticaDePotencia(self) + ataque.potenciaInicial()
	
	method hacerHabilidad(ataque, enemigo) {
		enemigo.recibirHabilidad(ataque, self.potenciaTotal(ataque))	
	}	
	
	method vida() = atributos.vida()
	method icono() = atributos.icono()

	method elegirAtaque() = atributos.elegirAtaque()
	method elegirObjetivo(objetivos) = atributos.elegirObjetivo(objetivos)
	
	method animarAtaqueFisico() {
		tocadiscos.tocar(sonidoPunio)
		atributos.position(atributos.posicionAtaque()) 
		game.schedule(1000, { => atributos.position(atributos.posicionOriginal()) })
	}
	
	method animarAtaqueEspada() {
		tocadiscos.tocar(sonidoEspada)
		atributos.position(atributos.posicionAtaque()) 
		game.schedule(1000, { => atributos.position(atributos.posicionOriginal()) })
	}

	method animarAtaqueMagico(elemento,atacado) {
		elemento.animar(atacado)
		tocadiscos.tocar(sonidoMagia)
	}

}

class Atributos {
	var posicionOriginal = game.origin()
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

	var property image = imagenInicial
	
	
	method posicionOriginal(posicion){
		posicionOriginal = posicion
		position = posicion
	}

	method posicionOriginal() = posicionOriginal

	method posicionAtaque() = game.at(position.x()-1, position.y())

	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return imagenMuerto
		else return image  
	}

	
	method estaMuerto() = hp == 0

	method reducirHP(danio) {
		hp = (hp - danio).max(0)
		vida.hpActual(hp)
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
		icono = new Icono(image = "personajes/Thief2M.gif"),
		imagenInicial = "personajes/Thief2M-SW.gif",
		imagenAtaque = "personajes/Thief2M-Weak-SW.gif",
		imagenMuerto = "personajes/Thief2M-Dead-SW.gif",


		maxHP = 100,
		vida = new Hp(hpInicial = 100),
		fuerza = 70,
		vigor = 70,
		intelecto = 25, 
		mente = 30,
		
		habilidades = [ataqueFisico]
		
	),
	text = "Ladron"
)


const clerigo = new Personaje (
	atributos = new Atributos(	
		icono = new Icono(image = "personajes/WhiteMage2F.gif"),
		imagenInicial = "personajes/WhiteMage2F-SW.gif",
		imagenAtaque =  "personajes/WhiteMage2F-Weak-SW.gif",
		imagenMuerto =  "personajes/WhiteMage2F-Dead-SW.gif",

		
		maxHP = 120,
		vida = new Hp(hpInicial = 120),
		fuerza = 20,
		vigor = 30,
		intelecto = 70,
		mente = 70,
		
		habilidades = [curacion, ataqueMagico, hechizoLazaro]
		
		),
	text = "Clerigo"
)

const poseidon = new Personaje(
	atributos = new Atributos(
		icono = new Icono(image = "personajes/Summoner2M.gif"),
		
		imagenInicial = "personajes/Summoner2M-SW.gif", 
		imagenAtaque = "personajes/Summoner2M-Weak-SW.gif",
		imagenMuerto = "personajes/Summoner2M-Dead-SW.gif",

		
		maxHP = 150,
		vida = new Hp(hpInicial = 150),
		fuerza = 40,
		vigor = 20,
		intelecto = 60,
		mente = 10,
		
		habilidades = [ataquePiro, ataqueHielo,ataqueElectro,ataqueAero]
	),
	text = "Poseidon"
)

const hercules = new Personaje( 
	atributos = new Atributos(
		icono= new Icono(image ="personajes/Knight3M.gif" ),
		
		imagenInicial = "personajes/Knight3M-SW.gif", 
		imagenAtaque = "personajes/Knight3M-Weak-SW.gif",
		imagenMuerto = "personajes/Knight1M-Dead-SW.gif",

		
		maxHP = 120,
		vida = new Hp(hpInicial = 120),
		fuerza = 90,
		vigor = 50,
		intelecto = 40,
		mente = 70,
		
		habilidades = [ataqueFisico,ataqueEspada]
	),
	text = "Hercules"
)

