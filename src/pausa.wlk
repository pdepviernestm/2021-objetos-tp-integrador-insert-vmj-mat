import wollok.game.*
import menu.*
import turnos.*
import pantallaInicio.*
import mapa.*
import tocadiscos.*
import config.*

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

object reanudar {
	var property position = game.origin()
	method text() = "Reanudar"
	method textColor() = colorHabilitado
	method pulsar() { pausa.reanudar() }
}

class VolverAOpcion{
	var property position = game.origin()
	method text() 
	method textColor() = colorHabilitado
	method pulsar() { 
		tocadiscos.detenerfondo()
		menuPausa.removerse()
		turno.terminarBatalla()
		if (game.hasVisual(menuBase))
			menuBase.removerse()
		if (game.hasVisual(turno.batalla().menuActivo())) 
			turno.batalla().menuActivo().removerse()
	}
}

object volverAlInicio inherits VolverAOpcion{
	override method text() = "Volver al inicio"
	override method pulsar() { 
		super()
		pantallaInicio.iniciar()
	}
}

object volverAlMapa inherits VolverAOpcion{
	override method text() = "Volver al mapa"
	override method pulsar() {
		super()
		mapa.display()
		menuMapa.display()
	}
}

/* ELEMENTOS */ 
const menuPausa = new Menu(image = "menu/menuBase.png", area = new AreaMenu(inicio = game.at(8, 5), alto = 2, ancho = 1), position = game.at(5, 5), items = [reanudar, volverAlInicio, volverAlMapa])
