import gym
from gym import error, spaces, utils
from gym.utils import seeding
from shooting_game.envs.SimpleShoot import MyShoot
import threading
import time
import numpy as np

class ShootingEnv(gym.Env):
  metadata = {'render.modes': ['human']}

  def __init__(self):
    print('init()')
    self.reward = 0
    self.blist = 0
    self.reward_evt = threading.Event()
    # 이벤트 발생시까지 기다리다가 이벤트가 발생하면 기다림이 해제된다.
    # self.reward_event.wait(10) : 10초 동안 기다림
    # self.reward_evt.set() : 이벤트 발생, 위의 기다림이 즉시 해제됨
    # self.reward_evt.clear() :  이벤트가 설정되면 wait()를 다시 호출
    self.action_space = spaces.Discrete(2)
    self.observation_space = spaces.Box(low=-10, high=250, shape=(7,), dtype=np.int)
                                   # ㄴ 다차원 배열이면서 연속적인 값
                                      # 최소값   최대값    차원수 원소 3개    공을 올리기 위해 int

  def step(self, action):
    observation = (0,0,0,0,0,0,0)
    observation = (self.game.blist[0].pos[1],
                   self.game.blist[1].pos[1],
                   self.game.blist[2].pos[1],
                   self.game.blist[3].pos[1],
                   self.game.blist[4].pos[1],
                   self.game.blist[5].pos[1],
                   self.game.blist[6].pos[1])
    if action == 1:
      #self.game.fire()
      self.reward = 0
      self.game.bFire = True  #b = 불리언
      #time.sleep(0.2) <- 아래걸 죽이고 이걸 살리면 아래 reward를 받아 올순 있지만
                      # 이것 조차 없으면 바로 위 self.reward = 0 이 바로 나오기에 슬립을 주어 받아오는 값을 넣는다.
      self.reward_evt.wait(1)  #reward_evt.set() , 즉 이벤트발생 전까지1초 기다려
      self.reward_evt.clear()  #기존 발생한 이벤트를 해제하여 다시 wait() 호출
      observation = (self.game.blist[0].pos[1],
                     self.game.blist[1].pos[1],
                     self.game.blist[2].pos[1],
                     self.game.blist[3].pos[1],
                     self.game.blist[4].pos[1],
                     self.game.blist[5].pos[1],
                     self.game.blist[6].pos[1])  # y 값만 뽑는다.
      #print('발사', self.reward,self.game.blist[0].pos[1], end="")
      #print(self.reward)
      # (observation, reward, done, dict) 을 튜플로 리턴해야한다
          #상태 정보,    점수, 게임이 끝났는지,  비워놓는다.
    return observation, self.reward, False, {}

  def reset(self):
    try:
      if self.game:
        self.game.bGo = False
    except Exception as e:
      pass
    self.game_thread = threading.Thread(target=MyShoot, args=(self,))
    self.game_thread.daemon = True  # 메인 스레드가 끝나면 같이 자식 스레드도 끝난다.
    self.game_thread.start()
    time.sleep(1)
    observation =(self.game.blist[0].pos[1],
                  self.game.blist[1].pos[1],
                  self.game.blist[2].pos[1],
                  self.game.blist[3].pos[1],
                  self.game.blist[4].pos[1],
                  self.game.blist[5].pos[1],
                  self.game.blist[6].pos[1])  # y 값만 뽑는다.

    return observation
    #self.game = MyShoot()
    #t = threading.Thread(target=MyShoot, args=(self,)) #self가 이 개체 주소를 돌리겠다.
                         #  ㄴenvironment 생성된 개체 init에서 self를 받아서 t로 보내주어
    #t.daemon = True
    #t.start()
    #변수명 = threading.Thread(target=스레드 진행할 함수, args = (돌릴 인자))
    #변수명.start(): 스레드시작시사용
    #변수명.join(): 스레드가종료되길기다릴경우
    #변수명.run(): 스레드의동작을정의


  def render(self, mode='human', close=False):
      #print('Current Step:', self.cur_step, 'Total Reward:', self.total_reward)
      #위에서 하나 만들어서 돌아갈 때마다 +1 진행
    pass
