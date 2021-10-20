import wollok.game.*
import menu.*
import batalla.*

object pantallaInicio {
    const opciones = [opcionBatallaFacil]

    method iniciar() {
        opciones.forEach{ opcion => game.addVisual(opcion) }
        game.addVisual(punteroInicio)
    }
}

class Opcion {
    const destino
    const nombre
    const property position

    method realizar() {
        destino.iniciar()
    }

    method text() = nombre
    method textColor() = "ffffff"
}

const opcionBatallaFacil = new Opcion(
    destino = batallaFacil,
    nombre = "Batalla fácil",
    position = game.at(5, 5)
)

const opcionBatallaDificil = new Opcion(
    destino = batallaFacil,
    nombre = "Batalla difícil",
    position = game.at(5, 6)
)

const punteroInicio = new Puntero(posicionInicial = game.at(5, 5))