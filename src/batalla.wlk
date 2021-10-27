import wollok.game.*
import menu.*
import personaje.*
import enemigo.*
import pantallaInicio.*
import ataques.*
import elementos.*
import turnos.*


class Batalla {
    const property heroes = []
    const enemigos = []
    const property estadisticas
    const property fondo = "background/fondo1.jpeg"
    const property menuObjetivo
    
    const property proximaAccion

    method iniciar() {
    	turno.batalla(self)
    	turno.enemigos(enemigos)
    	turno.heroes(heroes)
    	turno.heroeActivo(heroes.head())
    	
        heroes.forEach{ heroe => game.addVisual(heroe.atributos()) }
        enemigos.forEach{ enemigo => game.addVisual(enemigo.atributos()) }
        menuBase.display(punteroBase)
        modo.puntero(punteroBase)
        estadisticas.display()
    }
}

const batallaFacil = new Batalla(
    heroes = [ladron, clerigo],
    enemigos = [flan, cactrot], 
    fondo = "background/fondo1.jpeg",
    estadisticas = new Estadisticas (position = game.at(10,1), image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", items = [ladron, clerigo]),
    menuObjetivo = new Objetivos (position = game.at(1,1), image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.1.png", items = [ladron, clerigo] + [flan, cactrot]),
    proximaAccion = { => batallaDificil.iniciar() }
)

const batallaDificil = new Batalla (
    heroes = [poseidon, hercules],
    enemigos = [tomberi, duende], 
    fondo = "background/fondo1.jpeg", 
    estadisticas = new Estadisticas (position = game.at(10,1),image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy (2).png", items = [poseidon, hercules]),
	menuObjetivo = new Objetivos (position = game.at(1,1), image = "menu/Game Boy Advance - Final Fantasy 1 Dawn of Souls - Font and Menu - Copy 3.1.png", items = [poseidon, hercules] + [tomberi, duende]),
    proximaAccion = { => pantallaInicio.iniciar() }
)