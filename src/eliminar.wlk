object abc {
	
	
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
		if (quienAtaca == ladron) turno.accionLadron(ataqueMagico)
        else if (quienAtaca == clerigo) turno.accionClerigo(ataqueMagico)
        
        
        }
        }
        
        


object menu {
	var property menuActivo = menuPrincipal

    method activarMenu() {
        menuActivo.display()
        game.addVisual(punteroBase)
    }
    
    method removerMenu() {
        game.removeVisual(punteroBase)
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