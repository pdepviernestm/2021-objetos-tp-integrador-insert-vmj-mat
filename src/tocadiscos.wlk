import wollok.game.*

object tocadiscos {
	const musicaCreditos = game.sound("assets/music/creditos_musica.mp3")
	
    method tocar(ruta) {
        const sonido = game.sound(ruta)
        sonido.play()
    }
    
    method tocarCreditos() {
    	musicaCreditos.play()
    }
    
    method detenerCreditos() {
    	musicaCreditos.stop()
    }
}

const sonidoComenzar = "assets/music/mixkit-ominous-drums-227.wav"
const sonidoPunio = "assets/music/mixkit-hard-and-quick-punch-2143.wav"
const sonidoMagia = "assets/music/mixkit-light-spell-873.wav"
const sonidoFondo = "assets/music/mixkit-medieval-show-fanfare-announcement-226.wav"
const sonidoGanar = "assets/music/mixkit-animated-small-group-applause-523.wav"
const sonidoPerder = "assets/music/mixkit-negative-answer-lose-2032.wav"