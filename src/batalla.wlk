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
	var property textColor = paleta.gris()
		
	method inhabilitar() {
		textColor = paleta.gris()
	}
	
	method habilitar() {
		textColor = paleta.blanco()
	}
}



class Batalla {
	var property enCurso = false
	const property nombre
    const property heroes = []
    const enemigos = []
    const property image
    const property position = game.origin()
    var property menuActivo = menuEnemigos
    
    const property proximaAccion
    
    method habilitar() {
    	nombre.habilitar()
    }
    
    method inhabilitar() {
    	nombre.inhabilitar()
    }
	
	method inhabilitarAliados(){
		menuHeroes.inhabilitarOpciones()
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
        menuHeroes.items(heroes)
		menuEnemigos.items(enemigos)
		estadisticas.items(heroes)
		estadisticas.personajes(heroes)
        self.agregar(enemigos, izquierda)
        self.agregar(heroes, derecha)
		turno.rutina([])
		// si no se reinicia la rutina, la próxima vez que se ejecuta la batalla quedan acciones de más
		menuHeroes.items(heroes)
		menuEnemigos.items(enemigos)
		estadisticas.items(heroes)
        menuBase.display()
        estadisticas.display()
        enCurso = true
    }

	method agregar(personajes, donde) {
		var x = donde.posPersonaje().x()  
	   	var y = donde.posPersonaje().y()
	   	var indicador = true 
	   	if (personajes.size() < 3){
	   		x -= personajes.size()
	   		y += personajes.size() -1 
	   		indicador = true}
	   	else indicador = false
	   	personajes.forEach{ p =>
		   	p.comenzarBatalla()
		   	p.posicionar(game.at(x, y))
		   	p.agregarPersonaje()
		   	if (indicador){
		   		y -= 2
		        x += 3
		    }
		    else {
		    	y -= 1
		        if (x >= 5 and donde == izquierda or x >= 15 and donde == derecha) x -= 3
		        else x += 3
		    }
	   	}
	}
}

const batallaFinal = new Batalla(nombre = new NombreBatalla(text = "Batalla Final", position = game.at(12,12)),
    heroes = heroesBatallaFinal,
    enemigos = enemigosBatallaFinal, 
    image = "background/batallaFinal.png",
    proximaAccion = { => pantallaInicio.iniciar() }
)

const batallaFacil = new Batalla(
	nombre = new NombreBatalla(text = "Batalla Fácil", position = game.at(5,7)),
    heroes = heroesBatallaFacil,
    enemigos = enemigosBatallaFacil,
    image = "background/fondo2.jpeg",
    proximaAccion = { => 
		mapa.display()
        menuMapa.display()
    	batallaDificil.habilitar()
    	opcionBatallaDificil.habilitar()
    }
)

const heroesBatallaFacil = [ladron, clerigo]
const enemigosBatallaFacil = [flan, cactrot]
const heroesBatallaFinal = heroesBatallaFacil + heroesBatallaDificil
const enemigosBatallaFinal = [jefeFinal, dragoncito, shiva]

const batallaDificil = new Batalla (
	nombre = new NombreBatalla(text = "Batalla difícil", position = game.at(13,3)),
    heroes = heroesBatallaDificil,
    enemigos = enemigosBatallaDificil, 
    image = "background/bosque.png", 
    proximaAccion = { => 
    	mapa.display()
        menuMapa.display()
    	batallaDificil.habilitar()
    	opcionBatallaDificil.habilitar() 
    }
)

const heroesBatallaDificil = [poseidon, hercules]
const enemigosBatallaDificil = [duende, tomberi]

const llanura = new Batalla(
	nombre = new NombreBatalla(text = "Llanura inmutable", position = game.at(0,0)),
    heroes = [ladron, clerigo],
    enemigos = [flan, cactrot], 
    image = "background/fondo1.jpeg",
    proximaAccion = { => batallaFinal.iniciar() }
)

const Bosque = new Batalla (
	nombre = new NombreBatalla(text = "Bosque del Paradigma Misterioso", position = game.at(0,0)),	
    heroes = [poseidon, hercules],
    enemigos = [tomberi, duende], 
    image = "background/fondo1.jpeg", 
    proximaAccion = { => pantallaInicio.iniciar() }
)




