import pygame, os, sys
from pygame.locals import *
import numpy as np

class Ball:
    def __init__(self, surface = None, color = None, radius=10, pos=[300,0]):
        self.surface = surface
        self.color = color
        self.radius = radius
        self.pos = pos
        self.speedY =np.random.randint(2,6)

        self.sprite_sheet = pygame.image.load('boom3.png')
        self.sprite_idx = 0
        self.exp_frame = []
        for i in range(8):
            for j in range(8):
                self.exp_frame.append((i*128, j*128))

        self.bExpload = True

    def drew(self):
        if self.bExpload:
            (top, left) = self.exp_frame[self.sprite_idx]
            rect = (top+2, left+2, 128-5, 128-5)
            self.surface.blit(self.sprite_sheet, (self.pos[0]-65, self.pos[1]-65), rect)
            self.sprite_idx += 1
            if self.sprite_idx == 4:  #4번 출력
                self.go_top()
                self.sprite_idx = 0    # 초기화
                self.bExpload = False

        else:
            self.pos[1] += self.speedY
            pygame.draw.circle(self.surface, self.color, self.pos, self.radius)

        # 공이 바닥을 벗어나면 다시 화면에 상단으로 이동
        if self.pos[1]> self.surface.get_height():
            self.go_top()

    def explode(self):
        self.bExpload = True


    def go_top(self):
        self.pos[0] = np.random.randint(20, 650)
        self.pos[1] = -5
        self.speedY = np.random.randint(4, 8)


    def reset(self):
        self.pos[1] += self.speedY
        pygame.draw.circle(self.surface, self.color, self.pos, self.radius)
        if self.pos[1] > 225:
            self.pos[0] = np.random.randint(20,650)
            self.pos[1] = -5
            self.speedY = np.random.randint(4, 8)
        return self.pos[0], self.pos[1]