import wollok.game.*
import enemigo.*
import menu.*
import personaje.*
import ataques.*

object turno {
	
	var property accionElegida
	var property accionEnemigo = ataqueFisico
	
	method actualizar() {								// cuando se actualiza el turno, el oponente ataca
		menu.removerMenu()
        // game.schedule(1000, { => personaje.realizarAccion()})
        game.schedule(1000, { => accionElegida.realizar(personaje, enemigo)})
        // game.schedule(3000, { => enemigo.atacar(personaje)})
        game.schedule(3000, { => accionEnemigo.realizar(enemigo, personaje)})
        game.schedule(4000, { => menu.activarMenu()})		// ya se que quedo feo pero es una idea de como haria para que ataque un toque despues
		
	}
	
	method comenzarTurno() {
        //menu.activarMenu()	//lo comente porque ya esta activado el menu y tiraba un mensaje
		if(!personaje.estaMuerto()) {
            if(game.hasVisual(ataque)) menu.menuActivo().seleccionarOpcion(game.uniqueCollider(puntero))
            self.actualizar()  
	    }
    }
}