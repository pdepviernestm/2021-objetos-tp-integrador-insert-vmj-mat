import wollok.game.*
import menu.*
import batalla.*


const punteroInicio = new Puntero(posicionInicial = game.at(5, 5))
const punteroBase = new Puntero(posicionInicial = game.at(3,3))


object modo{
	var property puntero = punteroInicio
}