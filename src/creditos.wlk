import wollok.game.*
import pantallaInicio.*
import tocadiscos.*

object creditos {
	var property image = "assets/menu/creditos_imagen.png"
	const property position = game.origin()
	method mostrar() {
		game.addVisual(self)
		tocadiscos.tocarCreditos()
	}
	
	method volver() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
			tocadiscos.detenerCreditos()
			pantallaInicio.iniciar()
		}
	}
}
