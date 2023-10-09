t = 0:0.0001:0.1; 
v = 10 * cos(377 * t);
i = 5 * cos(377 * t + 60);
plot(t, v, 'b', t, i, 'r');
xlabel('t');
ylabel('value');
legend('v(t)', 'i(t)');
grid on;