import personaje.*
import enemigo.*

object ataqueFisico {
	method realizar(atacante, atacado) {
		const potencia = atacante.fuerza() - atacado.vigor()
		atacante.animarAtaque()
		atacado.reducirHP(potencia)
	}
}

object hechizoFulgor {
	method realizar(atacante, atacado) {
		const potencia = atacante.intelecto() * 3 - atacado.mente()
		atacante.animarAtaque()
		atacado.reducirHP(potencia)
	}
}