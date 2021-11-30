import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*
import batalla.*
import posiciones.*
import config.*

const punteroInicio = new Puntero(posicionInicial = game.at(8, 5))
 
object modo {
	var property puntero = punteroInicio
	method moverseHacia(lugar){ puntero.moverseHacia(lugar) }
	method seleccionar(){ puntero.seleccionar() }
}

class Puntero {
	var property posicionInicial
	var property position = posicionInicial
	method image() = "menu/cursor3.png"
	
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	method moverseHacia(donde){
		if (donde.hayElementos(position)){
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
	const distanciaX = 3
	const distanciaY = 1

	method estaLibre(posicion) = game.getObjectsIn(posicion).isEmpty()
	
	method dentroDeArea(posicion) = self.dentroDeAncho(posicion.x()) and self.dentroDeAlto(posicion.y())
	
	
	method dentroDeAlto(posicion){
		if(posicion.between(0,inicio.y()))
			return posicion.between(inicio.y()-alto,inicio.y())
		else return posicion.between(inicio.y(),inicio.y() + alto)
	}
	
	method dentroDeAncho(posicion){
		if(posicion.between(0,inicio.x()))
			return posicion.between(inicio.x()-ancho,inicio.x())
		else return posicion.between(inicio.x(),inicio.x() + ancho)
	}
	
	
	
	method puedePosicionarse(posicion){
		return self.dentroDeArea(posicion) and self.estaLibre(posicion)
	}
	
	method proximaPosicionLibre(){
	const proximasPosiciones = [proxima.up(distanciaY),proxima.right(distanciaX),proxima.down(distanciaY)]
	return proximasPosiciones.find{posicion => self.puedePosicionarse(posicion)}
}


method siguientePosicionDiagonal(direccion) = direccion.mover(proxima)

method posicionarDiagonal(direccion,items){
	const proximasDirecciones = self.armarDirecciones(direccion,items)
	if (!items.isEmpty()) {
		const proximoItem=items.head()
		if(self.puedePosicionarse(proxima)){
			self.posicionarItem(proximoItem)
			items.remove(proximoItem)
			proximasDirecciones.remove(direccion)
			proxima = self.siguientePosicionDiagonal(proximasDirecciones.head())
			self.posicionarDiagonal(proximasDirecciones.head(),items)
		}
		else self.error("no hay mas posiciones")
	}
}

method armarDirecciones(direccion,items){
	const lista = []
	const direccionOpuesta = direccion.sentidoOpuesto()
		lista.add(direccionOpuesta)
		lista.add(direccion)
		lista.add(direccionOpuesta)
		lista.add(direccion)
	return lista
} 
	method posicionarItems(items){
		proxima = inicio
		items.forEach{ i => if (self.estaLibre(proxima)) self.posicionarItem(i) proxima = self.proximaPosicionLibre()}
	}
	method posicionarItem(i){
		i.position(proxima)
	}
}

 
class Interfaz {
	var property items = []
	const area = new AreaMenu(inicio = game.at(0,0),alto=0,ancho=0)
	
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
	var property personajes = items
	
	override method itemsActuales() = personajes.map{p => p.icono()}
	override method posicionarItems(){
		super()
		self.agregarVida()
	}
	method agregarVida(){
		personajes.forEach{ p => p.vida().position(posicionDeIconos.mover(p.icono().position()))
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
	var property puntero = new Puntero (posicionInicial = game.at(0,0))
	
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

/* Menues */
const estadisticas = new Estadisticas (
	area = new AreaMenu(inicio = game.at(13,1),
						alto = 2, ancho = 4, distanciaY = 2), 
	position = game.at(10,0), 
	items = [])

const menuBase =  new MenuHabilidades(
	position = game.at(1,0),
	image = "menu/MenuBase.png",
	area = new AreaMenu(inicio = game.at(3,0), alto = 2, ancho = 3)
)
const menuHeroes = new Objetivos (
	area = new AreaMenu(inicio = game.at(3,0),
						alto = 2, ancho = 3),
	position = game.at(1,0),
	image = "menu/MenuBase.png", 
	items = new List()
)
const menuEnemigos = new Objetivos (
	area = new AreaMenu(inicio = game.at(3,0),
						alto = 2, ancho = 3),
	position = game.at(1,0),
	image = "menu/MenuBase.png", 
	items = new List()
)
const menuBase2 = new MenuHabilidades(
	position = game.at(1,1),
	image = "menu/MenuBase.png",
	area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3)
)
class MenuHabilidades inherits Menu {
	override method itemsActuales() = turno.heroeActivo().habilidades()
}

