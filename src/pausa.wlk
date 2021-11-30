import wollok.game.*
import menu.*
import turnos.*
import paleta.*
import pantallaInicio.*
import mapa.*
import tocadiscos.*

object pausa {
	var property pausaHabilitada = false
	var punteroPrevio
	method pausar() {
		if(not game.hasVisual(menuPausa) and pausaHabilitada) {
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

const menuPausa = new Menu(image = "menu/menuBase.png", area = new AreaMenu(inicio = game.at(8, 5), alto = 2, ancho = 1), position = game.at(5, 5), items = [reanudar, volverAlInicio, volverAlMapa])

object reanudar {
	var property position 
	method text() = "Reanudar"
	method textColor() = paleta.blanco()
	method pulsar() { pausa.reanudar() }
}

class VolverAOpcion{
	var property position = game.origin()
	method text() 
	method textColor() = paleta.blanco()
	method pulsar() { 
		tocadiscos.detenerfondo()
		menuPausa.removerse()
		turno.terminarBatalla()
		if (game.hasVisual(menuBase))
			menuBase.removerse()
		if (game.hasVisual(turno.batalla().menuActivo())) 
			turno.batalla().menuActivo().removerse()
		turno.abortarRutina()
	}
}

object volverAlInicio inherits VolverAOpcion{
	method text() = "Volver al inicio"
	override method pulsar() { 
		super()
		pantallaInicio.iniciar()
	}
}

object volverAlMapa inherits VolverAOpcion{
	method text() = "Volver al mapa"
	override method pulsar() {
		super()
		mapa.display()
		menuMapa.display()
	}
}