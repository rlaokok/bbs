import pygame, os, sys
from pygame.locals import *
import numpy as np
from shooting_game.envs.ball import Ball

class MyShoot:
    def __init__(self, env):
        self.env = env
        self.bFire = False
        self.bGo = True

        pygame.init()
        fpsClock = pygame.time.Clock()
        self.mainSurface = pygame.display.set_mode((700,450))
        pygame.display.set_caption('Simple Shooting Game')

        black = pygame.Color(0, 0, 0)
        white = pygame.Color(255, 255, 255)
        red = pygame.Color(255, 100, 100)
        blue = pygame.Color(100, 200, 250)
        green = pygame.Color(51, 255, 153)
        y = pygame.Color(255,255, 51)
        ssac = pygame.Color(255, 229, 204)
        sky = pygame.Color(51, 255, 255)
        self.yellow = pygame.Color(255,255,0)

        wBall = Ball(self.mainSurface, color=white)
        rBall = Ball(self.mainSurface, pos =[150, 0], color=red)
        bBall = Ball(self.mainSurface, pos=[250, 0], color=blue)
        gBall = Ball(self.mainSurface, pos=[250, 0], color=green)
        yBall = Ball(self.mainSurface, pos=[250, 0], color=y)
        sBall = Ball(self.mainSurface, pos=[250, 0], color=ssac)
        skyBall = Ball(self.mainSurface, pos=[250, 0], color=sky)
        self.blist = [wBall, rBall, bBall, gBall, yBall, sBall, skyBall]
        #self.blist = [wBall, rBall, bBall]

        self.fireYLine = self.mainSurface.get_height() /2
        self.start_pos = self.mainSurface.get_width(), self.fireYLine
        self.end_pos = 0, self.fireYLine

        shot = pygame.mixer.Sound('shotgun.wav')
        meteo = pygame.mixer.Sound('small.wav')
        #self.sprite_sheet = pygame.image.load('shf.png')
        self.env.game = self;   # 게임 주소를 주어라  파이썬 ;는 -> 다른 문장을 더 쓸 수 있게

        while self.bGo:
            self.mainSurface.fill(black)

            for event in pygame.event.get():
                if event.type == pygame.KEYDOWN:  # 키보드가 눌리면
                    pressde = pygame.key.get_pressed()
                    if np.argmax(pressde) == 32:  #스페이스
                        self.fire()               #발사
                        shot.play()
                        hit_ball = self.hit_check() #히트체크 는 이곳에 만들고
                        if hit_ball:              # 명중된 볼이 있으면
                            hit_ball.explode()    #이건 ball 함수에
                            meteo.play()


                if event.type == QUIT:
                    pygame.quit()
                    sys.exit()

            for b in self.blist:
                b.drew()

            if self.bFire:
                self.fire()  # 발사
                shot.play()
                hit_ball = self.hit_check()  # 히트체크 는 이곳에 만들고
                self.env.blist = self.blist
                if hit_ball:  # 명중된 볼이 있으면
                    self.env.reward = 1  # game에 보내주어야 하기에
                    self.env.reward_evt.set()  # env의 이벤트 발생 / 이벤트에 추가
                    hit_ball.explode()  # 이건 ball 함수에
                    meteo.play()
                self.bFire = False


            pygame.display.update()
            fpsClock.tick(60)

    def fire(self):
        #start_pos = self.mainSurface.get_width(), self.mainSurface.get_height() / 2
        #end_pos = 0, self.mainSurface.get_height() / 2
        pygame.draw.line(self.mainSurface, self.yellow, self.start_pos, self.end_pos, 3)

    def hit_check(self):
        for b in self.blist:
            (x, y) = b.pos
              # 볼의 전체 높이에 지름을 더함
            if y+b.radius*2 >= self.fireYLine >= y:
                return b