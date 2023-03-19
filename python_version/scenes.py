# -*- coding: utf-8 -*-
"""
Created on Sat Mar 18 21:24:32 2023

@author: User
"""

def titleScreen(titleSBackground, screen, titleSTitle, titleSPlayer1, titleSPlayer2, spaceKey, titleSfade):
    
    screen.blit(titleSBackground,(0,0))
    screen.blit(titleSTitle,(0,0))
    
    # if(spaceKey and titleSfade == 0):
    #     titleSfade = 1;
     
    # if( titleSfade != 0):  titleSfade+=1
    # if(titleSfade >= 40):
    #     pass
         #cambiar la escena
    
         
    screen.blit(titleSPlayer1,(0,0))
    screen.blit(titleSPlayer2,(0,0))

def startMenu():
    pass

def game():
    pass

def mapas():
    pass

def mapEditor():
    pass

def Creditos():
    pass

def howToPlay():
    pass

dict_scene = {'T':  titleScreen, 'I': startMenu, 'G': game, 'M': mapas, 'E': mapEditor, 'C': Creditos, 'H': howToPlay}