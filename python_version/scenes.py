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

class Scene():
    
    def __init__(self, fondo, musica, letra):
        self.letra = letra
        self.next_scene=letra
        self.fondo = fondo
        self.musica = musica
        
        #cargar musica
        pass
    
    def show(self, screen):
        self.next_scene = self.letra
        #dibujar el fondo
        screen.blit(self.fondo,(0,0))
                
        #sonar musica
        
    def get_next_scene(self):
        
        if pygame.key.get_pressed()[pygame.K_ESCAPE]:
            self.next_scene = 'I'
        
        return  self.next_scene

   
class gamescreen(Scene):
    def __init__(self, fondo, musica, letra, bomb, font):
        super().__init__(fondo, musica, letra)
        self.bomb = SpriteSheet.SpriteSheet(bomb) 
        self.font = font
        
        self.lastupdate = pygame.time.get_ticks()
        self.time_max = 10
        self.time_remaining = self.time_max
        self.time_after_explotionMax = 4
        self.time_after_explotion =  self.time_after_explotionMax
        
    def change_map(self):
        pass
        
    def timecount(self, player1, player2):
        if (pygame.time.get_ticks()-self.lastupdate>1000):
            self.lastupdate = pygame.time.get_ticks()
            if self.time_remaining>0:                
                self.time_remaining -=1
                self.text_time = self.font.render(str(self.time_remaining), 0, 'white')
            elif(self.time_remaining==0): # Se acabo el tiempo
                self.time_after_explotion-=1
                player1.stopMove(True)
                player2.stopMove(True)
                # Ejecutar explosion
                if self.time_after_explotion ==0:
                    player1.stopMove(False)
                    player2.stopMove(False)
                    #Cambiar de escena
                    self.change_map()
                    # Iniciar contadores de nuevo
                    self.time_after_explotion = self.time_after_explotionMax
                    self.time_remaining = self.time_max
                    
     
    
    def show(self, screen, player1,player2, tiles, bomb):
        super().show(screen) # dibuja el fondo y el mapa
        
        self.timecount(player1, player2) #update timer
        
        
        player2.move(player2.closest_object(tiles))
        player2.draw(screen,player1)
        
        player1.move(player1.closest_object(tiles))
        player1.draw(screen, player2)
        
        self.checkponchado(player1,player2)
        self.showbombacontador(screen, bomb)
    def showbombacontador(self, screen, bomb):
        
        screen.blit(self.bomb.animation(0, 200, 200, 0.32,'green', 10), (15,15))
        # The 0.32 scale make than (200,200) -> (64,64)
        #screen.blit(, (27,27))
        screen.blit(self.text_time, self.text_time.get_rect(center=(45, 49)))
        print(pygame.mouse.get_pos())
    
    def checkponchado(self, player1, player2):
        """
        Revisa que los jugadores se hayan alejado lo suficiente para poder poncharse
        Parameters, modifica el estado bomba o no d elos jugadores
        ----------
        player1 : player
            .
        player2 : player
            .

        Returns
        -------
        None.

        """
        #print(player1.distance)
        if player1.distance > 80:
            player1.issepareted = True
            player2.issepareted = True
        if (player1.issepareted and player2.issepareted) and player1.player.colliderect(player2.player):
            # si ya se habian separado y ahora se estan tocando
            player1.isbomb = not player1.isbomb # Invierte estados si tiene o no la bomba
            player2.isbomb = not player1.isbomb # Es lo contrario de del player 1
            player1.issepareted = False
            player2.issepareted = False
      
        
        
        




class titleScreen(Scene):
    def __init__(self, fondo, musica, letra, bomb):
        super().__init__(fondo, musica, letra)        
        self.titleSfade=0
        self.last_update=pygame.time.get_ticks()
        self.showtext = True
        self.bomb = SpriteSheet.SpriteSheet(bomb)
        #cargar otras imagenes
    def show(self, screen, titleSTitle, titleSPlayer1, titleSPlayer2, keys, text):
        super().show(screen)        
        
        screen.blit(self.bomb.animation(0, 200, 200, 1,'green', 10), (660,20))
        
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
        if(keys[pygame.K_SPACE] and self.titleSfade == 0):
             self.titleSfade = 1;
                      
        if( self.titleSfade != 0):
            self.titleSfade+=1
            self.showtext = False
        if(self.titleSfade >= 40): self.next_scene = 'I' 
 
class mainMenu(Scene):
    def __init__(self, fondo, musica, letra, fuente, bomb):
        super().__init__(fondo, musica, letra)
        self.jugar = textbutton('Jugar', fuente)
        self.mapas = textbutton('Mapas', fuente)
        self.credits = textbutton('Créditos', fuente)
        self.howtoplay = textbutton('¿Cómo Jugar?', fuente)
        self.salir = textbutton('Salir', fuente)
        self.bomb = SpriteSheet.SpriteSheet(bomb)
        
                
        
        self.dyButtons = self.jugar.text.get_rect().height + 5;
        
    def show(self, screen, titleSTitle ):
        super().show(screen)
        screen.blit(self.bomb.animation(0, 200, 200, 1,'green', 10), (660,20))
        screen.blit(titleSTitle,(0,0))
        
        self.jugar.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*0) 
        self.mapas.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*1) 
        self.credits.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*2) 
        self.howtoplay.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*3) 
        self.salir.draw(screen, screen.get_width()/2, screen.get_height()/2+self.dyButtons*4) 
        
        # //'T' = TitleScreen / 'I' = Menu Inicio / 'G' = Juego / 'M' = Mapas / 'E' = Editor de Mapas / 'C' = Creditos / 'H' = ¿Cómo Jugar?
        if self.jugar.mouseClicked(): 
            self.next_scene = 'G' 
            self.jugar.clicked=False #Reseteo
            
        if self.mapas.mouseClicked(): 
            self.next_scene = 'M' 
            self.mapas.clicked=False #Reseteo
        
        if self.credits.mouseClicked(): 
            self.next_scene = 'C' 
            self.credits.clicked=False #Reseteo
            
        if self.howtoplay.mouseClicked(): 
            self.next_scene = 'H' 
            self.howtoplay.clicked=False #Reseteo
            
        if self.salir.mouseClicked(): 
            self.next_scene = 'E' 
            self.salir.clicked=False #Reseteo
            
