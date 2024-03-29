# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 10:15:38 2023

@author: User
"""
import pygame

# RGB Colores
Black = (0, 0, 0)
White = (255, 255, 255)
Green = (0, 255, 0)
Red = (255, 0, 0)
Blue = (0, 0, 255)

# Blocks
# Tamaño de los Bloques
sizeBlocks = 32
# Cantidad de Bloques
numBlocksX = 35
numBlocksY = 18

screen_size_x = sizeBlocks * numBlocksX
screen_size_y = sizeBlocks * numBlocksY

general_speed = 4


class Player:
    def __init__(self, left, top, width, height):

        self.left = left
        self.top = top
        self.width = width
        self.height = height
        self.player = pygame.Rect(left, top, width, height)
        self.color = Red

        self.x_acceleration = 0
        self.y_acceleration = 1

        self.x_speed = 0
        self.y_speed = 0

        self.direcctions = {"Up": False, "Down": False, "Left": False, "Right": False}

    def draw(self, screen):
        pygame.draw.rect(screen, (self.color), self.player)

    def move(self, bloques):

        self.check_keys()

        # Definir el desplazamiento que va a tener el jugador en cada eje

        if (
            self.keys[pygame.K_d] and not self.direcctions["Right"]
        ):  # Mover a la derecha
            self.x_speed = general_speed
        elif (
            self.keys[pygame.K_a] and not self.direcctions["Left"]
        ):  # Mover a la izquierda
            self.x_speed = -general_speed
        else:
            self.x_speed = 0

        if (
            self.keys[pygame.K_w]
            and not self.direcctions["Up"]
            and self.direcctions["Down"]
        ):  # Saltar
            self.y_speed = round(-3.5 * general_speed)
        elif not self.direcctions["Down"]:  # Caer
            if self.y_speed < 15:  # Limite de velocidad de caida
                self.y_speed += self.y_acceleration
        else:
            self.y_speed = 0

        # # Intentar mover al jugador lo máximo posible
        # player_shadow = self.player.move(self.player.left + self.x_speed, self.player.top + self.y_speed)
        # if not Player.check_collisions(player_shadow, bloques):
        #     self.player.move_ip(self.player.left + self.x_speed, self.player.top + self.y_speed)
        #     return
        if False:
            pass
        else:  # De lo contrario entonces mueve poco a poco
            sign = lambda a: 1 if a > 0 else -1 if a < 0 else 0

            self.direcctions = {
                "Up": False,
                "Down": False,
                "Left": False,
                "Right": False,
            }
            player_shadow = self.player.copy()

            # Mover shadow en x
            for _ in range(abs(self.x_speed)):
                player_shadow.left += sign(self.x_speed)
                if (
                    Player.check_collisions(player_shadow, bloques)
                    or (sign(self.x_speed) == 1 and self.player.right >= screen_size_x)
                    or (sign(self.x_speed) == -1 and self.player.left <= 0)
                ):
                    player_shadow.left -= sign(
                        self.x_speed
                    )  # Revierte el desplazamiento
                    if sign(self.x_speed) == 1:
                        self.direcctions["Right"] = True
                    elif sign(self.x_speed) == -1:
                        self.direcctions["Left"] = True
                    break

            # Mover shadow en y
            for _ in range(abs(self.y_speed)):
                player_shadow.top += sign(self.y_speed)
                if (
                    Player.check_collisions(player_shadow, bloques)
                    or (sign(self.y_speed) == 1 and self.player.bottom >= screen_size_y)
                    or (sign(self.y_speed) == -1 and self.player.top <= 0)
                ):
                    player_shadow.top -= sign(
                        self.y_speed
                    )  # Revierte el desplazamiento
                    if sign(self.y_speed) == 1:
                        self.direcctions["Down"] = True
                    elif sign(self.y_speed) == -1:
                        self.direcctions["Up"] = True
                        self.y_speed = 0
                    break

            # Mover jugador
            self.player.left = player_shadow.left
            self.player.top = player_shadow.top

    def check_keys(self):
        self.keys = pygame.key.get_pressed()

        # if keys[pygame.K_UP]:
        #     print("up pressed")
        # else:
        #     print ("up not pressed")

        # if keys[pygame.K_a]:
        #     print("a pressed")
        # else:
        #    print ("a not pressed")

    def check_collisions(player_shadow, bloques):
        """
        Parameters
        ----------
        bloques : List of blocks close
            Revisa si los bloques cercanos tienen alguna colision con el jugador.
            Modifica un diccionario que dice hacia donde puede o no moverse el jugador

        Returns
        -------
        Boolean

        """
        for bloque in bloques:
            if player_shadow.colliderect(bloque.block):
                return True
        return False

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
        close_objects = []
        for obj in list_objets:

            if (
                abs(obj.x - self.player.centerx) < sizeBlocks * 2
                and abs(obj.y - self.player.centery) < sizeBlocks * 2
            ):
                # Si el objeto esta a menos distancia de bloque de distancia
                close_objects.append(obj)
                obj.change_color(Blue)
            else:
                obj.change_color(Green)

        # print (len(close_objects), "objects close")
        return close_objects
