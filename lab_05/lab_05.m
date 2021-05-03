function lab_05
    % Input parameters
    A = 1.0;
    sigma = 0.5;

    % Borders of calculation
    mult = 5;
    step = 0.005;
    t = -mult:step:mult;

    % Pulse generation
    x0 = gauspls(t,A,sigma);

    % Gaussian noise generation
    NA = 0;
    NS = 0.05;
    n1 = normrnd(NA,NS,[1 length(x0)]);
    x1 = x0+n1;

    % Impulsive noise generation
    count = 7;
    M = 0.4;
    n2 = impnoise(length(x0),count,M);
    x2 = x0+n2;

    % Calculation of filtering arrays
    [B,A] = butter(6,0.05,'high');
    G = gaussfilt(4,20,'high');
    BB = buttfilt(6,20,'high');

    %
    % PLOTTING
    %

    figure(1)
    plot(t,x0,t,x1,t,x2);
    title('Исходные сигналы');
    legend('Без помех','Импульсная помеха','Помеха по Гауссу');

    % figure(2)
    % plot(t,x0,t,filtfilt(B,A,x1),t,filtfilt(B,A,x2));
    % title('Recursive Butterworth filtering');
    % legend('Without noise','Impulsive noise','Gaussian noise');

    figure(2)
    plot(t,x0,t,x1-filtfilt(G,1,x1),t,x2-filtfilt(G,1,x2));
    title('Гауссовский фильтр');
    legend('Без помех','Импульсная помеха','Помеха по Гауссу');

    figure(3)
    plot(t,x0,t,x1-filtfilt(BB,1,x1),t,x2-filtfilt(BB,1,x2));
    title('Фильтр Баттеруорта');
    legend('Без помех','Импульсная помеха','Помеха по Гауссу');
end

% Gaussian pulse generation
function y = gauspls(x,A,s)
	y = A * exp(-(x/s).^2);
end

% Impulsive noise generation
function y = impnoise(size,N,mult)
    step = floor(size/N);
    y = zeros(1,size);
    for i = 1:floor(N/2)
        y(round(size/2)+i*step) = mult*(0.5+rand);
        y(round(size/2)-i*step) = mult*(0.5+rand);
    end
end

% Non-recursive Butterworth implementation
function y = buttfilt(D,size,type)
    x = linspace(-size/2,size/2,size);
    if (strcmp(type,'low'))
        y = 1./(1+(x./D).^4);
    elseif (strcmp(type,'high'))
        y = 1./(1+(D./x).^4);
    else
        y = x*sum(x);
    end
    y = y/sum(y);
end

% Non-recursive Gaussian implementation
function y = gaussfilt(sigma,size,type)
    x = linspace(-size/2,size/2,size);
    if (strcmp(type,'low'))
        y = exp(-x.^2/(2*sigma^2));
    elseif (strcmp(type,'high'))
        y = 1 - exp(-x.^2/(2*sigma^2));
    else
        y = x*sum(x);
    end
    y = y/sum(y);
end