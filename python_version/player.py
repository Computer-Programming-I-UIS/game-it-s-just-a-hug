# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 10:15:38 2023

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

general_speed=4


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
        
        
        
    def draw(self, screen):
        self.color = Red
        pygame.draw.rect(screen, (self.color), self.Player)
    
    def move(self, bloques):
        
        self.check_keys()
        
        
        self.y_speed+=self.y_acceleration
        # Tener en cuenta teclas presionadas y direcciones bloqueadas
        if self.keys[pygame.K_d] and not self.direcctions['Right']:
            self.x_speed=general_speed
            
        elif self.keys[pygame.K_a] and not self.direcctions['Left']:
            self.x_speed=-general_speed
        else:
            self.x_speed=0
        
        if self.keys[pygame.K_w] and not self.direcctions['Up'] and self.direcctions['Down']: 
            #Si esta libre arriba y esta sobre el suelo
            self.y_speed=-general_speed*2
        elif not self.direcctions['Down']:
            if self.y_speed > 10:
                self.y_speed = 5
            
            #self.y_speed=-general_speed
        else: 
            self.y_speed=0
         
        
        
        self.Player.left+=self.x_speed      
        self.Player.top+=self.y_speed      
            
        
        self.direcctions={'Up': False ,'Down':False ,'Left':False , 'Right': False} #limpiar colisiones
        
        
        self.check_collisions(bloques)
             
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
            # La direccion en la que este true, sera una direccion que esta bloqueada
            collisions_tolerance = 10
            
            
            if self.Player.colliderect(bloque.block):
                if abs(bloque.block.top-self.Player.bottom) < collisions_tolerance: #toca por arriba al bloque
                    direcctions['Down']= True
                    self.Player.bottom = bloque.block.top
                if abs(bloque.block.bottom-self.Player.top) < collisions_tolerance: #toca por abajo al bloque
                    direcctions['Up']= True
                    #print("Blocking Up")
                    self.Player.top = bloque.block.bottom
                    
                if abs(bloque.block.right-self.Player.left) < collisions_tolerance: #toca por derecha al bloque
                    direcctions['Left']= True
                    self.Player.left = bloque.block.right
                    
                if abs(bloque.block.left-self.Player.right) < collisions_tolerance:  #toca por izquierda al bloque
                    direcctions['Right']= True
                    self.Player.right = bloque.block.left
                
                # Si se encuentra con una esquina (hay dos direcciones bloqueadas por el mismo bloque)
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
                        # Si se va moviendo en las dos direcciones, entonces quitar todos los bloqueos y dejar que otro bloque decida
                        direcctions['Up']= False
                        direcctions['Down']= False
                        direcctions['Left']= False
                        direcctions['Right']= False 
                        
                else: 
                    print("No encontre esquina")
            
            # Si hay un true debido a este bloque, se agrega a los bloqueos
            self.direcctions['Up']=self.direcctions['Up'] or direcctions['Up']
            self.direcctions['Down']=self.direcctions['Down'] or direcctions['Down']
            self.direcctions['Left']=self.direcctions['Left'] or direcctions['Left']
            self.direcctions['Right']=self.direcctions['Right'] or direcctions['Right']
                        
        
        # Bloqueos con los bordes de la pantalla
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
        """
        Esta funcion calcula la lista de objetos que estan cerca

        Parameters
        ----------
        list_objets : list
            lista de todos los objetos en pantalla.

        Returns
        -------
        close_objects : list
            lista de los objetos cercanos.

        """
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
   