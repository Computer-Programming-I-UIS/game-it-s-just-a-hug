# -*- coding: utf-8 -*-
"""
Created on Thu Mar  9 10:49:25 2023

@author: User
"""
# RGB Colores
Black = (0, 0, 0)
White =(255, 255, 255)
Green = (0, 255, 0)
Red = (255, 0, 0)
Blue = (0, 0, 255) 


import pygame, sys
import colorsys
pygame.init()

size = (800, 500) # Tamaño de la ventana
screen = pygame.display.set_mode(size) #Crear ventana

mycolor=pygame.Color(0,0,0)
while True:    
    for event in pygame.event.get():
        #print(event)
        if event.type == pygame.QUIT:
            pygame.quit()
            sys.exit()
    
    
    screen.fill(White) #color de fondo
    
    ###--- ZONA DE DIBUJO
    #Ejemplos
    pygame.draw.line(screen, Green, [0, 250], [100, 250], 13)
    pygame.draw.circle(screen, Blue, [400, 250], 100)
    pygame.draw.rect(screen, Blue, (100,100,50,50))
    
    
    ###--- Final zona de dibujo

            
        
    
    #Actualizar pantalla
    pygame.display.flip()