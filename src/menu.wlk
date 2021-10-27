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
	var property items 

	//method items() = personajeActivo.habilidades()
	//un ejemplo de cómo haríamos para que el menú muestre
	//las habilidades de cada personaje

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

}

class Estadisticas {
	const property position
	const property image
	var property items 

	method display(){
		game.addVisual(self)
		items.forEach({ p => self.addChar(p) })
	}

	method addChar(p){
		game.addVisual(p.vida())
		game.addVisual(p.icono())
	}
	
	method removerStats() {
        items.forEach{ item => 
			game.removeVisual(item.vida())
			game.removeVisual(item.icono())
		}
		game.removeVisual(self)
    }
}

class Objetivos inherits Menu {
	method addChar(p){
		game.addVisual(p)
	}
	method inhabilitarOpciones() {
		items.filter{ p => p.estaMuerto() }.forEach{ p => p.inhabilitar() }
	}
}




class Puntero {
	const posicionInicial
	var property position = posicionInicial
	method image() = "background/cursor3.png"
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverseHacia(donde){
		if (donde.hayElementos(position.x(), position.y())){
			position = donde.mover(position)
		}
	}
	method seleccionar(){
		game.uniqueCollider(self).pulsar()
	}
}

class Lugar {
	const proximoX
	const proximoY
	method hayElementos(x, y) = !game.getObjectsIn(game.at(x + proximoX, y + proximoY)).isEmpty()
}

object arriba inherits Lugar(proximoX = 0, proximoY = 1) { 
	method mover(y){
		return y.up(1)
	}
}

object abajo inherits Lugar(proximoX = 0, proximoY = -1) { 
	method mover(y){
		return y.down(1)
	}
}

object izquierda inherits Lugar(proximoX = -2, proximoY = 0) { 
	method mover(x){
		return x.left(2)
	}
}

object derecha inherits Lugar(proximoX = 2, proximoY = 0) { 
	method mover(x){
		return x.right(2)
	}
}

// object arriba{
	
// 	method hayElementos(x,y) = game.getObjectsIn(game.at(x,(y+1))) != []
// 	method mover(y){
// 		return y.up(1)
// 	}
	
// }
// object abajo{

// 	method hayElementos(x,y) = game.getObjectsIn(game.at(x,(y-1))) != []
// 	method mover(y){
// 		return y.down(1)
// 	}

// }

// object izquierda{
	
// 	method hayElementos(x,y) = game.getObjectsIn(game.at(x-2,y)) != []
// 	method mover(x){
// 		return x.left(2)
// 	}
	
// }
// object derecha{
	
// 	method hayElementos(x,y) = game.getObjectsIn(game.at(x+2,y)) != []
// 	method mover(x){
// 		return x.right(2)
// 	}

// }


const menuBase = new Menu(
	position = game.at(1,1), 
	image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.1.png", 
	items = [curacion, ataqueFisico, ataqueMagico]
)