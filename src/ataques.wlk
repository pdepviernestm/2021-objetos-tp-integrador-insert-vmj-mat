import personaje.*
import enemigo.*
import atributos.*

class Ataque {
	var property atributo

	method realizar(atacante, atacado) {
		var potencia

		if (atributo == fisico) {
			potencia = atacante.fuerza() - atacado.vigor()
		}
		else {
			potencia = atacante.intelecto() * 3 - atacado.mente()
		}

		atacante.animarAtaque()
		atacado.reducirHP(potencia)
	}
}

const ataqueFisico = new Ataque(atributo = fisico)
const hechizoFulgor = new Ataque(atributo = magico)


/*
object cura {
	method realizar(curador,curado){
		const potencia = curador.mente() * 0.3 // + curado.hp()
		curado.aumentarHp(potencia)
	}
}
*/




//Con este archivo, podemos modelar muchos ataques y además reutilizarlos.
//Por ejemplo, ambos usan "ataqueFisico" porque es el ataque básico.

/* class Habilidad {
	const property tipo
	const property position 
	const property text
	method  textColor() = "ffffff" 
}

object fisico{
	
}

class Magia{
	
}

object cura{
	
}

const curacion = new Habilidad (tipo = cura, position = game.at(3, 3),text = "Curacion")
const ataqueFisico = new Habilidad (tipo = fisico, position = game.at(3, 2),text = "Ataque Fisico")
const ataqueMagico = new Habilidad (tipo = new Magia(),position = game.at(3, 1),text = "Ataque Magico")*/