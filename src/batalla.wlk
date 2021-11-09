import wollok.game.*
import menu.*
import personaje.*
import enemigo.*
import pantallaInicio.*
import ataques.*
import elementos.*
import turnos.*
import mapa.*
import paleta.*

class NombreBatalla {
	const property image = "menu/espadita.gif"
	const property text 
	const property position 
	var property textColor = "ffffff"
		
	method inhabilitar() {
		textColor = paleta.gris()
	}
	
}

class Batalla {
	const property nombre
    const property heroes = []
    const enemigos = []
    const property estadisticas
    const property image //= "background/fondo1.jpeg"
    const property position = game.origin()
    const property menuAliados
    const property menuEnemigos
    var property menuActivo = menuEnemigos
    
    const property proximaAccion
	
	method inhabilitarAliados(){
		menuAliados.inhabilitarOpciones()
	}
	method inhabilitarEnemigos(){
		menuEnemigos.inhabilitarOpciones()
	}
	
	method removerMenuActivo(){
		menuActivo.removerse()
	}
	method removerEstadisticas(){
		estadisticas.removerse()
	}
	
    method iniciar() {
    	game.addVisual(self)
    	turno.batalla(self)
    	turno.enemigos(enemigos)
    	turno.heroes(heroes)
    	turno.heroeActivo(heroes.head())
        turno.heroeActivo().cambiarColor(paleta.verde())
        turno.heroes().drop(1).forEach{ heroe => heroe.cambiarColor(paleta.blanco()) }
        // para que al volver a empezar una batalla no quede otro resaltado
        self.agregarHeroes()
        self.agregarEnemigos()
		turno.rutina([])
		// si no se reinicia la rutina, la próxima vez que se ejecuta la batalla quedan acciones de más
        menuBase.display()
        estadisticas.display()
    }

    method agregarHeroes() {
        var x = 15
        var y = 10
        heroes.forEach{ heroe => 
        	heroe.comenzarBatalla()
            heroe.posicionar(game.at(x, y))
            heroe.agregarPersonaje()
            if (x == 15) {
                x++
                y--
            }
            else {
                x--
                y -= 2
            }
        }
    }

    method agregarEnemigos() {
    	enemigos.forEach{ enemigo => enemigo.comenzarBatalla() }
        if (enemigos.size() < 3) {
            var x = 7 - enemigos.size()
            var y = 7 + enemigos.size()
            enemigos.forEach{ enemigo =>
                enemigo.posicionar(game.at(x, y))
                enemigo.agregarPersonaje()
                y -= 2
                x += 3
            }
        }
        else {
            var x = 5
            var y = 9
            enemigos.forEach{ enemigo => 
                enemigo.posicionar(game.at(x, y))
                enemigo.agregarPersonaje()
                y -= 1
                if (x == 5) x -= 3
                else x += 3
            }
        }
    }
}

const batallaFacil = new Batalla(
	nombre = new NombreBatalla(text = "Batalla Facil", position = game.at(5,7)),
    heroes = heroesBatallaFacil,
    enemigos = enemigosBatallaFacil, 
    image = "background/fondo2.jpeg",
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2, ancho = 4, distanciaY = 2), position = game.at(10,1), items = heroesBatallaFacil),
    menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3), position = game.at(1,1), image = "menu/MenuBase.png", items = heroesBatallaFacil ),
    menuEnemigos= new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3), position = game.at(1,1), image = "menu/MenuBase.png", items = enemigosBatallaFacil),
    proximaAccion = { => batallaDificil.iniciar() }
)

const heroesBatallaFacil = [ladron, clerigo]
const enemigosBatallaFacil = [flan, cactrot]

const batallaDificil = new Batalla (
	nombre = new NombreBatalla(text = "Batalla dificil", position = game.at(13,3)),
    heroes = heroesBatallaDificil,
    enemigos = enemigosBatallaDificil, 
    image = "background/bosque.png", 
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2, ancho = 4,distanciaY=2),position = game.at(10,1), items = heroesBatallaDificil),
	menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3), position = game.at(1,1),image = "menu/MenuBase.png", items = heroesBatallaDificil),
    proximaAccion = { => pantallaInicio.iniciar() },
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2, ancho = 3), position = game.at(1,1),image = "menu/MenuBase.png", items = enemigosBatallaDificil)
)

const heroesBatallaDificil = [poseidon, hercules]
const enemigosBatallaDificil = [duende, tomberi]

const llanura = new Batalla(
	nombre = new NombreBatalla(text = "Llanura inmutable", position = game.at(0,0)),
    heroes = [ladron, clerigo],
    enemigos = [flan, cactrot], 
    image = "background/fondo1.jpeg",
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1),  items = [ladron, clerigo]),
    menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [ladron, clerigo]),
    proximaAccion = { => batallaDificil.iniciar() },
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1), image = "menu/MenuBase.png", items = [flan, cactrot])
    
)

const Bosque = new Batalla (
	nombre = new NombreBatalla(text = "Bosque del Paradigma Misterioso", position = game.at(0,0)),	
    heroes = [poseidon, hercules],
    enemigos = [tomberi, duende], 
    image = "background/fondo1.jpeg", 
    estadisticas = new Estadisticas (area = new AreaMenu(inicio = game.at(13,2), alto = 2,ancho = 4,distanciaY=2),position = game.at(10,1),/*image = "menu/FondoStats.png", */ items = [poseidon, hercules]),
	menuAliados = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [poseidon, hercules]),
    menuEnemigos = new Objetivos (area = new AreaMenu(inicio = game.at(3,1), alto = 2,ancho = 3),position = game.at(1,1),image = "menu/MenuBase.png", items = [tomberi, duende]),
    proximaAccion = { => pantallaInicio.iniciar() }
)
