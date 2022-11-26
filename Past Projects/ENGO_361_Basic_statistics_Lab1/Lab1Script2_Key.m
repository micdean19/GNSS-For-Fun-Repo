data = load( 'Lab1Data2.txt');
datamean = mean(data);
sigma = std(data);
variance = power(sigma,2);
y = cov(data);
z = corrcoef(data);