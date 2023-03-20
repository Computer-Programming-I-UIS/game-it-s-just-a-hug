# -*- coding: utf-8 -*-
"""
Created on Sun Mar 19 20:00:57 2023

@author: User
"""


class textbutton():
    def __init__(self, text_string, font):
        
        self.text = font.render(text_string, 0, 'white')
        self.rect = self.text.get_rect()
        
        self.width = self.text.get_width()
        self.height = self.text.get_height()        
        self.clicked  = False
        
    
    def draw(self, screen, x, y): 
        
        screen.blit(self.text, self.text.get_rect(center=(x, y + 20)))
    
    def update():
        pass
        
        
    