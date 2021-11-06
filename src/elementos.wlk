import wollok.game.*
import menu.*
import batalla.*

const punteroInicio = new Puntero(posicionInicial = game.at(8, 5))
 
object modo{
	var property puntero = punteroInicio
	method moverseHacia(lugar){puntero.moverseHacia(lugar)}
	method seleccionar(){puntero.seleccionar()}
	
}