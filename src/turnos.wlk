import wollok.game.*
import enemigo.*
import menu.*
import personaje.*
import ataques.*
import batalla.*

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
            if (game.hasVisual(ataque)) menuBase.seleccionarOpcion(game.uniqueCollider(puntero), personajeActual)
			if (personajeActual == clerigo) {
				personajeActual = ladron
				self.actualizar()
			}
			else personajeActual = clerigo
	    } 
    } 
	
}