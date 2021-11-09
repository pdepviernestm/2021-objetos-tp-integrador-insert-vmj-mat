import wollok.game.*
import enemigo.*
import menu.*
import mapa.*
import personaje.*
import ataques.*
import batalla.*
import elementos.*
import pantallaInicio.*
import paleta.*
import tocadiscos.*
object turno {
	var property rutina = []
	var property batalla
	var property heroeActivo
	var property heroes = []
	var property enemigos = []
	var property proximaAccion

	method ejecutar(){
		batalla.removerMenuActivo()
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

		// game.schedule(1000, {=> rutina.get(0).realizar()})

		game.schedule(1000 + 2000 * cantAcciones, { =>
			if(self.heroesVivos().isEmpty()) {
				tocadiscos.tocar(sonidoPerder)
				self.perder()
			}
			else if(self.enemigosVivos().isEmpty()) {
				tocadiscos.tocar(sonidoGanar)
				self.ganar()
			}

			else {
				heroeActivo.cambiarColor(paleta.blanco())
				heroeActivo = self.heroesVivos().head()
				heroeActivo.cambiarColor(paleta.verde())
				menuBase.display()
				rutina = []
				// se obtiene el primer héroe vivo
				batalla.inhabilitarAliados()
				batalla.inhabilitarEnemigos()
				
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
		batalla.removerEstadisticas()
		game.removeVisual(batalla)
		self.enemigosVivos().forEach({ x => x.eliminarPersonaje() })
		heroes.forEach({ x => x.eliminarPersonaje() })
	}
	method heroesMuertos() = heroes.filter{h=>h.estaMuerto()}
	method heroesVivos() = heroes.filter({ heroe => !heroe.estaMuerto() })

	method enemigosVivos() = enemigos.filter({ enemigo => !enemigo.estaMuerto() })

	method agregarAccion(accion, enemigoAtacante, heroeAtacado) {
		const movimiento = new Movimiento(habilidad = accion, origen = enemigoAtacante, destino = heroeAtacado)
		rutina.add(movimiento)
	}

	method proximaAccion(accion) {
		proximaAccion = accion
		menuBase.removerse()
		accion.objetivosPosibles(batalla)
		batalla.menuActivo().display()
	}

	method agregarAccion(objetivo) {
		const movimiento = new Movimiento(habilidad = proximaAccion, origen = heroeActivo, destino = objetivo)

		rutina.add(movimiento)
		if (heroeActivo == self.heroesVivos().last()) self.ejecutar()
		else {
			const indiceActual = self.encontrarActual()
			heroeActivo.cambiarColor("FFFFFFFF")
			heroeActivo = self.siguienteVivo(indiceActual) // ahora heroeActivo es el próximo héroe vivo
			heroeActivo.cambiarColor("00FF00FF") // meter un object de colores
			batalla.menuActivo().removerse()
			menuBase.display()
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
		if((not destino.estaMuerto()) or habilidad == lazaro) habilidad.realizar(origen, destino)
	}
}