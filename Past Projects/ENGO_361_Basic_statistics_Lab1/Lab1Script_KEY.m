data = load( 'Lab1Data.txt');
A = data(:,1);
B = data(:,2);

Xa = mean(A);
Xb = mean(B);

Va = Xa - A;
Vb = Xb - B;

sigmaA = std(A);
sigmaB = std(B);

SigmaBarA= sigmaA/sqrt(length(A));
SigmaBarB= sigmaB/sqrt(length(B));

AverageErrorA = sum(abs(Xa-A)) / (length(A)-1);
AverageErrorB = sum(abs(Xb-B)) / (length(B)-1);


Asort = sort(abs(Xa-A),'ascend');
pEA = 0.5 * (Asort(length(A)/2) + Asort((length(A)/2)+1));

Bsort = sort(abs(Xb-B),'ascend');
pEB = 0.5 * (Bsort(length(B)/2) + Bsort((length(B)/2)+1));

%Plot of Measurements Value

figure;
hist(A);
hold on;

plot(B);
grid on;
xlabel('No. of Measurement');
ylabel('Distance (m)');
title('Plot 1:Distance of Dataset A & B')


%Plot of Residual Values
figure;
plot(Xa-A);
hold on;
plot(Xb-B);
grid on;
xlabel('No. of Measurement');
ylabel('Residuals (m)');
title('Plot 2:Residuals of A & B');


%Plot of PDH for Residuals of Vector B with number of bins
figure; 
hist(Va,length(Va),'Normalization','pdf');
grid on;
xlabel('Distances (m)');
ylabel('Relative Frequency');
title('Plot 3:Relative Frequency Vs distance for Data Set A')

figure; 
hist(Vb,length(Vb),'Normalization','pdf');
grid on;
xlabel('Distances (m)');
ylabel('Relative Frequency');
title('Plot 4:Relative Frequency Vs distance for Data Set B')

