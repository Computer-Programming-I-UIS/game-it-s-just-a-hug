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

from player import Player
from tiles import bordered_block

size = (screen_size_x, screen_size_y) # Tamaño de la ventana
screen = pygame.display.set_mode(size) #Crear ventana
clock = pygame.time.Clock()


level_map = [
    '                                   ',
    '                        X          ',
    '                  X                ',
    '                  X  X             ',
    '                 XX                ',
    'X               X X                ',
    'XX                X                ',
    'XXX           XXXXX                ',
    'XXXXX                              ',
    'XXXXXXXXXXXXX                      ',
    '     X X  X  X                     ',
    '     X X  X                        ',
    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   ',
    '                                   ',
    '                                  X',
    '          XXXXXXXXXXXXXXXXXXXXXXXXX',
    'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
    ] 


def events():
    for event in pygame.event.get():
        #print(event)
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()

    
player1 = Player(50, 50, sizeBlocks, sizeBlocks*2)

tiles=[]
for raw, index_row in zip(level_map,range(len(level_map))):
    for letter,index_letter in zip(raw,range(len(raw))):
        if letter == 'X':
            tiles.append(bordered_block(sizeBlocks*index_letter, sizeBlocks*index_row, sizeBlocks, sizeBlocks, 4))
        
while True:    
    events()
    screen.fill(White) #color de fondo y limpia pantalla   

    #------------ ZONA DE DIBUJO -----------------#
        
    for block in tiles: block.draw(screen)
    
    player1.move(player1.closest_object(tiles))
    player1.draw(screen)
    
    #-----------FIN ZONA DE DIBUJO ---------------#

    #Actualizar pantalla
    pygame.display.flip()
    clock.tick(60)
