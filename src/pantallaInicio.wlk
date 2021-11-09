import wollok.game.*
import menu.*
import batalla.*
import mapa.*
import elementos.*
import tocadiscos.*

object pantallaInicio {
    const property opciones = [comenzar]
    
    method iniciar() {
        opciones.forEach{ opcion => game.addVisual(opcion) }
        game.addVisual(punteroInicio)
        modo.puntero(punteroInicio)
    }
}

object comenzar {
    method image() = "menu/comenzar.png"
    method position() = game.at(8,5)
    
    method pulsar() {
        tocadiscos.tocar(sonidoComenzar)
        game.removeVisual(punteroInicio)
    	pantallaInicio.opciones().forEach{ opcion => game.removeVisual(opcion) }  
        mapa.display()
        menuMapa.display()
        tocadiscos.tocar(sonidoFondo)
    }
}