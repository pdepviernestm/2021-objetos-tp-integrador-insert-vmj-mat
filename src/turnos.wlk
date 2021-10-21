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
	
	method agregarAccion(accion) {
		const movimiento = new Movimiento(habilidad = accion, origen = heroeActivo, destino = enemigos.head())
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

object turno {
	
	var property accionLadron = null
	var property accionClerigo = null
	var property accionEnemigo = ataqueFisico
	
	var property personajeActual = ladron

	method actualizar() {								// cuando se actualiza el turno, el oponente ataca
		menu.removerMenu()
		accionEnemigo = enemigo1.elegirAtaque()
        game.schedule(1000, { => accionLadron.realizar(ladron, enemigo1) })
        game.schedule(3000, { => accionEnemigo.realizar(enemigo1, ladron) })
		game.schedule(5000, { => accionClerigo.realizar(clerigo, enemigo1) })
        game.schedule(6000, { => menuBase.activarMenu() })
	}
	
	method comenzarTurno() {
		if(!personajeActual.estaMuerto()) {
            if (game.hasVisual(ataque)) menuBase.seleccionarOpcion(game.uniqueCollider(punteroBase), personajeActual)
			if (personajeActual == clerigo) {
				personajeActual = ladron
				self.actualizar()
			}
			else personajeActual = clerigo
	    } 
    } 
	
}