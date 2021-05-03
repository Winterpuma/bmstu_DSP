function lab_08()
    F = 3; 
    dt = 0.05;
    x = -F:dt:F;
    yx = mygaussignal(x); 
    uxbase = mygaussignal(x);
    ux = mygaussignal(x);
    N = length(yx); 

    a = 0.25;
    epsv = 0.05;

    px = a .* rand(1, 7); 

    pos = [25, 35, 40, 54, 67, 75, 95]; 
    pxx = length(pos);

    for i = 1 : 1 : pxx
        ux(pos(i)) = ux(pos(i)) + px(i); 
        uxbase(pos(i)) = uxbase(pos(i)) + px(i); 
    end

    for i = 1 : 1 : N
        smthm = mean(ux, i); 
        if (abs(ux(i) - smthm) > epsv)
            ux(i) = smthm; 
        end
    end

    figure
    title(['MEAN-функция фильтрации']);
    hold on; 
    plot(x, yx);
    plot(x, ux); 
    legend('Исходный гауссовский сигнал','Сглаженный сигнал');
    hold off; 

    uxbase = mygaussignal(x);
    ux = mygaussignal(x);

    for i = 1 : 1 : pxx
        ux(pos(i)) = ux(pos(i)) + px(i); 
        uxbase(pos(i)) = uxbase(pos(i)) + px(i); 
    end

    for i = 1 : 1 : N
        smthm = med(uxbase, i); 
        if (abs(ux(i) - smthm) > epsv)
            ux(i) = smthm; 
        end
    end

    figure 
    title(['MED-функция фильтрации']);
    hold on; 
    plot(x, yx);
    plot(x, ux);
    legend('Исходный гауссовский сигнал','Сглаженный сигнал');
    hold off;
end

function y = mean(ux, i)
    r = 0;
    imin = i - 2; 
    imax = i + 2; 
    for j = imin : 1 : imax
        if (j > 0 && j < (length(ux) + 1))
            r = r + ux(j); 
        end
    end
    r = r / 5; 
    y = r; 
end

function y = med(ux, i)
    imin = i - 1; 
    imax = i + 1; 
    ir = 0; 
    if (imin < 1)
        ir = ux(imax); 
    else
        if (imax > length(ux))
            ir = ux(imin); 
        else
            if (ux(imax) > ux(imin))
                ir = ux(imin); 
            else
                ir = ux(imax); 
            end
        end
    end
    y = ir; 
end

function y = mygaussignal(x)
    a = 1;
    sigma = 1; 
    y = a * exp(-x.^2 / sigma ^ 2); 
end