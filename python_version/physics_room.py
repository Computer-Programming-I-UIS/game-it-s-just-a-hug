# -*- coding: utf-8 -*-
"""
Created on Sat Mar 11 18:25:12 2023

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


import pygame, sys
pygame.init()

size = (screen_size_x, screen_size_y) # Tamaño de la ventana
screen = pygame.display.set_mode(size) #Crear ventana
clock = pygame.time.Clock()

general_speed=4

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
    'XXXXXXXXXXXXXX                     ',
    '     X X  X                        ',
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
        
        
        
    
    def draw(self):
        
        
        
        pygame.draw.rect(screen, (self.color), self.block)
        pygame.draw.rect(screen, (Black), self.insideblock)
        
    def get_position(self):
        return (self.left+self.width/2,self.top+self.height/2)
        
    def change_color(self, color):
        self.color = color
    
        
        
class Player():
    
    
    def __init__(self, left ,top , width, height):        
        
        self.left = left
        self.top = top
        self.width = width
        self.height = height
        self.Player = pygame.Rect(left, top, width, height)
        
        self.x_acceleration=0
        self.y_acceleration=0.5
        
        self.x_speed=0
        self.y_speed=0
        
        self.direcctions={'Up': False ,'Down':False ,'Left':False , 'Right': False}
        
        
        
    def draw(self):
        self.color = Red
        pygame.draw.rect(screen, (self.color), self.Player)
    
    def move(self, bloques):
        
        self.check_keys()
        self.check_collisions(bloques)
        
        
        self.y_speed+=self.y_acceleration
        
        if self.keys[pygame.K_d] and not self.direcctions['Right']:
            self.x_speed=general_speed
            
        elif self.keys[pygame.K_a] and not self.direcctions['Left']:
            self.x_speed=-general_speed
        else:
            self.x_speed=0
        
        if self.keys[pygame.K_w] and not self.direcctions['Up'] and self.direcctions['Down']:
            self.y_speed=-general_speed*2
        elif not self.direcctions['Down']:
            if self.y_speed > 10:
                self.y_speed = 5
            pass
            #self.y_speed=-general_speed
        else: 
            self.y_speed=0
         #   self.y_speed=0
        
        
        self.Player.left+=self.x_speed      
        self.Player.top+=self.y_speed      
            
        
        self.direcctions={'Up': False ,'Down':False ,'Left':False , 'Right': False} #limpiar colisiones
        
             
        #self.Player.top+=self.y_speed
    
        
        
        
        # collision with screen borders
    def check_keys(self):
        self.keys = pygame.key.get_pressed()
        
        # if keys[pygame.K_UP]:
        #     print("up pressed")
        # else:
        #     print ("up not pressed")
            
        # if keys[pygame.K_a]:
        #     print("a pressed")
        #else:
        #    print ("a not pressed")
    def check_collisions(self,bloques): 
        '''        

        Parameters
        ----------
        bloques : List of blocks close
            Revisa si los bloques cercanos tienen alguna colision con el jugador.
            Modifica un diccionario que dice hacia donde puede o no moverse el jugador

        Returns
        -------
        None.

        '''
        
        for bloque in bloques:
            direcctions={'Up': False ,'Down':False ,'Left':False , 'Right': False} #limpiar colisiones
            collisions_tolerance = 10
            
            if self.Player.colliderect(bloque.block):
                if abs(bloque.block.top-self.Player.bottom) < collisions_tolerance: #toca por arriba al bloque
                    direcctions['Down']= True
                    self.Player.bottom = bloque.block.top+1
                if abs(bloque.block.bottom-self.Player.top) < collisions_tolerance: #toca por abajo al bloque
                    direcctions['Up']= True
                    print("Blocking Up")
                    self.Player.top = bloque.block.bottom-1
                    
                if abs(bloque.block.right-self.Player.left) < collisions_tolerance: #toca por derecha al bloque
                    direcctions['Left']= True
                    
                if abs(bloque.block.left-self.Player.right) < collisions_tolerance:  #toca por izquierda al bloque
                    direcctions['Right']= True
                
                # Si se encuentra con una esquina (hay dos Trues)
                if not (direcctions['Down'] ^ direcctions['Up'] ^ direcctions['Left'] ^ direcctions['Right']):
                    print ("Encontre una esquina")
                    print("En y: ",self.y_speed)
                    print("En x: ",self.x_speed)
                    if abs(self.y_speed) > 0:
                        # Si estaba cayendo, entonces quitar el bloqueo vertical (de este bloque)
                        direcctions['Up']= False
                        direcctions['Down']= False                        
                    elif  0 < abs(self.x_speed):
                        # Si estaba moviendose a los lados, entonces quitar el bloqueo horizontal (de este bloque)
                        direcctions['Left']= False
                        direcctions['Right']= False    
                    elif abs(self.y_speed) > 0 and abs(self.x_speed) > 0:
                        direcctions['Up']= False
                        direcctions['Down']= False
                        direcctions['Left']= False
                        direcctions['Right']= False 
                        
                else: 
                    print("No encontre")
            self.direcctions['Up']=self.direcctions['Up'] or direcctions['Up']
            self.direcctions['Down']=self.direcctions['Down'] or direcctions['Down']
            self.direcctions['Left']=self.direcctions['Left'] or direcctions['Left']
            self.direcctions['Right']=self.direcctions['Right'] or direcctions['Right']
                        
        
        if self.Player.right >= screen_size_x:
            self.direcctions['Right']= True
            #self.x_speed *= -1 #borrar
        if self.Player.left <0:
            self.direcctions['Left']= True            
            #self.x_speed *= -1 #borrar
        if self.Player.bottom >= screen_size_y:
            self.direcctions['Down']= True
            #self.y_speed *= 0 #borrar
        if self.Player.top <0:
            self.direcctions['Up']= True
            
       
            #self.y_speed *= 0 #borrar
            
    def closest_object(self, list_objets):
        close_objects=[]
        for obj in list_objets:
            
            if abs(obj.x-self.Player.centerx) < sizeBlocks*2 and abs(obj.y-self.Player.centery) < sizeBlocks*2:
                # Si el objeto este menos distancia de bloque de distancia
                close_objects.append(obj)
                obj.change_color(Blue)
            else: 
                obj.change_color(Green)
                
        #print (len(close_objects), "objects close")
        return close_objects
        
        
        
    
    
player1 = Player(50, 50, sizeBlocks, sizeBlocks*2)
#floor1 = [bordered_block(block*sizeBlocks, sizeBlocks*15, sizeBlocks, sizeBlocks, 4) for block in range(numBlocksX)]
#floor2 = [bordered_block(block*sizeBlocks, sizeBlocks*14, sizeBlocks, sizeBlocks, 4) for block in range(numBlocksX-20)]
#floor3 = [bordered_block(block*sizeBlocks, sizeBlocks*13, sizeBlocks, sizeBlocks, 4) for block in range(numBlocksX-20)]
#floor4 = [bordered_block(block*sizeBlocks, sizeBlocks*12, sizeBlocks, sizeBlocks, 4) for block in range(numBlocksX-20)]
#floor = floor1+floor2+floor3+floor4
tiles=[]
for raw, index_row in zip(level_map,range(len(level_map))):
    for letter,index_letter in zip(raw,range(len(raw))):
        if letter == 'X':
            tiles.append(bordered_block(sizeBlocks*index_letter, sizeBlocks*index_row, sizeBlocks, sizeBlocks, 4))
        
while True:    
    events()
    screen.fill(White) #color de fondo y limpia pantalla   
    
    
    #------------ ZONA DE DIBUJO -----------------#
    
    #for block in floor: block.draw()      
    for block in tiles: block.draw()      
     
    player1.draw()
    #player1.closest_object(floor)
    #player1.move(floor)
    
    player1.closest_object(tiles)
    player1.move(tiles)
    
    
    
    
    
        
    
    
    #-----------FIN ZONA DE DIBUJO ---------------#


            
    #Actualizar pantalla
    pygame.display.flip()
    clock.tick(60)
