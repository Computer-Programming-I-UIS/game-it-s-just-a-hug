# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 10:14:57 2023

@author: User
"""

# RGB Colores
Black = (0, 0, 0)
White =(255, 255, 255)
Green = (0, 255, 0)
Red = (255, 0, 0)
Blue = (0, 0, 255)

# Blocks 

#Tamaño de los Bloques
sizeBlocks = 32;
#Cantidad de Bloques
numBlocksX = 35;
numBlocksY = 18; 

screen_size_x = sizeBlocks*numBlocksX
screen_size_y = sizeBlocks*numBlocksY

general_speed=4

import pygame, sys

pygame.init()


from scenes import titleScreen, gamescreen, mainMenu, Scene

size = (screen_size_x, screen_size_y) # Tamaño de la ventana
screen = pygame.display.set_mode(size) #Crear ventana
clock = pygame.time.Clock()

#---------Escena-----
scene = 'T' # //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'M' = Mapas / 'E' = Editor de Mapas / 'C' = Creditos / 'H' = ¿Cómo Jugar?

#--------Title

titleSBackground = pygame.image.load("../shared_files/data/titleScreen/only_background.png").convert_alpha();
titleSPlayer1 = pygame.image.load("../shared_files/data/titleScreen/player_azul.png").convert_alpha();
titleSPlayer2 = pygame.image.load("../shared_files/data/titleScreen/player_rojo.png").convert_alpha();
titleSTitle = pygame.image.load("../shared_files/data/titleScreen/title.png").convert_alpha();
titleSBomb = pygame.image.load("../shared_files/data/titleScreen/bombAnimation.png").convert_alpha();
titleHow = pygame.image.load("../shared_files/data/titleScreen/pantalla controles.png").convert_alpha();
titleSfade=0 #

musica = 'Cargar cancion aqui'
scene_title_screen=titleScreen(titleSBackground, musica, 'T',titleSBomb)
pixelFont = pygame.font.Font("../shared_files/data/fonts/monogram_extended.ttf",35)
pixelFont50 =pygame.font.Font("../shared_files/data/fonts/monogram_extended.ttf",50)
textpresspace = pixelFont.render("Presione espacio para continuar", 0, 'gray30')



#--------------Main Menu
pixelFont = pygame.font.Font("../shared_files/data/fonts/monogram_extended.ttf",60)
scene_menu = mainMenu(titleSBackground, musica, 'I', pixelFont, titleSBomb)

#-----how to play screen 
scene_howtoplay = Scene(titleHow, musica, 'H')
#-------GAMESCREEN

#Mapa del nivel

#-----------------
scene_game_screen = gamescreen(musica,'G',titleSBomb, pixelFont50)





def events():
    for event in pygame.event.get():
        #print(event)
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
# playes initials



        
while True:    
    events()
    screen.fill(White) #color de fondo y limpia pantalla
    keys = pygame.key.get_pressed()
    #------------ ZONA DE DIBUJO -----------------#
        
    # #for block in tiles: block.draw(screen)
    # print("--Player 1--")
    # print("up: ", player1.player.top)
    # print("left: ", player1.player.left)
    # print("--Player 2--")
    # print("up: ", player2.player.top)
    # print("left: ", player2.player.left)
    
    
    
    if scene == 'T':
        scene_title_screen.show(screen, titleSTitle, titleSPlayer1, titleSPlayer2, keys, textpresspace)
        scene = scene_title_screen.get_next_scene()
        # Calcula el centro del texto para poder ubicarlo facilmente
        
    elif scene == 'I':
        scene_menu.show(screen, titleSTitle)
        scene = scene_menu.get_next_scene()
    elif scene == 'G':
        scene_game_screen.show(screen, titleSBomb)
        scene = scene_game_screen.get_next_scene()
    
    elif scene == 'H':
        scene_howtoplay.show(screen)
        scene = scene_howtoplay.get_next_scene()
        
    
    elif scene == 'E':
        pygame.quit()
        sys.exit()
        
        
    
        
    
    #-----------FIN ZONA DE DIBUJO ---------------#

    #Actualizar pantalla
    pygame.display.flip()
    clock.tick(60)
