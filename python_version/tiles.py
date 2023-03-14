# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 10:17:34 2023

@author: User
"""

import pygame

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

class bordered_block():
    def __init__(self, left, top, width, height, border):
        self.left=left
        self.top=top
        self.width=width
        self.height=height
        self.x=self.left+self.width/2
        self.y=self.top+self.height/2
        
        self.color=Green
        self.border = border
        self.block = pygame.Rect(left, top, width, height)
        self.insideblock = pygame.Rect(left+border/2, top+border/2, width-border, height-border)
        
        
        
    
    def draw(self, screen):
        
        
        
        pygame.draw.rect(screen, (self.color), self.block)
        pygame.draw.rect(screen, (Black), self.insideblock)
        
    
        
    def change_color(self, color):
        self.color = color