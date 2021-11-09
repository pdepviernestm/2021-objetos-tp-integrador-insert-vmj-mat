import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*
import batalla.*
import elementos.*



class Puntero {
	var property posicionInicial
	var property position = posicionInicial
	method image() = "menu/cursor3.png"
	
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverseHacia(donde){
		if (donde.hayElementos(position.x(), position.y())){
			position = donde.mover(position)
		}
	}

	method seleccionar() {
		game.uniqueCollider(self).pulsar()
	}
}



class AreaMenu {
	var inicio
	var proxima = inicio
	var ancho
	var alto
	var distanciaX = 3
	var distanciaY = 1
	
	method estaLibre(posicion) = game.getObjectsIn(posicion).isEmpty()
	
	method dentroDeArea(posicion) = ancho + inicio.x() - posicion.x() >= 0 and alto + inicio.y() - posicion.y() >= 0
	
	method puedePosicionarse(posicion){
		return self.dentroDeArea(posicion) and self.estaLibre(posicion)
	}

	method proximaPosicionLibre(){
	  	if (self.puedePosicionarse(proxima.up(distanciaY)))
	  	return proxima.up(distanciaY)
	  	else if (self.puedePosicionarse(proxima.right(distanciaX)))
	  	return proxima.right(distanciaX)
	  	else {proxima.right(distanciaX)
	  		if (self.puedePosicionarse(proxima.down(distanciaY)))
	  		return proxima.down(distanciaY)
	  		else return proxima
	  		}
	}
	
	method posicionarItems(items){
		proxima = inicio
		items.forEach{ i => if (self.estaLibre(proxima)) self.posicionarItem(i) }
	}
	
	method posicionarItem(i){
		i.position(proxima)
		proxima = self.proximaPosicionLibre()
	}
}

 
class Interfaz {
	var property items = []
	var area = new AreaMenu(inicio = game.at(0,0),alto=0,ancho=0)
	
	
	method posicionarItems(){
		area.posicionarItems(items)
		items.forEach({ item => game.addVisual(item) })
	}
	
	method display(){
		items = self.itemsActuales()
		game.addVisual(self)
		self.posicionarItems()
	}
	
	method itemsActuales()
	
	method removerse(){
		game.removeVisual(self)
		self.removerItems()
	}
	
	method removerItems(){
		self.itemsActuales().forEach{i => game.removeVisual(i)}
	}
	
}
		
		
class Estadisticas inherits Interfaz {
	const property position 
	const property image = "menu/FondoStats.png"
	const personajes = items
	
	
	override method itemsActuales() = personajes.map{p => p.icono()}
	override method posicionarItems(){
		super()
		self.agregarVida()
	}

	
	method agregarVida(){
		personajes.forEach{ p => p.vida().position(game.at(p.icono().posX() -2,p.icono().posY()))
		game.addVisual(p.vida()) }
		
	}
	
	method agregarIcono(p){	
		game.addVisual(p.icono())
	}
	
	override method removerItems(){
		personajes.forEach{ item => 
			game.removeVisual(item.vida())
			game.removeVisual(item.icono())
		}
	}
	
}

class Menu inherits Interfaz {
	const property position
	const property image
	var puntero = new Puntero (posicionInicial = game.at(0,0))
	
	method puntero() = puntero

	override method itemsActuales() = items
	 
	override method display(){
		super()	
		self.agregarPuntero()
	}
	
	override method removerItems() {
		super()
		game.removeVisual(puntero)
	}
	
	method agregarPuntero() {
		puntero.position(items.head().position())
		game.addVisual(puntero)
		modo.puntero(puntero)
	}
}
	
	
class Objetivos inherits Menu {
	method inhabilitarOpciones() {
		items.filter{ p => p.estaMuerto() }.forEach{ p => p.inhabilitar() }
	}
}

const menuBase = new MenuHabilidades(
	position = game.at(1,1),
	image = "menu/MenuBase.png",
	area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3)
)

class MenuHabilidades inherits Menu {
	override method itemsActuales() = turno.heroeActivo().habilidades()
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

object izquierda inherits Lugar(proximoX = -3, proximoY = 0) { 
	method mover(x){
		return x.left(3)
	}
}

object derecha inherits Lugar(proximoX = 3, proximoY = 0) { 
	method mover(x){
		return x.right(3)
	}
}