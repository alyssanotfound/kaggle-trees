clear all;
close all;
format compact;
clc;
NumFeatures = 10;
%import all data except the labels and id#s
All = csvread('data/training.csv',1,1);
%only use some of the features (cols)
All(:,NumFeatures+1:54) = [];

%make the first half of data test data
AllTest = All(1:2000,:);
%make a vector of the cover types for test data
z = AllTest(:,end);
%don't include cover types col in features
AllTest = AllTest(:,1:NumFeatures);

%make second half the training data
AllTrain = All(2001:end,:);
%make a vector of the cover types for train data
y = AllTrain(:,end);
%don't include cover types col in features
AllTrain = AllTrain(:,1:NumFeatures);


TrainingDataSet = prtDataSetClass(AllTrain,y);
TestDataSet = prtDataSetClass(AllTest,z);


classifier = prtClassBinaryToMaryOneVsAll;   % Create a classifier
classifier.baseClassifier = prtClassMap;    % Set the binary classifier 
disp('classifier set');

% Set the internal Decider
classifier.internalDecider = prtDecisionMap;

classifier = classifier.train(TrainingDataSet);    % Train
disp('training done');
classes = run(classifier, TestDataSet);         % Test
disp('testing done');
% print results - compare test predictions and actual test targets
percentCorr = prtScorePercentCorrect(classes.getX,TestDataSet.getTargets)

%classifier.plot;



