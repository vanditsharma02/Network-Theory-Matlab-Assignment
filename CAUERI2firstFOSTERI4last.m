L1 = 1;
L2 = 96/245;
L3 = 3.2;
C1 = 0.5;
C2 = (7/18);
C3 = 175/96;

F1 = [];
F2 = [];
F3 = [];
A = [L1 L2 L3 C1 C2 C3];
q = sqrt(-1);

for j= 1:10000
	for i= 1:6
		B(i) = A(i)+(-0.1+0.2*rand)*A(i);
    end
    
    n6 = B(1)*B(2)*B(3)*B(4)*B(5)*B(6);
    n4 = (B(4)*B(3)*B(5)*B(1))+(B(4)*B(2)*B(5)*B(1))+(B(4)*B(2)*B(6)*B(1))+(B(5)*B(2)*B(6)*B(1))+(B(3)*B(5)*B(2)*B(6));
    n2 = (B(2)*B(6))+(B(3)*B(5))+(B(2)*B(5))+(B(1)*B(4))+(B(5)*B(1));
    n0 = 1;
    d5 = B(3)*B(5)*B(2)*B(6)*B(4);
    d3 = (B(4)*B(3)*B(5))+(B(4)*B(2)*B(5))+(B(4)*B(2)*B(6))+(B(5)*B(2)*B(6));
    d1 = B(4)+B(5);
    
    numz = [n6 0 n4 0 n2 0 n0];
	denz = [d5 0 d3 0 d1 0];
	Z = tf(numz,denz);

	P = abs(pole(Z));
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
title('POLE SENSITIVITY ANALYSIS - CAUER I + FOSTER I');
xlabel('Absolute Value of Pole ---->');
ylabel('Frequency of Pole Occurence ---->');
