# -*- coding: utf-8 -*-
"""
Created on Fri Mar 10 17:44:44 2023

@author: User
"""
import pygame


class SpriteSheet():
    def __init__(self, image):
        self.sheet=image
        
    def get_image(self, frame, action, width, height, scale,keycolor):
        #Create the surface
        image = pygame.Surface((width,height), pygame.SRCALPHA).convert_alpha() 
        image.blit(self.sheet,(0,0),(frame*width,action*height,width,height))
        image = pygame.transform.scale(image, (width*scale,height*scale))
        image.set_colorkey(keycolor)
        return image
        