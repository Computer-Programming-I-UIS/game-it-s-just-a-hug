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

from player import Player
from tiles import bordered_block
from scenes import titleScreen, dict_scene

size = (screen_size_x, screen_size_y) # Tamaño de la ventana
screen = pygame.display.set_mode(size) #Crear ventana
clock = pygame.time.Clock()

#---------Escena-----
scene = 'T' # //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'M' = Mapas / 'E' = Editor de Mapas / 'C' = Creditos / 'H' = ¿Cómo Jugar?

#--------Title
titleSBackground = pygame.image.load("../shared_files/data/titleScreen/only_background.png").convert_alpha();
titleSBackground = pygame.image.load("../shared_files/data/titleScreen/only_background.png").convert_alpha();
titleSPlayer1 = pygame.image.load("../shared_files/data/titleScreen/player_azul.png").convert_alpha();
titleSPlayer2 = pygame.image.load("../shared_files/data/titleScreen/player_rojo.png").convert_alpha();
titleSTitle = pygame.image.load("../shared_files/data/titleScreen/title.png").convert_alpha();
titleSBomb = pygame.image.load("../shared_files/data/titleScreen/bombAnimation.png").convert_alpha();
titleHow = pygame.image.load("../shared_files/data/titleScreen/pantalla controles.png").convert_alpha();
titleSfade=0 #
#SpritesSheets
sprite_sheet = pygame.image.load('../shared_files/data/sprites/player01_walking.png').convert_alpha()
player1=SpriteSheet.SpriteSheet(sprite_sheet)
#----------------------

#Mapa del nivel
with open('../shared_files/data/maps/map2.txt') as archivo:
    level_map=archivo.readlines()
img_mapa = pygame.image.load('../shared_files/data/maps/map2.png').convert_alpha()

screen.blit(img_mapa,(0,0))


def events():
    for event in pygame.event.get():
        #print(event)
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    
player1 = Player(50, 100, sizeBlocks, sizeBlocks*2, player1)

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
        
    #for block in tiles: block.draw(screen)
    
    
    
    
    if scene == 'T':
        #titleScreen(titleSBackground, screen, titleSTitle, titleSPlayer1, titleSPlayer2, keys[pygame.K_SPACE], titleSfade)
        
        screen.blit(titleSBackground,(0,0))
        screen.blit(titleSTitle,(0,0))
        
        if(keys[pygame.K_SPACE] and titleSfade == 0):
             titleSfade = 1;
         
        if( titleSfade != 0):  titleSfade+=1
        if(titleSfade >= 40):
            scene = 'G' 
            
             
        screen.blit(titleSPlayer1,(-titleSfade*10,titleSfade*10))
        screen.blit(titleSPlayer2,(titleSfade*10,titleSfade*10))
        
           
        
    elif scene == 'G':
        screen.blit(img_mapa,(0,0))
        player1.move(player1.closest_object(tiles))
        player1.draw(screen)
        
    
        
    
    #-----------FIN ZONA DE DIBUJO ---------------#

    #Actualizar pantalla
    pygame.display.flip()
    clock.tick(60)
