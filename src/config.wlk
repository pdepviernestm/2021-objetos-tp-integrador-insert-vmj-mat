import wollok.game.*
import posiciones.*
import paleta.*
import menu.*

/* Configuraciones generales */

/* DIRECCIONES */
const opcionArriba = new Direccion (lugares = 1,sentido = arriba)
const opcionAbajo = new Direccion(lugares = 1,sentido= abajo)
const opcionDerecha = new Direccion(lugares = 3,sentido= derecha)
const opcionIzquierda = new Direccion(lugares = 3,sentido= izquierda)
const posicionDeIconos = new Direccion(lugares = 2,sentido= izquierda)
const posicionEnemigos = new Diagonal(lugares = 1,sentido = menor,opuesto = mayor)
const posicionHeroes = new Diagonal(lugares = 1,sentido = mayor,opuesto = menor)

/* POSICIONES */
const posicionLlanura = game.at(5,7)
const posicionBosque = game.at(13,3)
const posicionDesierto = game.at(13,6)
const posicionAbismo = game.at(12,12)
const posicionComenzar = game.at(8,5)

/* COLORES */
const colorHabilitado = paleta.blanco()
const colorInhabilitado = paleta.gris()
const colorPersonajeActual = paleta.verde()

/* INTERFAZ */
const radioEnemigos = game.at(3,9)
const radioHeroes= game.at(15,9)
const areaEnemigosPorDefecto = new AreaMenu(inicio = radioEnemigos,distanciaX = 2,distanciaY = 1, alto = 10,ancho = 15)
const areaHeroesPorDefecto = new AreaMenu(inicio = radioHeroes,distanciaX = 2,distanciaY = 1, alto = 10,ancho = 15)



