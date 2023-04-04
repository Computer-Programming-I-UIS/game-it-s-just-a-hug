# -*- coding: utf-8 -*-
"""
Created on Fri Mar 10 17:44:44 2023

@author: User
"""
import pygame


class SpriteSheet():
    def __init__(self, image):
        self.sheet=image
        self.last_update=pygame.time.get_ticks()
        self.frame=0
        
    def get_image(self, frame, action, width, height, scale,keycolor):
        #Create the surface
        image = pygame.Surface((width,height), pygame.SRCALPHA).convert_alpha() 
        image.blit(self.sheet,(0,0),(frame*width,action*height,width,height))
        image = pygame.transform.scale(image, (width*scale,height*scale))
        image.set_colorkey(keycolor)
        return image
    
    def animation(self, action, width, height, scale,keycolor, Nsprites):
        animation_cooldown=100
        current_time=pygame.time.get_ticks()     
        if current_time-self.last_update>animation_cooldown: #its time to change frame
            self.frame+=1
            self.last_update=current_time
            if self.frame>=Nsprites:
                self.frame=0
        return self.get_image(self.frame, action, width, height, scale,keycolor)