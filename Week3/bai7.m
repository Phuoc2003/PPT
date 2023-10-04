Vs = 10; 
C = 10^-5; 
t = 0:0.001:0.5; 
R_values = [0.1*10^3, 1*10^3, 10*10^3]; 
for i = 1:length(R_values)
    R = R_values(i);
    vO = Vs * (1 - exp(-t / (R * C)));
    subplot(length(R_values), 1, i);
    plot(t, vO, 'b');
    xlabel('t(s)');
    ylabel('v0(t)');
end
