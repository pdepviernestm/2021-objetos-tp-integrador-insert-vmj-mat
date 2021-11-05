import wollok.game.*
import menu.*
import batalla.*
import mapa.*
import elementos.*

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
        const opener = game.sound("assets/music/mixkit-ominous-drums-227.wav")
        opener.play()
        game.removeVisual(punteroInicio)
    	pantallaInicio.opciones().forEach{ opcion => game.removeVisual(opcion) }
        menuMapa.display()
    }
}