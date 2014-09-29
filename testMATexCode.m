clear all;
close all;
format compact;
clc;

TestDataSet = prtDataGenUnimodal;       % Create some test and
TrainingDataSet = prtDataGenUnimodal;   % training data
classifier = prtClassMap;               % Create a classifier
classifier = classifier.train(TrainingDataSet);    % Train
classified = run(classifier, TestDataSet);         % Test

subplot(2,1,1); classifier.plot;  % Plot results
subplot(2,1,2); prtScoreRoc(classified,TestDataSet);
set(get(gca,'Children'), 'LineWidth',3)