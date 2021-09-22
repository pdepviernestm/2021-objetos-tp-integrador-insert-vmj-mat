import wollok.game.*
import enemigo.*
import menu.*
import personaje.*
import ataques.*

object turno {
	
	var property accionLadron = null
	var property accionClerigo = null
	var property accionEnemigo = ataqueFisico
	
	var property personajeActual = ladron

	method actualizar() {								// cuando se actualiza el turno, el oponente ataca
		menu.removerMenu()
		accionEnemigo = enemigo.elegirAtaque()
        game.schedule(1000, { => accionLadron.realizar(ladron, enemigo) })
        game.schedule(3000, { => accionEnemigo.realizar(enemigo, ladron) })
		game.schedule(5000, { => accionClerigo.realizar(clerigo, enemigo) })
        game.schedule(6000, { => menu.activarMenu() })
	}
	
	method comenzarTurno() {
		if(!personajeActual.estaMuerto()) {
            if (game.hasVisual(ataque)) menu.menuActivo().seleccionarOpcion(game.uniqueCollider(puntero), personajeActual)
			if (personajeActual == clerigo) {
				personajeActual = ladron
				self.actualizar()
			}
			else personajeActual = clerigo
	    } 
    } 
	
}