import wollok.game.*

object tocadiscos {
	var musicaCreditos 
	var fondo
    method tocar(ruta) {
        const sonido = game.sound(ruta)
        sonido.play()
    }
    
    method tocarFondo(ruta){
    	fondo=game.sound(ruta)
    	fondo.shouldLoop(true)
    	fondo.volume(0.5)
    	fondo.play()
    }
    method tocarCreditos() {
    	musicaCreditos=game.sound(creditos)
    	musicaCreditos.play()
    		
    }
    
     method detenerfondo() {
    	fondo.stop()
    }
    method detenerCreditos() {
    	musicaCreditos.stop()
    }
}
const creditos="assets/music/creditos_musica.mp3"
const finalBattle="assets/music/finalBattle.mp3"
const avanBattle="assets/music/avanBattle.mp3"
const mediaBattle="assets/music/mediaBattle.mp3"
const facilBattle="assets/music/facilBattle.mp3"
const sonidoComenzar = "assets/music/mixkit-ominous-drums-227.wav"
const sonidoPunio = "assets/music/mixkit-hard-and-quick-punch-2143.wav"
const sonidoEspada = "assets/music/mixkit-swift-sword-strike-2166.wav"
const sonidoMagia = "assets/music/mixkit-light-spell-873.wav"
const sonidoFondo = "assets/music/mixkit-medieval-show-fanfare-announcement-226.wav"
const sonidoGanar = "assets/music/mixkit-animated-small-group-applause-523.wav"
const sonidoPerder = "assets/music/mixkit-negative-answer-lose-2032.wav"