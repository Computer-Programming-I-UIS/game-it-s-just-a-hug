# -*- coding: utf-8 -*-
"""
Created on Sat Mar 18 21:24:32 2023

@author: User
"""

#Tamaño de los Bloques
sizeBlocks = 32;
#Cantidad de Bloques
numBlocksX = 35;
numBlocksY = 18; 

screen_size_x = sizeBlocks*numBlocksX
screen_size_y = sizeBlocks*numBlocksY
import pygame
import SpriteSheet
from buttons import textbutton

class scene():
    
    def __init__(self, fondo, musica, letra):
        self.letra = letra
        self.next_scene=letra
        self.fondo = fondo
        self.musica = musica
        
        #cargar musica
        pass
    
    def show(self, screen):
        #dibujar el fondo
        screen.blit(self.fondo,(0,0))
                
        #sonar musica
        
    def get_next_scene(self):
        return  self.next_scene

   
class gamescreen(scene):
    
    def show(self, screen, player1, tiles):
        super().show(screen)
        player1.move(player1.closest_object(tiles))
        player1.draw(screen)
        
        




class titleScreen(scene):
    def __init__(self, fondo, musica, letra):
        super().__init__(fondo, musica, letra)        
        self.titleSfade=0
        self.last_update=pygame.time.get_ticks()
        self.showtext = True
        #cargar otras imagenes
    def show(self, screen, titleSTitle, titleSPlayer1, titleSPlayer2, keys, text):
        super().show(screen)
        screen.blit(titleSTitle,(0,0))
        screen.blit(titleSPlayer1,(-self.titleSfade*10,self.titleSfade*10))
        screen.blit(titleSPlayer2,(self.titleSfade*10,self.titleSfade*10))
        
        animation_cooldown=500 #milisegundos
        current_time=pygame.time.get_ticks() 
        if current_time-self.last_update>animation_cooldown: #its time to change             
            self.last_update=current_time
            self.showtext= not self.showtext
        # solo mostrar cada 500 segundos
        
        self.fade(keys)    
        
        if self.showtext: screen.blit(text, text.get_rect(center=(screen_size_x/2, screen_size_y*7/8)))
        
        
               
        
    def fade(self, keys):
        if(keys[32] and self.titleSfade == 0):
             self.titleSfade = 1;
                      
        if( self.titleSfade != 0):
            self.titleSfade+=1
            self.showtext = False
        if(self.titleSfade >= 40): self.next_scene = 'I' 
 
class mainMenu(scene):
    def __init__(self, fondo, musica, letra, fuente):
        super().__init__(fondo, musica, letra)
        self.jugar = textbutton('Jugar', fuente)
        self.mapas = textbutton('Mapas', fuente)
        self.credits = textbutton('Créditos', fuente)
        self.howtoplay = textbutton('¿Cómo Jugar?', fuente)
        self.salir = textbutton('Salir', fuente)
        
        
                
        
        self.dyButtons = self.jugar.text.get_rect().height + 5;
        
    def show(self, screen, titleSTitle ):
        super().show(screen)
        screen.blit(titleSTitle,(0,0))
        
        self.jugar.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*0) 
        self.mapas.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*1) 
        self.credits.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*2) 
        self.howtoplay.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*3) 
        self.salir.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*4) 
        
        
        
