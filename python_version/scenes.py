# -*- coding: utf-8 -*-
"""
Created on Sat Mar 18 21:24:32 2023

@author: User
"""



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
    
        #cargar otras imagenes
    def show(self, screen, titleSTitle, titleSPlayer1, titleSPlayer2, keys):
        super().show(screen)
        screen.blit(titleSTitle,(0,0))
        screen.blit(titleSPlayer1,(-self.titleSfade*10,self.titleSfade*10))
        screen.blit(titleSPlayer2,(self.titleSfade*10,self.titleSfade*10))
        
        self.fade(keys)
        
        #cargar las otras imagenes
    def fade(self, keys):
        if(keys[32] and self.titleSfade == 0):
             self.titleSfade = 1;
         
        if( self.titleSfade != 0):  self.titleSfade+=1
        if(self.titleSfade >= 40): self.next_scene = 'G' 
 
    
        
