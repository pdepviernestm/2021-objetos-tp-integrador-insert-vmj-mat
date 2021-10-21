import wollok.game.*
import enemigo.*
import menu.*
import personaje.*
import ataques.*
import batalla.*
import elementos.*

object turno1 {
	var property rutina = []
	var property batalla
	var property heroeActivo
	var property heroes = []
	var property enemigos = []
	var property objetivoTurno
	
	method ejecutar(){
		menuBase.removerMenu(punteroBase)
		
		enemigos.forEach({ enemigo => self.agregarAccion(enemigo.elegirAtaque()) })
		
		const cantAcciones = rutina.size()
		(0 .. cantAcciones - 1).forEach{ x => 
			game.schedule(1000 + 2000 * x, { => rutina.get(x).realizar() })
		}
		// esto significa: por cada elemento de la lista, se hace que realice la acción
		// con 2 seg de diferencia entre cada una; rutina.get(x) es la acción en el índice "x", 
		// y se envía un mensaje a ella para que se realice (fue instanciada al agregarla)
		
		game.schedule(1000 + 2000 * cantAcciones, { => menuBase.display(punteroBase) })
	}
	
	method agregarObjetivoPara(accion){
		if (accion.rol() != objetivoTurno.rol() ){
			self.agregarAccion(accion)
		}
		else{
			batalla.menuObjetivo().removerMenu(punteroObjetivo)
			menuBase.display(punteroBase)
		}
		
	}
	
	
	method agregarAccion(accion) {
		if(game.hasVisual(menuBase)){
			menuBase.removerMenu(punteroBase)
			batalla.menuObjetivo().display(punteroObjetivo)
		}
		
		const movimiento = new Movimiento(habilidad = accion.tipoHabilidad(), origen = heroeActivo, destino = objetivoTurno)
		// hay que dejar que el héroe elija el enemigo
		
		rutina.add(movimiento)
		if (heroeActivo == heroes.last()) self.ejecutar()
		else {
			const indiceActual = self.encontrarActual()
			heroeActivo = heroes.get(indiceActual + 1)
		}
	}
	
	method encontrarActual() {
		const cantHeroes = heroes.size()
		var indiceActual
		(0 .. cantHeroes - 1).forEach{ x => 
			if(heroes.get(x) == heroeActivo) indiceActual = x
		}
		return indiceActual
	}
}

class Movimiento {
	var habilidad
	var origen
	var destino
	
	method realizar() {
		habilidad.realizar(origen, destino)
	}
}

