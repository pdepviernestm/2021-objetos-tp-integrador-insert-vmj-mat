import wollok.game.*
import menu.*
import personaje.*
import enemigo.*
import pantallaInicio.*
import ataques.*
import turnos.*
import mapa.*
import creditos.*
import tocadiscos.*
import pausa.*
import posiciones.*
import config.*

/* Nombre que aparece en el mapa */

class NombreBatalla {
	const property image = "menu/espadita.gif"
	const property text 
	const property position 
	var property textColor = colorInhabilitado
		
	method inhabilitar() {
		textColor = colorInhabilitado
	}
	
	method habilitar() {
		textColor = colorHabilitado
	}
}

class Batalla {
	var areaEnemigosBatalla = areaEnemigosPorDefecto
	var areaHeroesBatalla = areaHeroesPorDefecto
	const property nombre
    const property heroes = []
    const enemigos = []
    const property image
    const property position = game.origin()
    var property menuActivo = menuEnemigos
    var cancion 
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
    	areaEnemigosBatalla = new AreaMenu(inicio = radioEnemigos,distanciaX = 2,distanciaY = 1, alto = 10,ancho = 15)
    	areaHeroesBatalla = new AreaMenu(inicio = radioHeroes,distanciaX = 2,distanciaY = 1, alto = 10,ancho = 15)
    	game.addVisual(self)
    	turno.iniciar(self,enemigos,heroes)
        menuHeroes.items(heroes)
		menuEnemigos.items(enemigos)
		estadisticas.items(heroes)
		estadisticas.personajes(heroes)
		tocadiscos.tocarFondo(cancion)
        self.agregarABatalla(enemigos, posicionEnemigos,areaEnemigosBatalla)
        self.agregarABatalla(heroes, posicionHeroes,areaHeroesBatalla)
		// si no se reinicia la rutina, la próxima vez que se ejecuta la batalla quedan acciones de más
		menuHeroes.items(heroes)
		menuEnemigos.items(enemigos)
		estadisticas.items(heroes)
        menuBase.display()
        estadisticas.display()
        pausa.pausaHabilitada(true)
    }

	method agregarABatalla(personajes,donde,area){
		area.posicionarDiagonal(donde,personajes.map{p=>p.atributos()})
		personajes.forEach{p => p.comenzarBatalla() p.agregarPersonaje()}
	}


}


/* Batallas */

const batallaFacil = new Batalla(
	nombre = new NombreBatalla(text = "Llanura Perezosa", position = posicionLlanura),
    heroes = heroesBatallaFacil,
    enemigos = enemigosBatallaFacil,
    image = "background/fondo2.jpeg",
    cancion=facilBattle,
    proximaAccion = { => 
    	tocadiscos.detenerfondo()
		mapa.display()
        menuMapa.display()
    	batallaDificil.habilitar()
    	opcionBatallaDificil.habilitar()
    }
)

const batallaDificil = new Batalla (
	nombre = new NombreBatalla(text = "Bosque del Camino Inversible", position = posicionBosque),
    heroes = heroesBatallaDificil,
    enemigos = enemigosBatallaDificil, 
    image = "background/bosque.png", 
    cancion=mediaBattle,
    proximaAccion = { =>
    	tocadiscos.detenerfondo() 
    	mapa.display()
        menuMapa.display()
    	batallaMasDificil.habilitar()
    	opcionBatallaMasDificil.habilitar() 
    } 
)

const batallaMasDificil = new Batalla (
	nombre = new NombreBatalla(text = "Desierto de los Mensajes Perdidos", position = posicionDesierto),
	heroes = heroesBatallaMasDificil,
	enemigos = enemigosBatallaMasDificil,
	image = "background/desierto2.png",
	cancion=avanBattle,
	proximaAccion = { => 
		tocadiscos.detenerfondo()
		mapa.display()
        menuMapa.display()
    	batallaFinal.habilitar()
    	opcionBatallaFinal.habilitar() 
	}
)

const batallaFinal = new Batalla(
	nombre = new NombreBatalla(text = "Abismo del Final", position = posicionAbismo),
    heroes = heroesBatallaFinal,
    enemigos = enemigosBatallaFinal, 
    image = "background/batallaFinal.png",
    cancion= finalBattle,
    proximaAccion = { => 
    	tocadiscos.detenerfondo()
    	creditos.mostrar()
    }
)

/* Personajes por batalla */

const heroesBatallaFacil = [ladron, clerigo]
const enemigosBatallaFacil = [flan, cactrot]
const heroesBatallaDificil = [poseidon, hercules]
const enemigosBatallaDificil = [duende, tomberi]
const heroesBatallaMasDificil = [ladron, clerigo, poseidon]
const enemigosBatallaMasDificil = [tomberi, dragoncito, cactrot]
const heroesBatallaFinal = heroesBatallaFacil + heroesBatallaDificil
const enemigosBatallaFinal = [jefeFinal, dragoncito, shiva]