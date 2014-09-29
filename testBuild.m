clear all;
close all;
format compact;
clc;
NumFeatures = 10;
%import all data except the labels and id#s
All = csvread('data/training.csv',1,1);
%only use some of the features (cols)
All(:,NumFeatures+1:54) = [];
%make a vector of the cover types for train data
y = All(:,end);
%don't include cover types col in features
All = All(:,1:NumFeatures);

TrainingDataSet = prtDataSetClass(All,y);


%preprocess
TrainingDataSet = TrainingDataSet.retainFeatures(1:3);
logDisc = prtPreProcMinMaxRows;

minmax = logDisc.train(TrainingDataSet);
TrainingDataSetNew = minmax.run(TrainingDataSet);
%test m-ary classification

classifier = prtClassBinaryToMaryOneVsAll;   % Create a classifier
classifier.baseClassifier = prtClassKnn;    % Set the binary classifier 
disp('classifier set');

% Set the internal Decider
classifier.internalDecider = prtDecisionMap;

classifier = classifier.train(TrainingDataSetNew);    % Train
disp('training done');
classes = run(classifier, TestDataSet);         % Test
disp('testing done');
% print results - compare test predictions and actual test targets
%percentCorr = prtScorePercentCorrect(classes.getX,TestDataSet.getTargets)
%classifier.plot;
