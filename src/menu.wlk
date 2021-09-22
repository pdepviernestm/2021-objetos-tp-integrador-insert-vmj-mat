import wollok.game.*
import enemigo.*
import personaje.*
import turnos.*
import ataques.*

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

object puntero {

	const posicionInicial = game.at(1,3)
	var position = posicionInicial
	const menuActual = menu.menuActivo()
	method position() = position
	method image() = "background/cursor3.png"
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverCursor(posicion){
		if (self.sePuedeDesplazarHacia(posicion))
			position = posicion.mover(position)
		else position 
	}
	
	method sePuedeDesplazarHacia(direccion){
		if (menuActual.elementosHacia(direccion) > 0){
			menuActual.actualizarEn(direccion)
			return true	
		}
		else return false
	}
    
}

// el puntero, que basicamente esta hardcodeado para que se mueva dependiendo de la cantidad de opciones q tiene arriba o abajo


object arriba {
	var lugares = 0
	const property opuesto = abajo
	
	method lugares() = lugares
	method mover(posicionActual){
		return posicionActual.up(1)
	}
	method restarLugares(){
		lugares -= 1
	}
	method sumarLugares(){
		lugares += 1
	}
}

object abajo {
	var lugares = 2
	const property opuesto = arriba
	
	method lugares() = lugares
	method mover(posicionActual){
		return posicionActual.down(1)
	}
	method restarLugares(){
		lugares -= 1
	}
	method sumarLugares(){
		lugares += 1
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

