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
import random
from tiles import bordered_block
from player import Player

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

class Scene():
    
    def __init__(self, fondo, musica, letra):
        self.letra = letra
        self.next_scene=letra
        self.fondo = fondo
        self.musica = musica
        
        #cargar musica
        
    
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
    def __init__(self, musica, letra, bomb, font):
        self.letra = letra
        self.next_scene=letra        
        self.musica = musica        
        self.bomb = SpriteSheet.SpriteSheet(bomb) 
        self.font = font
        self.max_maps = 5 # numero maximo de mapas por cargar
        self.actual_map = 0
        self.choosed_map = False
        
        self.lastupdate = pygame.time.get_ticks()
        self.time_max = 10
        self.time_remaining = self.time_max
        self.time_after_explotionMax = 4
        self.time_after_explotion =  self.time_after_explotionMax        
        self.load_maps()
        
    def initial_Set(self):
        #SpritesSheets
        sprite_sheet = pygame.image.load('../shared_files/data/sprites/player01_walking.png').convert_alpha()
        sprite_sheetB = pygame.image.load('../shared_files/data/sprites/player01_bomb.png').convert_alpha()
        sprite_sheetB_Activated = pygame.image.load('../shared_files/data/sprites/player01_bomb_Actived.png').convert_alpha()
        player1=(SpriteSheet.SpriteSheet(sprite_sheet),SpriteSheet.SpriteSheet(sprite_sheetB),SpriteSheet.SpriteSheet(sprite_sheetB_Activated))

        sprite_sheet2 = pygame.image.load('../shared_files/data/sprites/player02_walking.png').convert_alpha()
        sprite_sheet2B = pygame.image.load('../shared_files/data/sprites/player02_bomb.png').convert_alpha()
        sprite_sheet2B_Activated = pygame.image.load('../shared_files/data/sprites/player02_bomb_Actived.png').convert_alpha()
        player2=(SpriteSheet.SpriteSheet(sprite_sheet2), SpriteSheet.SpriteSheet(sprite_sheet2B),SpriteSheet.SpriteSheet(sprite_sheet2B_Activated))
        
        control1 = {"Left": pygame.K_a , "Right": pygame.K_d , "Up": pygame.K_w, "Down": pygame.K_s}
        control2 = {"Left": pygame.K_LEFT, "Right": pygame.K_RIGHT, "Up":  pygame.K_UP,"Down": pygame.K_DOWN}
        
        positionP1 = findPosition(self.maps[self.actual_map-1][0], "1")
        positionP2 = findPosition(self.maps[self.actual_map-1][0], "2")
        bomb = bool(random.getrandbits(1)) #define quien tiene la bomba
        self.player1 = Player(positionP1[0], positionP1[1], sizeBlocks, sizeBlocks*2, player1, control1, bomb)
        self.player2 = Player(positionP2[0], positionP2[1], sizeBlocks, sizeBlocks*2, player2, control2, not bomb)
    
    def change_map(self, maps):
        #elije aletoriamente entre los mapas sin repetir y sin que este vacio
        index = random.randint(1,self.max_maps)
        while (index == self.actual_map):
            index = random.randint(1,self.max_maps)
        self.actual_map = index
        print("chossed map:", index)
        self.fondo = maps[index-1][1]
        
        self.tiles=[]
        for raw, index_row in zip(maps[index-1][0],range(len(maps[index-1][0]))):
            for letter,index_letter in zip(raw,range(len(raw))):
                if letter == 'S':
                    self.tiles.append(bordered_block(sizeBlocks*index_letter, sizeBlocks*index_row, sizeBlocks, sizeBlocks, 4))
        # Una vez elegido el mapa, hacemos los cargues:
        positionP1 = findPosition(self.maps[self.actual_map-1][0], "1")
        positionP2 = findPosition(self.maps[self.actual_map-1][0], "2")
        print(positionP2)
        self.player1.respawn(positionP2[0], positionP2[1])
        self.player2.respawn(positionP1[0], positionP1[1])
        
        self.choosed_map = True 
        
    def load_maps(self):
        self.maps = []
        for n in range(1,self.max_maps+1,1): # cuenta de 1 a max_maps    
            with open('../shared_files/data/maps/map'+str(n)+'.txt') as archivo:
                level_map=archivo.readlines()
            img_mapa = pygame.image.load('../shared_files/data/maps/map'+str(n)+'.png').convert_alpha()
            self.maps.append((level_map, img_mapa))
        
        
        
    def timecount(self):
        if (pygame.time.get_ticks()-self.lastupdate>1000):
            self.lastupdate = pygame.time.get_ticks()
            if self.time_remaining>0:                
                self.time_remaining -=1
                self.text_time = self.font.render(str(self.time_remaining), 0, 'white')
            elif(self.time_remaining==0): # Se acabo el tiempo
                self.time_after_explotion-=1
                self.player1.stopMove(True)
                self.player2.stopMove(True)
                self.player1.kaboom = True
                self.player2.kaboom = True
                # Ejecutar explosion
                if self.time_after_explotion ==0:
                    self.player1.stopMove(False)
                    self.player2.stopMove(False)
                    #Cambiar de escena
                    self.change_map(self.maps)
                    # Iniciar contadores de nuevo
                    self.time_after_explotion = self.time_after_explotionMax
                    self.time_remaining = self.time_max
                    
                    #Limpiar estados
                    self.player1.kaboom = False
                    self.player2.kaboom = False
                    self.player1.reset_frame = False
                    self.player2.reset_frame = False
    
    def show(self, screen, bomb):
        
        if  self.choosed_map==False:
            self.initial_Set()
            self.change_map(self.maps)
            
        super().show(screen) # dibuja el fondo y el mapa
        
        self.timecount() #update timer
        
        
        self.player2.move(self.player2.closest_object(self.tiles))
        self.player2.draw(screen,self.player1)
        
        self.player1.move(self.player1.closest_object(self.tiles))
        self.player1.draw(screen, self.player2)
        
        self.checkponchado()
        self.showbombacontador(screen, bomb)
    def showbombacontador(self, screen, bomb):
        
        screen.blit(self.bomb.animation(0, 200, 200, 0.32,'green', 10), (15,15))
        # The 0.32 scale make than (200,200) -> (64,64)
        #screen.blit(, (27,27))
        screen.blit(self.text_time, self.text_time.get_rect(center=(45, 49)))
        
    
    def checkponchado(self):
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
        if self.player1.distance > 80:
            self.player1.issepareted = True
            self.player2.issepareted = True
        if (self.player1.issepareted and self.player2.issepareted) and self.player1.player.colliderect(self.player2.player):
            # si ya se habian separado y ahora se estan tocando
            self.player1.isbomb = not self.player1.isbomb # Invierte estados si tiene o no la bomba
            self.player2.isbomb = not self.player1.isbomb # Es lo contrario de del player 1
            self.player1.issepareted = False
            self.player2.issepareted = False
      
        
        
        




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
            
