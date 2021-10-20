import wollok.game.*
import menu.*
import personaje.*
import enemigo.*

const menuBase = new Menu (position = game.at(2,1),image = "images/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.png", items = [])

class Batalla {
    const heroes = []
    const enemigos = []
    const fondo = "background/fondo1.jpeg"
    
    const estadisticas = new Estadisticas (position = game.at(10,1),image = "images/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", personajes = heroes, items = [])

    method iniciar() {
        heroes.forEach{ heroe => game.addVisual(heroe) }
        enemigos.forEach{ enemigo => game.addVisual(enemigo) }
        game.boardGround(fondo)
        menuBase.display()
        estadisticas.display()
    }
}

const batallaFacil = new Batalla(
    heroes = [ladron, clerigo],
    enemigos = [enemigo1, enemigo1], // cambiar
    fondo = "background/fondo1.jpeg"
    )

const batallaDificil = new Batalla (
    heroes = [poseidon, hercules],
    enemigos = [enemigo1, enemigo1], // cambiar
    fondo = "background/fondo1.jpeg" // cambiar
)