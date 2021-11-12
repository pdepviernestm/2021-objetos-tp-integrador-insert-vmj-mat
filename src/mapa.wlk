import wollok.game.*
import menu.*
import batalla.*
import pantallaInicio.*
import paleta.*

object mapa inherits Interfaz{
	const property image = "background/mapaLindo.jpg"
	const property position = game.origin()

	override method itemsActuales() = menuMapa.items().map{i => i.nombre()}
	override method posicionarItems() {
		self.itemsActuales().forEach{i => game.addVisual(i)}
	}
}

const menuMapa = new Menu (
	position = game.origin(),
	image = "menu/menuMapita.png",
	area = new AreaMenu(inicio = game.at(1, 0), alto = 3, ancho = 1),
	items = [opcionBatallaFacil, opcionBatallaDificil, opcionBatallaMasDificil, opcionBatallaFinal]
)



class Opcion {
    const destino
    const nombre
    var property position = game.origin()
    var property textColor = paleta.gris()
	
	method nombre() = destino.nombre()
	
    method pulsar() {
    	if(self.habilitada()) {
	    	menuMapa.removerse()
	    	mapa.removerse()
	        destino.iniciar()
    	}
    }
    
    method text() = nombre
    
    method habilitada() = textColor == paleta.blanco()
    
    method habilitar() {
    	textColor = paleta.blanco()
    }
    
    method inhabilitar() {
    	textColor = paleta.gris()
    }
}

const opcionBatallaFacil = new Opcion(
    destino = batallaFacil,
    nombre = "Llanura"
)

const opcionBatallaDificil = new Opcion(
    destino = batallaDificil,
    nombre = "Bosque"
)

const opcionBatallaMasDificil = new Opcion(
	destino = batallaMasDificil,
	nombre = "Desierto"
)

const opcionBatallaFinal = new Opcion(
    destino = batallaFinal,
    nombre = "Abismo"
)


class Indice {
	const property position
	const nombre
	const color = paleta.blanco()
	
	method text() = nombre
	method textColor() = color 
}