import wollok.game.*
import menu.*
import elementos.*
import turnos.*
import paleta.*
import pantallaInicio.*


object pausa {
	var punteroPrevio
	method pausar() {
		if(not game.hasVisual(menuPausa) and turno.batalla().enCurso()) {
			punteroPrevio = modo.puntero()
			modo.puntero(menuPausa.puntero())
			menuPausa.display()
		}
	}
	
	method reanudar() {
		menuPausa.removerse()
		modo.puntero(punteroPrevio)
	}
}

const menuPausa = new Menu(image = "menu/menuBase.png",area = new AreaMenu(inicio = game.at(8,6), alto = 2,ancho = 1), position = game.at(5, 5), items = [reanudar, volverAlInicio])

object reanudar {
	var property position 
	method text() = "Reanudar"
	method textColor() = paleta.blanco()
	method pulsar() { pausa.reanudar() }
}

object volverAlInicio {
	var property position 
	method text() = "Volver al inicio"
	method textColor() = paleta.blanco()
	method pulsar() { 
		menuPausa.removerse()
		turno.terminarBatalla()
		if (game.hasVisual(menuBase))
			menuBase.removerse()
		if (game.hasVisual(turno.batalla().menuActivo())) 
			turno.batalla().menuActivo().removerse()
		turno.abortarRutina()
		pantallaInicio.iniciar()
	}
}