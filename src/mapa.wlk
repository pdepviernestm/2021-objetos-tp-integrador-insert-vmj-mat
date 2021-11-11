import wollok.game.*
import menu.*
import batalla.*
import pantallaInicio.*
import elementos.*
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
	area = new AreaMenu(inicio = game.at(1, 1), alto = 3, ancho = 1),
	items = [opcionBatallaFinal, opcionBatallaFacil, opcionBatallaDificil]
)



class Opcion {
    const destino
    const nombre
    var property position
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
    nombre = "Batalla Fácil",
    position = game.at(5, 5)
)

const opcionBatallaDificil = new Opcion(
    destino = batallaDificil,
    nombre = "Batalla Difícil",
    position = game.at(7, 2)
)

const opcionBatallaFinal = new Opcion(
    destino = batallaFinal,
    nombre = "Batalla Final",
    position = game.at(2, 2)
)


class Indice {
	const property position
	const nombre
	const color = paleta.blanco()
	
	method text() = nombre
	method textColor() = color 
}