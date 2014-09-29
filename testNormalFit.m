clear all;
close all;
format compact;
clc;
NumFeatures = 1;
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
%OneCol = AllTrain(:,1);
%AllTrain = normc(AllTrain);

SIGMA = cov(AllTrain);
%find mean of each row
MU = mean(AllTrain);
%find giant normal dist
npdf = mvnpdf(AllTrain,MU,SIGMA);
plot(npdf);








