#!/usr/bin/python3
import os
import sys
import gym
import gym_aquaticus
import random
import numpy as np
import matplotlib.pyplot as plt
import torch
import torch.nn as nn
from stable_baselines3 import PPO

log_dir = '/home/moos/moos-ivp-rlagent/missions/uk_training/models/defend_easy_static3'

env = gym.make('gym_aquaticus:aquaticus-v0', sim_script="/comp/ukdstl_sim.sh", verbose=0, perpetual=1)
# model = PPO.load(log_dir + '/best_model', custom_objects={"learning_rate":0.003,"lr_schedule":lambda _: 0.0, "clip_range": lambda _: 0.2},env=env)
model = PPO.load(log_dir + '/last_model', custom_objects={"learning_rate":0.003,"lr_schedule":lambda _: 0.0, "clip_range": lambda _: 0.2},env=env)
obs = env.reset()
done_count = 0
while done_count < 20:
    action, _ = model.predict(obs, deterministic=False)
    obs, reward, done, info = env.step(action)
    if done:
        obs = env.reset()
        done_count += 1
        
env.close()
