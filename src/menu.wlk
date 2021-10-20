import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*
import batalla.*
import elementos.*

class Menu {
	const property position
	const property image
	var items 

	method display(puntero){
		game.addVisual(self)
		items.forEach({item=>game.addVisual(item)})
		game.addVisual(puntero)
	}
	
	method removerMenu(puntero) {
        //game.removeVisual(self)
        game.removeVisual(puntero)
        items.forEach({item=>game.removeVisual(item)})
    }

	method seleccionarOpcion(opcion, actor){
		opcion.accion(actor)
	}
}

class Estadisticas inherits Menu{
	
	
	method display(){
		game.addVisual(self)
		items.forEach({p=>self.addChar(p)})
	}
	method addChar(p){
		game.addVisual(p.vida())
		game.addVisual(p.icono())
	}
	method removerStats() {
        //game.removeVisual(self)
        items.forEach({item=>game.removeVisual(item)})
    }
	
}




object menu {
	var property menuActivo = menuPrincipal

    method activarMenu() {
        menuActivo.display()
        game.addVisual(punteroBase)
    }
    
    method removerMenu() {
        game.removeVisual(punteroBase)
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
	method position() = position
	method image() = "background/cursor3.png"
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverseHacia(donde){
		if (donde.hayElementos(position.x(),position.y())){
			position = donde.mover(position)
		}
	}
	method seleccionar(){
		game.uniqueCollider(self).pulsar()
	}
}

//const puntero = new Puntero(posicionInicial = game.at(3, 3))

object arriba{
	
	method hayElementos(x,y) = game.getObjectsIn(game.at(x,(y+1))) != []
	method mover(y){
		return y.up(1)
	}
	
}
object abajo{
	
	method hayElementos(x,y) = game.getObjectsIn(game.at(x,(y-1))) != []
	method mover(y){
		return y.down(1)
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
		if (quienAtaca == ladron) turno.accionLadron(ataqueMagico)
        else if (quienAtaca == clerigo) turno.accionClerigo(ataqueMagico)
	}
}


