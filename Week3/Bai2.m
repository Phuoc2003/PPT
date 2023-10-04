t = 0:1:50;
x = 10 * (1 - exp(-0.2 .* t));
plot(t,x)
xlabel('t')
ylabel('v(t)')