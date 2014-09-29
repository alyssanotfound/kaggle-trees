clear all;
close all;
format compact;
clc;

TestDataSet = prtDataGenMary;      % Create some test and 
TrainingDataSet = prtDataGenMary;  % training data
classifier = prtClassBinaryToMaryOneVsAll;   % Create a classifier
classifier.baseClassifier = prtClassSvm;    % Set the binary 
                                           % Classifier
% Set the internal Decider
classifier.internalDecider = prtDecisionMap;

classifier = classifier.train(TrainingDataSet);    % Train
classes    = run(classifier, TestDataSet);         % Test

% Evaluate, plot results
percentCorr = prtScorePercentCorrect(classes.getX,TestDataSet.getTargets)
classifier.plot;