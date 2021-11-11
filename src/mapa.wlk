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
	items = [opcionBatallaFinal,opcionBatallaFacil, opcionBatallaDificil]
)



class Opcion {
    const destino
    const nombre
   // const property indice 
    var property position

	
	method nombre() = destino.nombre()
	
    method pulsar() {
    	menuMapa.removerse()
    	mapa.removerse()
        destino.iniciar()
    }
    method text() = nombre
    method textColor() = paleta.blanco()
}

const opcionBatallaFacil = new Opcion(
    destino = batallaFacil,
    nombre = "Batalla fácil",
    position = game.at(5, 5)//,
    //indice = new Indice(position = game.at(4,5), nombre = "Batalla Facil")
)

const opcionBatallaDificil = new Opcion(
    destino = batallaDificil,
    nombre = "Batalla Difícil",
    position = game.at(7, 2)//,
    //indice = new Indice(position = game.at(7,2), nombre = "Batalla Dificil")
)

const opcionBatallaFinal = new Opcion(
    destino = batallaFinal,
    nombre = "Batalla Final",
    position = game.at(2, 2)//,
    //indice = new Indice(position = game.at(2,2), nombre = "Batalla Dificil")
)


class Indice {
	const property position
	const nombre
	const color = paleta.blanco()
	
	method text() = nombre
	method textColor() = color 
}