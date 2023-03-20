# -*- coding: utf-8 -*-
"""
Created on Sun Mar 19 20:00:57 2023

@author: User
"""
import pygame

class textbutton():
    def __init__(self, text_string, font):
        
        self.text_original = font.render(text_string, 0, 'white') #superficie con el texto animado   
        self.text = self.text_original
        self.clicked  = False
        
    
    def draw(self, screen, x, y):        
        
        self.rect  = screen.blit(self.text, self.text.get_rect(center=(x, y + 20)))
        
        self.update()
        
    def update(self):
        pos = pygame.mouse.get_pos()
        if (self.rect.collidepoint(pos)):
            self.text = pygame.transform.scale_by(self.text_original, 1.3)
        else: 
            self.text = self.text_original
                        
        pass
        
        
    