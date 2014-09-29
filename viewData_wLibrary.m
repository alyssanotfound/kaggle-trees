clear all;
close all;
format compact;
clc;

x = csvread('data/training.csv',1,0);
y = importlabels('training.csv');
dataSet = prtDataSetClass(x,y);

plot(dataSet);