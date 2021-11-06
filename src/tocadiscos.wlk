import wollok.game.*

object tocadiscos {
    method tocar(ruta) {
        const sonido = game.sound(ruta)
        sonido.play()
    }
}

const sonidoComenzar = "assets/music/mixkit-ominous-drums-227.wav"
const sonidoPunio = "assets/music/mixkit-hard-and-quick-punch-2143.wav"
const sonidoMagia = "assets/music/mixkit-light-spell-873.wav"