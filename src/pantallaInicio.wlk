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
    
    method removerse(){
    	game.removeVisual(punteroInicio)
    	opciones.forEach{ opcion => game.removeVisual(opcion) }
    }
}

object comenzar {
    method image() = "menu/comenzar.png"
    method position() = game.at(8,5)
    method pulsar() {
        tocadiscos.tocar(sonidoComenzar)
    	pantallaInicio.removerse()  
        mapa.display()
        menuMapa.display()
        // para que volver al inicio sea como un reset del juego
        opcionBatallaFacil.habilitar()
        batallaFacil.habilitar()
        opcionBatallaDificil.inhabilitar()
        batallaDificil.inhabilitar()
        opcionBatallaMasDificil.inhabilitar()
        batallaMasDificil.inhabilitar()
        opcionBatallaFinal.inhabilitar()
        batallaFinal.inhabilitar()
        tocadiscos.tocar(sonidoFondo)
    }
}