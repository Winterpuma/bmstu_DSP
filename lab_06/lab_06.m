function lab_06
    % Input parameters
    A = 1.0;
    sigma = 0.5;

    % Borders of calculation
    mult = 5;
    step = 0.005;
    t = -mult:step:mult;

    % Pulse generation
    x0 = gauspls(t, A, sigma);

    % Gaussian noise generation
    NA = 0;
    NS = 0.05;
    n1 = normrnd(NA, NS, [1 length(x0)]);
    x1 = x0 + n1;

    % Impulsive noise generation
    count = 7;
    M = 0.4;
    n2 = impnoise(length(x0), count, M);
    x2 = x0 + n2;

    % Gee, Matlab, how come your compiler lets you use TWO wieners?
    y1 = wiener(fft(x1), fft(n1));
    y2 = wiener(fft(x2), fft(n2));

    %
    % PLOTTING
    %

    figure(1)
    plot(t, x1, t, ifft(fft(x1).*y1));
    title('Фильтрация сигнала Гаусса фильтром Винера');
    legend('С шумами','Без шумов');

    figure(2)
    plot(t, x2, t, ifft(fft(x2).*y2));
    title('Фильтрация импульсного сигнала фильтром Винера');
    legend('С шумами','Без шумов');
end

% Gaussian pulse generation
function y = gauspls(x,A,s)
	y = A * exp(-(x / s).^2);
end

% Impulsive noise generation
function y = impnoise(size, N, mult)
    step = floor(size / N);
    y = zeros(1, size);
    for i = 1:floor(N / 2)
        y(round(size / 2) + i * step) = mult * (0.5 + rand);
        y(round(size / 2) - i * step) = mult * (0.5 + rand);
    end
end

% Wiener filter
function y = wiener(x,n)
    y = 1 - (n./x).^2;
end