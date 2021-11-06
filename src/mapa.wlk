import wollok.game.*
import menu.*
import batalla.*
import pantallaInicio.*
import elementos.*

const menuMapa = new Menu (
	position = game.origin(),
	image = "background/mapaLindo.jpg",
	area = new AreaMenu(inicio = game.at(2, 2), alto = 2, ancho = 3),
	items = [opcionBatallaFacil, opcionBatallaDificil]
)

class Opcion {
    const destino
    const nombre
    const property indice 
    var property position

	
	method nombre() = destino.nombre()
	
    method pulsar() {
    	menuMapa.removerMenu()
        //game.removeVisual(punteroInicio)
    	//pantallaInicio.opciones().forEach{ opcion => game.removeVisual(opcion) }
    	menuMapa.items().forEach{i=>game.removeVisual(i.nombre())}
        destino.iniciar()
    }
	/*method agregarseAlMenu(){
		game.addVisual(self)
		game.addVisual(destino.nombre())
	}*/
    method text() = nombre
    method textColor() = "ffffff"
}

const opcionBatallaFacil = new Opcion(
    destino = batallaFacil,
    nombre = "Batalla fácil",
    position = game.at(5, 5),
    indice = new Indice(position = game.at(4,5),nombre = "Batalla Facil")
)

const opcionBatallaDificil = new Opcion(
    destino = batallaDificil,
    nombre = "Batalla difícil",
    position = game.at(5, 6),
    indice = new Indice(position = game.at(7,2),nombre = "Batalla dificil")
)
 


class Indice {
	const property position
	const nombre
	var color = "ffffff" 
	
	method text() = nombre
	method textColor() = color 
	
	
	
}

