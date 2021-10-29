import wollok.game.*
import menu.*
//import aaaa.*
import batalla.*
import mapa.*
import elementos.*
/* object pantallaInicio {
    //const property image = "background/inicio.jpeg"
    const property opciones = [opcionBatallaFacil, opcionBatallaDificil]
    

    method iniciar() {
        opciones.forEach{ opcion => game.addVisual(opcion) }
        game.addVisual(punteroInicio)
        modo.puntero(punteroInicio)
    }
}*/
object pantallaInicio {
    //const property image = "background/inicio.jpeg"
    const property opciones = [comenzar]
    

    method iniciar() {
        opciones.forEach{ opcion => game.addVisual(opcion) }
        game.addVisual(punteroInicio)
        modo.puntero(punteroInicio)
    }
    
    
}
// const opener =game.sound("assets/music/mixkit-ominous-drums-227.wav")
object comenzar{
	//method text() = "comenzar"
   // method textColor() = "ffffff"
   method image() = "menu/comenzar.png"
    method position() = game.at(8,5)
    
    method pulsar() {
        // opener.play()
        game.removeVisual(punteroInicio)
    	pantallaInicio.opciones().forEach{ opcion => game.removeVisual(opcion) }
        menuMapa.display()
    }
}

