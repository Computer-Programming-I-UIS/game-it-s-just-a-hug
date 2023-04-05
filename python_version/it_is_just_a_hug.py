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
import SpriteSheet
pygame.init()
import random
from player import Player
from tiles import bordered_block
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

#SpritesSheets
sprite_sheet = pygame.image.load('../shared_files/data/sprites/player01_walking.png').convert_alpha()
sprite_sheetB = pygame.image.load('../shared_files/data/sprites/player01_bomb.png').convert_alpha()
player1=(SpriteSheet.SpriteSheet(sprite_sheet),SpriteSheet.SpriteSheet(sprite_sheetB))

sprite_sheet2 = pygame.image.load('../shared_files/data/sprites/player02_walking.png').convert_alpha()
sprite_sheet2B = pygame.image.load('../shared_files/data/sprites/player02_bomb.png').convert_alpha()
player2=(SpriteSheet.SpriteSheet(sprite_sheet2), SpriteSheet.SpriteSheet(sprite_sheet2B))

#--------------Main Menu
pixelFont = pygame.font.Font("../shared_files/data/fonts/monogram_extended.ttf",60)
scene_menu = mainMenu(titleSBackground, musica, 'I', pixelFont, titleSBomb)

#-----how to play screen 
scene_howtoplay = Scene(titleHow, musica, 'H')
#-------GAMESCREEN
#Mapa del nivel

with open('../shared_files/data/maps/map2.txt') as archivo:
    level_map=archivo.readlines()
img_mapa = pygame.image.load('../shared_files/data/maps/map2.png').convert_alpha()
#-----------------
scene_game_screen = gamescreen(img_mapa,musica,'G',titleSBomb, pixelFont50)



def findPosition(txtmap, number):
    """
    Busca dentro del mapa de texto donde esta la ubicacion de algun jugador

    Parameters
    ----------
    txtmap : lista de strings
        Es el mapa leido como strings.
    number : int
        Es el numero de jugador.

    Returns
    -------
    int
        posicion en x.
    int
        posicion en Y.

    """
    
    for indiceY, level in enumerate(txtmap):
        for indiceX, char in enumerate(level):
            if char==number:
                return (indiceX*sizeBlocks,indiceY*sizeBlocks)
            
        
    return (0, 0)

def events():
    for event in pygame.event.get():
        #print(event)
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
# playes initials
control1 = {"Left": pygame.K_a , "Right": pygame.K_d , "Up": pygame.K_w, "Down": pygame.K_s}
control2 = {"Left": pygame.K_LEFT, "Right": pygame.K_RIGHT, "Up":  pygame.K_UP,"Down": pygame.K_DOWN}

positionP1 = findPosition(level_map, "1")
positionP2 = findPosition(level_map, "2")
bomb = bool(random.getrandbits(1)) #define quien tiene la bomba
player1 = Player(positionP1[0], positionP1[1], sizeBlocks, sizeBlocks*2, player1, control1, bomb)
player2 = Player(positionP2[0], positionP2[1], sizeBlocks, sizeBlocks*2, player2, control2, not bomb)

tiles=[]
for raw, index_row in zip(level_map,range(len(level_map))):
    for letter,index_letter in zip(raw,range(len(raw))):
        if letter == 'S':
            tiles.append(bordered_block(sizeBlocks*index_letter, sizeBlocks*index_row, sizeBlocks, sizeBlocks, 4))
        
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
        scene_game_screen.show(screen, player1,player2, tiles, titleSBomb)
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
