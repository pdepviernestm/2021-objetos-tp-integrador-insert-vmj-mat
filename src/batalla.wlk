import wollok.game.*
import menu.*
import personaje.*
import enemigo.*
import pantallaInicio.*
import ataques.*
import elementos.*
import turnos.*
import mapa.*

class NombreBatalla {
	const property text 
	const property position 
	var property textColor = "ffffff"
		
	method inhabilitar() {
		textColor = "9b9b9b"
	}
	
}

class Batalla {
    const property heroes = []
    const enemigos = []
    const property estadisticas
    const property image //= "background/fondo1.jpeg"
    const property position = game.origin()
   const property menuAliados
    const property menuEnemigos
    var property menuActivo = menuEnemigos
    
    const property proximaAccion

    method iniciar() {
    	game.addVisual(self)
    	turno.batalla(self)
    	turno.enemigos(enemigos)
    	turno.heroes(heroes)
    	turno.heroeActivo(heroes.head())
        heroes.forEach{ heroe => heroe.agregarPersonaje() }
        enemigos.forEach{ enemigo => enemigo.agregarPersonaje() }
        //menuEnemigos.items(enemigos)
    	//menuHeroes.items(heroes)
        menuBase.display()
        estadisticas.display()
    }
}

const batallaFacil = new Batalla(
    heroes = [ladron, clerigo],
    enemigos = [flan, cactrot], 
    image = "background/fondo2.jpeg",
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1),  items = [ladron, clerigo]),
    menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [ladron, clerigo] ),
   menuEnemigos= new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [flan, cactrot]),
    proximaAccion = { => batallaDificil.iniciar() }
)//rango = [[13,16],[2,4]]rango = [[3,5],[1,2,3]]

const batallaDificil = new Batalla (
    heroes = [poseidon, hercules],
    enemigos = [tomberi, duende], 
    image = "background/bosque.png", 
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1), items = [poseidon, hercules]),
	menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [poseidon, hercules]),
    proximaAccion = { => pantallaInicio.iniciar() },
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [tomberi, duende])
    
)


const llanura = new Batalla(
	// nombre = new NombreBatalla(text = "Llanura inmutable", position = game.at(0,0)),
    heroes = [ladron, clerigo],
    enemigos = [flan, cactrot], 
    image = "background/fondo1.jpeg",
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1),  items = [ladron, clerigo]),
    menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [ladron, clerigo]),
    proximaAccion = { => batallaDificil.iniciar() },
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [flan, cactrot])
    
)

const Bosque = new Batalla (
	// nombre = new NombreBatalla(text = "Bosque del Paradigma Misterioso", position = game.at(0,0)),	
    heroes = [poseidon, hercules],
    enemigos = [tomberi, duende], 
    image = "background/fondo1.jpeg", 
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1),/*image = "menu/FondoStats.png", */ items = [poseidon, hercules]),
	menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [poseidon, hercules]),
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [tomberi, duende]),
    proximaAccion = { => pantallaInicio.iniciar() }
)
