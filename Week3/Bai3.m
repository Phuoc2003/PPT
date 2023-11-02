t = 0:0.00001:0.02; 
v = 10 * cos(377 * t);
i = 5 * cos(377 * t + 60);
plot(t, v, 'b', t, i, 'r');
xlabel('t');
ylabel('v(t), i(t)');
legend('v(t)', 'i(t)');
grid on;