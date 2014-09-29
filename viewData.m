%read in training data
All = csvread('data/training.csv',1,0);
%labels = csvread('data/training.csv',0,1);
%sort data by cover type (last column)
[Y,I] = sort(All(:,end)); 
SortedByCover = All(I,:);
%find indexes of where cover type changes
newCoverTypeIndex = [];
for i = 2:1:length(SortedByCover(:,end))
    if SortedByCover(i,end) ~= SortedByCover(i-1,end)
        newCoverTypeIndex(end+1) = i;
    end
end

plot(All(:,1),'. m');



