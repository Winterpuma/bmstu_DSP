function lab_02()
T = 2.0;
A = 1.0;
sigma = 0.5;

% Границы расчета
mult = 5;
t = -mult:0.05:mult;

% Расчет импульсных функций
x1 = zeros(size(t));
x1(abs(t) - T < 0) = 1;
x1(abs(t) == T) = 0.5;
x2 = A * exp(-(t/sigma).^2);

% FFT
yx1 = fft(x1);
yx2 = fft(x2);

yg1 = fftshift(yx1);
yg2 = fftshift(yx2);

% DFT
zx1 = dft(x1);
zx2 = dft(x2);

zg1 = fftshift(zx1);
zg2 = fftshift(zx2);

M = 0:length(t)-1;

figure (1);
plot(M,abs(yx1)/length(M),'r',M,abs(yg1)/length(M),'black');
title('FFT: амплитудный спектр прямоугольного импульса');
legend('С эффектом близнецов','Без эффекта близнецов');

figure(2);
plot(M,abs(yx2)/length(M),'r',M,abs(yg2)/length(M),'black');
title('FFT: амплитудный спектр Гауссова импульса');
legend('С эффектом близнецов','Без эффекта близнецов');

figure (3);
plot(M,abs(zx1)/length(M),'r',M,abs(zg1)/length(M),'black');
title('DFT: амплитудный спектр прямоугольного импульса');
legend('С эффектом близнецов','Без эффекта близнецов');

figure (4);
plot(M,abs(zx2)/length(M),'r',M,abs(zg2)/length(M),'black');
title('DFT: амплитудный спектр Гауссова импульса');
legend('С эффектом близнецов','Без эффекта близнецов');
end

% Дискретное преобразование Фурье
function y = dft(x)
a = 0:length(x)-1;
b = -2 * pi * sqrt(-1) * a / length(x);
for i = 1:length(a)
    a(i) = 0;
    for j = 1:length(x)
        a(i) = a(i) + x(j) * exp(b(i) * j);
    end
end
y = a;
end
