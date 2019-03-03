L1 = 0.5;
L2 = 0.1875;
L3 = 1;
C1 = 1/1.125;
C2 = 2;
C3 = 1/(2*0.1875);

F1 = [];
F2 = [];
F3 = [];
A = [L1 L2 L3 C1 C2 C3];
q = sqrt(-1);

for j= 1:10000
	for i= 1:6
		B(i) = A(i)+(-0.1+0.2*rand)*A(i);
    end
    
    numw = [1/B(4)]; 	
	denw = [1 0];
	W = tf(numw,denw);
    
    numx = [(1/B(5)) 0];
	denx = [1 0 1/(B(1)*B(5))];
	X = tf(numx,denx); 

	numy = [(1/B(6)) 0];
	deny = [1 0 1/(B(2)*B(6))];
	Y = tf(numy,deny);
    
	numz = [B(3) 0];
	denz = [1];
	Z = tf(numz,denz);
    
    Q=W+X+Y+Z;

	P = abs(pole(Q));
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
title('POLE SENSITIVITY ANALYSIS - FOSTER I');
xlabel('Absolute Value of Pole ---->');
ylabel('Frequency of Pole Occurence ---->');
