clear all;
close all;
format compact;
clc;

TestDataSet = prtDataGenUnimodal;      % Create some test and
TrainingDataSet = prtDataGenUnimodal;  % training data
classifier = prtClassSvm;              % Create a classifier
classifier = classifier.train(TrainingDataSet);    % Train
classified = run(classifier, TestDataSet);         % Test
subplot(2,1,1);
classifier.plot;
subplot(2,1,2);
[pf,pd] = prtScoreRoc(classified,TestDataSet);
h = plot(pf,pd,'linewidth',3);
title('ROC'); xlabel('Pf'); ylabel('Pd');