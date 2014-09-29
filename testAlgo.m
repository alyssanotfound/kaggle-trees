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

%%%% TEST DATA %%%%
%import all data except the labels and id#s
AllT = csvread('data/testing.csv',1,1);
newWildColT = [];
newSoilColT = [];
wildColsT = AllT(:,11:14);
soilColsT = AllT(:,15:54);
for i = 1:1:length(wildColsT)
    newWildColT(i) = find( wildColsT(i,:) );
end
for i = 1:1:length(soilColsT)
    newSoilColT(i) = find( soilColsT(i,:) );
end
newWildColT = newWildColT';
newSoilColT = newSoilColT';
%delete binary data
AllT(:,11:54) = [];
AllT = [AllT,newWildColT,newSoilColT];
dsTest = prtDataSetClass(AllT);

disp('datasets made');

preprocess = prtPreProcZeroMeanColumns;
class0 = prtClassMatlabTreeBagger;
class = prtClassKnn;
class.k = 3;

algo = preprocess + class0 + prtDecisionMap; 
disp('algorithm made');

%see % correct from training data
dsOut = algo.kfolds(ds,7);
perCorr = prtScorePercentCorrect(dsOut)


algo = algo.train(ds);
final = run(algo, dsTest);


%class.plot(testData);
