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
		items.forEach({ item => game.addVisual(item) })
		game.addVisual(puntero)
		modo.puntero(puntero)
	}
	
	method removerMenu(puntero) {
        game.removeVisual(puntero)
        items.forEach({ item => game.removeVisual(item) })
		game.removeVisual(self)
    }

	method seleccionarOpcion(opcion, actor){
		opcion.accion(actor)
	}
}

class Estadisticas inherits Menu {
	
	method display(){
		game.addVisual(self)
		items.forEach({p=>self.addChar(p)})
	}
	method addChar(p){
		game.addVisual(p.atributos().vida())
		game.addVisual(p.atributos().icono())
	}
	method removerStats() {
        items.forEach({item=>game.removeVisual(item)})
		//game.removeVisual(self)
    }
	
}

class Objetivos inherits Estadisticas{
	override method display(puntero){
		game.addVisual(self)
		items.forEach{ item => game.addVisual(item) }
		game.addVisual(puntero)
		modo.puntero(puntero)
	}
	override method addChar(p){
		game.addVisual(p)
	}
	
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

object izquierda{
	
	method hayElementos(x,y) = game.getObjectsIn(game.at(x-2,y)) != []
	method mover(x){
		return x.left(2)
	}
	
}
object derecha{
	
	method hayElementos(x,y) = game.getObjectsIn(game.at(x+2,y)) != []
	method mover(x){
		return x.right(2)
	}

}

object background {
	method image() = "background/fondo.jpeg"
}

const menuBase = new Menu(
	position = game.at(1,1), 
	image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.1.png", 
	items = [curacion, ataqueFisico, ataqueMagico]
)

