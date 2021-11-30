import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*
import batalla.*
import config.*


class Direccion{
	var property sentido
	var lugares
	method mover(unaPosicion) = sentido.mover(unaPosicion,lugares)	
	method hayElementos(posicion) = !game.getObjectsIn(sentido.mover(posicion,lugares)).isEmpty()
}

class Diagonal inherits Direccion{
	var property opuesto
	method moverOpuesto(unaPosicion) = opuesto.mover(unaPosicion,lugares)
	method sentidoOpuesto() =
		return new Diagonal(lugares = lugares,sentido = opuesto,opuesto = sentido)
}

object mayor {
	method enVertical(lugares) = lugares
	method enHorizontal(lugares) = lugares + 1 
	method mover(posicion,lugares) = posicion.down(self.enVertical(lugares)).right(self.enHorizontal(lugares))
}

object menor {
	method enVertical(lugares) = lugares
	method enHorizontal(lugares) = lugares + 1 
	method mover(posicion,lugares) = posicion.down(self.enVertical(lugares)).left(self.enHorizontal(lugares))
	
}

object arriba  {
	 method mover(posicion,lugares) = posicion.up(lugares)
}

object abajo  {
	 method mover(posicion,lugares) = posicion.down(lugares)
}

object izquierda  {
	 method mover(posicion,lugares) = posicion.left(lugares)
}

object derecha  {
	 method mover(posicion,lugares) = posicion.right(lugares)
}




