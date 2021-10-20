import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*
import batalla.*

class Menu {
	const property position
	const property image
	var items // = [puntero,curacion,ataqueFisico,ataqueMagico]
	
	method activarMenu(){
		self.display()
	}

	method display(){
		game.addVisual(self)
		items.forEach({item=>game.addVisual(item)})
	}
	
	method removerMenu() {
        game.removeVisual(puntero)
        items.forEach({item=>game.removeVisual(item)})
    }

	method seleccionarOpcion(opcion, actor){
		opcion.accion(actor)
	}
}

class Estadisticas inherits Menu{
	var personajes // = [clerigo,otroClerigo,otroOClerigo]
	
	override method display(){
		game.addVisual(self)
		personajes.forEach({p=>self.addChar(p)})
	}
	method addChar(p){
		game.addVisual(p.vida())
		game.addVisual(p.icono())
	}
}




object menu {
	var property menuActivo = menuPrincipal

    method activarMenu() {
        menuActivo.display()
        game.addVisual(puntero)
    }
    
    method removerMenu() {
        game.removeVisual(puntero)
        menuActivo.notDisplay()
        menuActivo = menuPrincipal
    }
    
}

object menuPrincipal{
	
	method display(){
		game.addVisual(ataque)
		game.addVisual(fulgor)
        //...
	}

    method notDisplay() {
        game.removeVisual(ataque)
        game.removeVisual(fulgor)
        //...
    }
	
	method elementosHacia(direccion){
		return direccion.lugares()
	}

	method actualizarEn(direccion){
		direccion.restarLugares()
		direccion.opuesto().sumarLugares()
	}
        
	method seleccionarOpcion(opcion, quienAtaca){
		opcion.accion(quienAtaca)
	}
}

object menuAtaques{
	
}

object menuItems{
	
}

class Puntero {
	const posicionInicial
	var property position = posicionInicial
	const menuActual = menuBase
	method position() = position
	method image() = "background/cursor3.png"
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverseHacia(donde){
		if (donde.hayElementos(position.y())){
			position = donde.mover(position)
		}
	}
	method seleccionar(){
		game.uniqueCollider(self).realizar()
	}
}

const puntero = new Puntero(posicionInicial = game.at(2, 3))

object arriba{
	
	method hayElementos(posicion) = game.getObjectsIn(game.at(2,(posicion+1))) == []
	method mover(posicion){
		return posicion.up(1)
	}
	
}
object abajo{
	
	method hayElementos(posicion) = game.getObjectsIn(game.at(2,(posicion-1))) == []
	method mover(posicion){
		return posicion.down(1)
	}

}

object background {
	method image() = "background/fondo.jpeg"
}

object ataque {
	const property image = "background/ataque2.png"
	const property position = game.at(1, 3)
	method accion(quienAtaca){
		if (quienAtaca == ladron) turno.accionLadron(ataqueFisico)
        else if (quienAtaca == clerigo) turno.accionClerigo(ataqueFisico)
	}
}

object fulgor {
	const property image = "background/ataque2.png"
	const property position = game.at(1, 2)
	method accion(quienAtaca) {
		if (quienAtaca == ladron) turno.accionLadron(hechizoFulgor)
        else if (quienAtaca == clerigo) turno.accionClerigo(hechizoFulgor)
	}
}


