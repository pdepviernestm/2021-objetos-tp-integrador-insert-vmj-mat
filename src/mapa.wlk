import wollok.game.*
import menu.*
import batalla.*
import pantallaInicio.*
import config.*

object mapa inherits Interfaz{
	const property image = "background/mapaLindo.jpg"
	const property position = game.origin()

	override method itemsActuales() = menuMapa.items().map{i => i.nombre()}
	override method posicionarItems() {
		self.itemsActuales().forEach{i => game.addVisual(i)}
	}
}

class Opcion {
    const destino
    const nombre
	var habilitada = false
    var property position = game.origin()
    var property textColor = colorInhabilitado
	
	method nombre() = destino.nombre()
	
    method pulsar() {
    	if(habilitada) {
	    	menuMapa.removerse()
	    	mapa.removerse()
	        destino.iniciar()
    	}
    }
    
    method text() = nombre
    
    
    method habilitar() {
    	textColor = colorHabilitado
    	habilitada = true
    	destino.habilitar()
    }
    
    method inhabilitar() {
    	textColor = colorInhabilitado
    	habilitada = false
    	destino.inhabilitar()
    }
}

/* Menu del mapa */

const menuMapa = new Menu (
	position = game.origin(),
	image = "menu/menuMapita.png",
	area = new AreaMenu(inicio = game.at(1, 0), alto = 3, ancho = 1),
	items = [opcionBatallaFacil, opcionBatallaDificil, opcionBatallaMasDificil, opcionBatallaFinal]
)

/* Opciones */

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

