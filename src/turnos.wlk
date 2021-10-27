import wollok.game.*
import enemigo.*
import menu.*
import personaje.*
import ataques.*
import batalla.*
import elementos.*
import pantallaInicio.*

object turno {
	var property rutina = []
	var property batalla
	var property heroeActivo
	var property heroes = []
	var property enemigos = []
	var proximaAccion
	
	method ejecutar(){
		batalla.menuObjetivo().removerMenu(punteroObjetivo)
		
		self.enemigosVivos().forEach({ enemigo => 
			self.agregarAccion(enemigo.elegirAtaque(), enemigo, enemigo.elegirObjetivo(self.heroesVivos())) 
		})
		
		const cantAcciones = rutina.size()
		(0 .. cantAcciones - 1).forEach{ x => 
			game.schedule(1000 + 2000 * x, { => rutina.get(x).realizar() })
		}
		// esto significa: por cada elemento de la lista, se hace que realice la acción
		// con 2 seg de diferencia entre cada una; rutina.get(x) es la acción en el índice "x", 
		// y se envía un mensaje a ella para que se realice (fue instanciada al agregarla)
		
		game.schedule(1000 + 2000 * cantAcciones, { => 
			if(self.heroesVivos().isEmpty()) {
				self.perder()
			}
			else if(self.enemigosVivos().isEmpty()) {
				self.ganar()
			}
			
			else {
				menuBase.display(punteroBase) 
				rutina = []
				heroeActivo = self.heroesVivos().head() // se obtiene el primer héroe vivo
				batalla.menuObjetivo().inhabilitarOpciones()
			}
		})
	}

	method ganar() {
		self.terminarBatalla()
		batalla.proximaAccion().apply()
	}

	method perder() {
		self.terminarBatalla()
		pantallaInicio.iniciar()
	}

	method terminarBatalla() {
		batalla.estadisticas().removerStats()
		self.enemigosVivos().forEach({ x => x.eliminarPersonaje() })
		self.heroesVivos().forEach({ x => x.eliminarPersonaje() }) 
	} // quizá podríamos usar game.clear()

	method heroesVivos() = heroes.filter({ heroe => !heroe.estaMuerto() })

	method enemigosVivos() = enemigos.filter({ enemigo => !enemigo.estaMuerto() })

	method agregarAccion(accion, enemigoAtacante, heroeAtacado) {
		const movimiento = new Movimiento(habilidad = accion, origen = enemigoAtacante, destino = heroeAtacado)
		rutina.add(movimiento)
	}

	method proximaAccion(accion) {
		proximaAccion = accion
		menuBase.removerMenu(punteroBase)
		batalla.menuObjetivo().display(punteroObjetivo)
	}

	method agregarAccion(objetivo) {
		const movimiento = new Movimiento(habilidad = proximaAccion, origen = heroeActivo, destino = objetivo)
		
		rutina.add(movimiento)
		if (heroeActivo == heroes.last()) self.ejecutar()
		else {
			const indiceActual = self.encontrarActual()
			heroeActivo = self.siguienteVivo(indiceActual) // ahora heroeActivo es el próximo héroe vivo
			if (heroeActivo == null) { // corregir
				self.ejecutar()
			}
			else {
				batalla.menuObjetivo().removerMenu(punteroObjetivo)
				menuBase.display(punteroBase)
			}
		}		
	}

	method cantHeroes() = heroes.size()

	method encontrarActual() {
		var indiceActual
		(0 .. self.cantHeroes() - 1).forEach{ x => 
			if(heroes.get(x) == heroeActivo) indiceActual = x
		}
		return indiceActual
	}

	method siguienteVivo(x) = heroes.drop(x + 1).filter{ heroe => !heroe.estaMuerto() }.head() // chequear el ultimo vivo
}
	

class Movimiento {
	var habilidad
	var origen
	var destino
	
	method realizar() {
		if(destino.estaElPersonaje()) habilidad.realizar(origen, destino)
	}
}