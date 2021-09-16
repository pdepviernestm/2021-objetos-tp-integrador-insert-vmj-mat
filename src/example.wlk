import wollok.game.*


object personaje {
	var property image = "Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png"
	const property position = game.at(5, 5)
	var property objetivo = enemigo		// en el caso de que haya mas enemigos puedo elegir cual, o si quiero curar un companiero tambien
	var property turno = true			// si le toca 
	
	var hp = 100
	const property fuerza = 20 // ataque fisico
	const property vigor = 30 // defensa fisica
	const property intelecto = 25 // ataque magico
	const property mente = 20 // defensa magica

	method image() {					// para que se quede muerto
		if (self.estaMuerto()) 
			return "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
		else return image }
	
	method estaMuerto(){
		return if (hp <= 0) true else false
	}
	
	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		image = "Bandits/Sprites/Heavy_Bandit/Attack/HeavyBandit_Attack_0.png"
		//game.onTick(1000, "atacando", { => personaje.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png")})
		//game.removeTickEvent("atacando")
		game.schedule(1000, { => personaje.image("Bandits/Sprites/Heavy_Bandit/Idle/HeavyBandit_Idle_0.png")})
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		/*if (hp <= 0) {
			hp = 0
			image = "Bandits/Sprites/Heavy_Bandit/Death/HeavyBandit_Death_0.png"
			}*/
		if (game.hasVisual(personaje)) game.say(personaje, "Mi vida ahora es " + personaje.hp().toString())
	}

	method hp() = hp
}

object enemigo {
	const property image = "enemigos/Cactrot.gif"
	var property position = game.at(2, 5)

	var hp = 100
	const fuerza = 50 // ataque fisico
	const vigor = 15 // defensa fisica
	const intelecto = 20 // ataque magico
	const mente = 15 // defensa magica
	
	method atacar(alguien) {
		var ataque = fuerza // + daño del arma + elemento (posible) + etc etc
		self.position(game.at(3,5))
		game.schedule(1000, { => self.position(game.at(2,5))})
		alguien.recibirAtaque(ataque)
	}
	
	method recibirAtaque(ataque) {
		hp -= (ataque - vigor).max(0) // + resistencia de la armadura + resistencia elemental (posible) + etc etc
		if (hp <= 0) game.removeVisual(self)
		if (game.hasVisual(enemigo)) game.say(enemigo, "Mi vida ahora es " + enemigo.hp().toString())
		
	}

	method hp() = hp
}

object turno {
	
	method actualizar(){ 										// cuando se actualiza el turno, el oponente ataca
		game.schedule(1000, { =>enemigo.atacar(personaje)})		// ya se que quedo feo pero es una idea de como haria para que ataque un toque despues
		personaje.turno(true)
		//if (game.hasVisual(personaje)) game.say(personaje, "Mi vida ahora es " + personaje.hp().toString())
		//if (game.hasVisual(enemigo)) game.say(enemigo, "Mi vida ahora es " + enemigo.hp().toString())
		
	}
	
	method comenzarTurno(){
		if(personaje.turno() && ! personaje.estaMuerto()) {
		personaje.turno(false)
		menu.menuActivo().seleccionarOpcion(game.uniqueCollider(puntero))
		turno.actualizar()
	}
	/* 
	method comenzarTurno(){
		//personaje.atacar(enemigo)
		enemigo.atacar(personaje)
		
		if (game.hasVisual(personaje)) game.say(personaje, "Mi vida ahora es " + personaje.hp().toString())
		if (game.hasVisual(enemigo)) game.say(enemigo, "Mi vida ahora es " + enemigo.hp().toString())
		
	}*/
}
}

object menu {
	var property menuActivo = menuPrincipal
}

object menuPrincipal{
	const atacar = ataque
	//const items
	//const magia
	
	//const enemigo
	
	method display(){
		game.addVisual(ataque)
	}
	
	method elementosHacia(direccion){
		return direccion.lugares()
	}
	method actualizarEn(direccion){
		direccion.restarLugares()
		direccion.opuesto().sumarLugares()
		}
	method seleccionarOpcion(opcion){
		opcion.accion(personaje)
		// turno.actualizar()
	}
}

object menuAtaques{
	
}

object menuItems{
	
}


object ataque {
	const property image = "background/ataque2.png"
	const property position = game.at(1, 3)
	//const property accion = {quienAtaca => if(quienAtaca.turno()) quienAtaca.atacar(quienAtaca.objetivo()) quienAtaca.turno(false)}
	method accion(quienAtaca){
		quienAtaca.atacar(quienAtaca.objetivo()) 
		}
}

// el puntero, que basicamente esta hardcodeado para que se mueva dependiendo de la cantidad de opciones q tiene arriba o abajo

object puntero{
	const posicionInicial = game.at(1,3)
	var position = posicionInicial
	var menuActual = menuPrincipal
	method position() = position
	method image() = "background/cursor3.png"
	
	method volveAlPrincipio() {
		position = posicionInicial
	}
	
	method moverCursor(posicion){
		if (self.sePuedeDesplazarHacia(posicion))
			position = posicion.mover(position)
		else position 
	}
	
	method sePuedeDesplazarHacia(direccion){
		if (menuActual.elementosHacia(direccion) > 0){
			menuActual.actualizarEn(direccion)
			return true	
		}
		else return false
	
	
	
	}



}

object arriba {
	var lugares = 0
	const property opuesto = abajo
	
	
	method lugares() = lugares
	method mover(posicionActual){
		return posicionActual.up(1)
	}
	method restarLugares(){
		lugares -= 1
	}
	method sumarLugares(){
		lugares += 1
	}
}

object abajo {
	var lugares = 2
	const property opuesto = arriba
	
	method lugares() = lugares
	method mover(posicionActual){
		return posicionActual.down(1)
	}
	method restarLugares(){
		lugares -= 1
	}
	method sumarLugares(){
		lugares += 1
	}
}

object background {
	method image() = "background/fondo.jpeg"
}



