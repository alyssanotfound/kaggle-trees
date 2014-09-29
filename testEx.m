clear all;
close all;
format compact;
clc;

%import all data except the labels and id#s
All = csvread('data/training.csv',1,1);
newWildCol = [];
newSoilCol = [];
wildCols = All(:,11:14);
soilCols = All(:,15:54);
for i = 1:1:length(wildCols)
    newWildCol(i) = find( wildCols(i,:) );
end
for i = 1:1:length(soilCols)
    newSoilCol(i) = find( soilCols(i,:) );
end
newWildCol = newWildCol';
newSoilCol = newSoilCol';
%delete binary data
All(:,11:54) = [];
%make a vector of the cover types for train data
y = All(:,end);
%don't include cover types col in features
All = All(:,1:10);
All = [All,newWildCol,newSoilCol];

ds = prtDataSetClass(All,y);



%TrainingDataSet = prtDataSetClass(AllTrain,y);
%TestDataSet = prtDataSetClass(AllTest,z);

%test m-ary classification

classifier = prtClassBinaryToMaryOneVsAll;   % Create a classifier
classifier.baseClassifier = prtClassSvm;    % Set the binary classifier 
disp('classifier set');

% Set the internal Decider
classifier.internalDecider = prtDecisionMap;
dsOut = classifier.kfolds(ds,3);
%classifier = classifier.train(DS);    % Train
disp('training done');


%classes = run(classifier, TestDataSet);         % Test
%disp('testing done');
% print results - compare test predictions and actual test targets
percentCorr = prtScorePercentCorrect(dsOut)
%classifier.plot;

