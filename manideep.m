C1 = 1/1.125;
L1 = 27/16;
L2 = 27/11;
C2 = 968/5103;
L3 = 11902/352;
C3 = 32/1701;
A = [C1 L1 L2 C2 L3 C3]
F1 = [];
F2 = [];
F3 = [];
for i = 1:10000
    R = -0.1 + 0.2*rand(1,6);
    for j = 1:6
        B(j) = A(j)*(1 + R(j));
    end
    s = tf('s');
    Tr =1/(B(1)*s) + 1/(1/(B(2)*s) + 1/((B(3)*s) + 1/((B(4)*s) + 1/((B(5)*s) + 1/((B(6)*s))))));
    P = abs(pole(Tr));
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
title('POLE SENSITIVITY ANALYSIS - CAUER II + CAUER I');
xlabel('Absolute Value of Pole ---->');
ylabel('Frequency of Pole Occurence ---->');
