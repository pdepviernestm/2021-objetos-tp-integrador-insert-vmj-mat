import wollok.game.*
import menu.*
import personaje.*
import enemigo.*
import pantallaInicio.*
import ataques.*
import elementos.*

const menuBase = new Menu (position = game.at(2,1),image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.png", items = [curacion,ataqueFisico,ataqueMagico])
//const estadisticas = new Estadisticas (position = game.at(10,1),image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", items = [ladron,clerigo])

class Batalla {
    const heroes = []
    const enemigos = []
    const estadisticas
    const fondo = "background/fondo1.jpeg"
    
    
    method iniciar() {
    	game.removeVisual(punteroInicio)
    	
        heroes.forEach{ heroe => game.addVisual(heroe) }
        enemigos.forEach{ enemigo => game.addVisual(enemigo) }
        game.boardGround(fondo)
        menuBase.display(punteroBase)
        modo.puntero(punteroBase)
        estadisticas.display()
    }
}

const batallaFacil = new Batalla(
    heroes = [ladron, clerigo],
    enemigos = [enemigo2, enemigo1], // cambiar
    fondo = "background/fondo1.jpeg",
    estadisticas = new Estadisticas (position = game.at(10,1),image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", items = [ladron,clerigo])
    
    )

const batallaDificil = new Batalla (
    heroes = [poseidon, hercules],
    enemigos = [enemigo3, enemigo4], // cambiar
    fondo = "background/fondo1.jpeg", // cambiar
    estadisticas = new Estadisticas (position = game.at(10,1),image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", items = [poseidon, hercules])
    
)