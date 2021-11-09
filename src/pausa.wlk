import wollok.game.*
import menu.*
import elementos.*
import turnos.*
import paleta.*
import pantallaInicio.*

const punteroPausa = new Puntero(posicionInicial = game.at(7, 7))

object pausa {
	var punteroPrevio
	method pausar() {
		if(!game.hasVisual(menuPausa)) {
			punteroPrevio = modo.puntero()
			modo.puntero(punteroPausa)
			menuPausa.display()
		}
	}
	
	method reanudar() {
		menuPausa.removerse()
		modo.puntero(punteroPrevio)
	}
}

const menuPausa = new Menu(image = "menu/menuBase.png", position = game.at(5, 5), items = [reanudar, volverAlInicio])

object reanudar {
	method text() = "Reanudar"
	method textColor() = paleta.blanco()
	method position() = game.at(7, 7)
	method pulsar() { pausa.reanudar() }
}

object volverAlInicio {
	method text() = "Volver al inicio"
	method textColor() = paleta.blanco()
	method position() = game.at(7, 8)
	method pulsar() { 
		menuPausa.removerse()
		turno.terminarBatalla()
		if (!turno.seEstaEjecutando()) {
			if (game.hasVisual(menuBase))
				menuBase.removerse()
			if (game.hasVisual(turno.batalla().menuActivo())) 
				turno.batalla().menuActivo().removerse()
		}
		else turno.abortarRutina()
		pantallaInicio.iniciar()
	}
}