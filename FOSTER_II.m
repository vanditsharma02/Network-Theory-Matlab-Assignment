L1 = 1.875;
L2 = 2.5/0.75;
L3 = 1.5/0.25;
C1 = 2/(3.75*3);
C2 = 0.75/(0.5*2.5);
C3 = 0.25/(1.5*1.5);

F1 = [];
F2 = [];
F3 = [];
A = [L1 L2 L3 C1 C2 C3];
q = sqrt(-1);

for j= 1:10000
	for i= 1:6
		B(i) = A(i)+(-0.1+0.2*rand)*A(i);
    end

	numx = [(1/B(1)) 0]; 	
	denx = [1 0 1/(B(1)*B(4))];
	X = tf(numx,denx);
    
	numy = [(1/B(2)) 0];
	deny = [1 0 1/(B(2)*B(5))];
	Y = tf(numy,deny);
    
	numz = [(1/B(3)) 0];
	denz = [1 0 1/(B(3)*B(6))];
	Z = tf(numz,denz);

	Q = X+Y+Z;
    
    P = abs(pole(1/Q));
    P = unique(P);
    F1 = cat(2, F1, [P(1)]);
    F2 = cat(2, F2, [P(2) P(2)]);
    F3 = cat(2, F3, [P(3) P(3)]);
end
FMode = [mode(F1) mode(F2) mode(F3)];
FMedian = [median(F1) median(F2) median(F3)];
FMean = [mean(F1) mean(F2) mean(F3)];
FStd = [std(F1) std(F2) std(F3)];
F = cat(2, F1, F2, F3);
table(FMode', FMedian', FMean', FStd')
hist(F,100);
xlim([0 1.6]);
title('POLE SENSITIVITY ANALYSIS - FOSTER II');
xlabel('Absolute Value of Pole ---->');
ylabel('Frequency of Pole Occurence ---->');














