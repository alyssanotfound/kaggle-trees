mu = [1 -1]; 
SIGMA = [.9 .4; .4 .3]; 
X = mvnrnd(mu,SIGMA,10); 
p = mvnpdf(X,mu,SIGMA);