import wollok.game.*
import menu.*
import batalla.*
import elementos.*

object pantallaInicio {
    const property opciones = [opcionBatallaFacil, opcionBatallaDificil]

    method iniciar() {
        opciones.forEach{ opcion => game.addVisual(opcion) }
        game.addVisual(punteroInicio)
    }
}

class Opcion {
    const destino
    const nombre
    const property position

    method pulsar() {
        destino.iniciar()
    }

    method text() = nombre
    method textColor() = "000000"
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

