It's Just a Hug
================

<p align= "center">
	<img src="https://user-images.githubusercontent.com/68023761/91249232-15db1000-e71c-11ea-910e-5a27f9632ae0.png">
</p>

It's Just a Hug es un videoJuego multijugador local para dos jugadores donde cada uno tiene la misión de deshacerse de la bomba, para hacerlo deberá pegársela a su compañero y salir corriendo para no ser atrapado de nuevo. Al comienzo de una ronda un temporizador de 60 segundos empieza a correr, cuando el tiempo acabe el jugador que tenga la bomba en la mano le explotará y su contrincante ganará un punto y pasarán a otro mapa aleatorio.

## Autores
- Juan Sebastian Guerrero
- Sebastián García Angarita

## Descarga e Instalación
### Juego
Descarga la última versión estable de It's Just a Hug [aqui.](https://github.com/Computer-Programming-I-UIS/game-it-s-just-a-hug/releases)

*Requisitos:*
- Instalar [Java](https://www.java.com/es/download/) (Java 8 o superior)

### Código
Para ejecutar el código y/o editarlo es necesario instalar [Processing](https://processing.org/download/) y [Java](https://www.java.com/es/download/) (Java 8 o superior)

Se hace uso de la librería de sonido minim, para poder instalarla siga los siguietes pasos:
- Abra el proyecto en Proccesing
- Sketch/Importar Bibliotecas/Añadir Bibiloteca
- Digite "Minim" en el buscador
- Install

## Capturas de Pantalla
<p align= "center">
  <img src="https://user-images.githubusercontent.com/62948474/92427256-a91b3900-f151-11ea-8463-4ca291a3660f.PNG" width="350"/>
  <img src="https://user-images.githubusercontent.com/62948474/92431235-9a864f00-f15c-11ea-893a-52aaf55b1f22.PNG" width="350"/>

  <img src="https://user-images.githubusercontent.com/62948474/92431038-0e742780-f15c-11ea-99f7-94d171b52932.PNG" width="350"/>
</p>

## Características Principales :heavy_check_mark:
### Multijugador local
It's Just a Hug es un juego de dos jugadores, ambos jugadores se mueven usando el teclado:
- Jugador Azul: Teclas W, A y D
- Jugador Rojo: Teclas de dirección Arriba, Izquierda y Derecha

*Nota:* Para moverse por los menús, use el mouse y para regresar use la tecla esc.

### Cuenta regresiva de la bomba
Al iniciar cada ronda, el contador de la bomba inicia en 60 segundos, al acabar el tiempo la bomba explota e inicia una nueva ronda.

### Selector de mapas
It's Just a Hug tiene 6 mapas por defecto y además es posible crear más, hasta un máximo de 10 mapas.

*Nota:* Por defecto hay 6 mapas creados, y los demás mapas están vacíos (no tienen bloques). Los mapas vacios no son tenidos en cuenta al escoger un mapa aleatorio, pero sí es posible jugarlos seleccionándolos directamente en el selector de mapas.

### Editor de mapas
Todos los mapas son editables. Es posible personalizar el fondo del mapa, los bloques y las posiciones iniciales de los jugadores.
Los tiles de los bloques de tierra se ajustan automáticamente, no es necesario hacerlo de forma manual.

<p align= "center">
  <img src="https://user-images.githubusercontent.com/62948474/92431392-0668b780-f15d-11ea-8f0b-a67d35b6e5c9.PNG" width="450"/>
</p>

Bloques disponibles:
- Suelo: *pasto y nieve*
- Funcionales: *Teletrasnportadores*
- Decoración

Para eliminar un mapa se deben de eliminar todos los bloques y solo establecer las posiciones de los jugadores. De este modo ese mapa no se tiene en cuente al momento de escoger un mapa aleatorio.

*Nota:* Para añadir nuevos tipos de bloques, más información dentro del código.

## Otras Características
- Animación de los jugadores y objetos con sprites.
- Música de fondo y efectos de sonido.
- Explicacion de controles.
  
## Créditos :heart:
Muchas gracias a los siguientes autores por ofrecer su trabajo de forma gratuita a la comunidad. Y a las páginas por sus plataformas y comunidad que han creado en torno a ella.
### Gráficos
- Bayat Games https://bayat.itch.io
### Música y sonidos
- Fesliyan Studios music https://www.fesliyanstudios.com/
- Patrick de Arteaga https://patrickdearteaga.com/
- Partners in Rhyme https://www.partnersinrhyme.com/nFree
- Sound Effects https://www.freesoundeffects.com/
