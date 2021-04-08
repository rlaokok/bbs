import gym
import shooting_game.envs.SimpleShoot
import shooting_game.envs.shooting_game_env
import time
import threading
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Activation, Flatten
from keras.optimizers import Adam
from rl.agents.dqn import DQNAgent
from rl.policy import BoltzmannQPolicy
from rl.memory import SequentialMemory

ENV_NAME = 'shooting-v0'
env = gym.make(ENV_NAME)

#print(env.reset())

#print('게임 실행')

'''while True:
    time.sleep(1)
    action = np.random.randint(0,2)
    env.step(action)

    nb_actions = env.action_space.n
    space =  env.observation_space.shape
    print(nb_actions, space)'''
#np.random.seed(123) # 랜덤값을 나중에도 쓰기 위해

nb_actions = env.action_space.n # 액션이 갖는 행동의 가지수 (여기선 2)
print(env.action_space)
print('actions : \n', nb_actions)

model = Sequential()
model.add(Flatten(input_shape=(1,) + env.observation_space.shape))  #1 행 4열
model.add(Dense(64))
model.add(Activation('relu'))
model.add(Dense(128))
model.add(Activation('relu'))
model.add(Dense(64))
model.add(Activation('relu'))
model.add(Dense(nb_actions))  # 출력 2
model.add(Activation('linear'))
print(model.summary())

memory = SequentialMemory(limit=50000, window_length=1)
policy = BoltzmannQPolicy() # exploit all the information present in the estimated Q values
dqn = DQNAgent(model=model,
               nb_actions=nb_actions,
               memory=memory,
               nb_steps_warmup=5,
               target_model_update=1e-2,
               policy=policy)
dqn.compile(Adam(lr=1e-3), metrics=['mae'])
              # lr : learning rate(학습률)
              # 측정항목 : mean absolut error

#dqn.fit(env, nb_steps=50000, visualize=False, verbose=1)


#dqn.save_weights('dqn_{}_weights.h5f'.format(ENV_NAME), overwrite=True)

print('Finish')                                           # 묻지 말고 덮어 써라
# Load weights
dqn.load_weights('dqn_{}_weights.h5f'.format(ENV_NAME))
#print('test')
# Finally, evaluate out algorithm for 5 episodes.
dqn.test(env, nb_episodes=5, visualize=True)