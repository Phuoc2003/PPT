classdef Hoiquy < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        xn;
        yn;
        ppHoiQuy;
        doThi;
        phuongTrinh;
        inDuDoan;
        outDuDoan;
    end

    methods
        function [a1, a0] = hoiquytuyentinh(x, y)
            n = length(x);
            x_tb = sum(x)/n;
            y_tb = sum(y)/n;
            a1 = (n*sum(x.*y) - sum(x)*sum(y))/(n*sum(x.^2) - (sum(x)^2));
            a0 = y_tb - a1*x_tb;
        end

        function [a, b] = hoiquyhammu(x, y)
            n = length(x);
            for i = 1:n
                xm(i) = log10(x(i));
                ym(i) = log10(y(i));
            end
            xm_tb = sum(xm)/n;
            ym_tb = sum(ym)/n;
            a1 = (n*sum(xm.*ym) - sum(xm)*sum(ym))/(n*sum(xm.^2) - (sum(xm)^2));
            a0 = ym_tb - a1*xm_tb;
            a = 10^a0;
            b = a1;
        end

        function [a, b] = hoiquylogarit(x, y)
            n = length(x);
            for i = 1:n
                ym(i) = log(y(i));
            end
            xm_tb = sum(x)/n;
            ym_tb = sum(ym)/n;
            a1 = (n*sum(x.*ym) - (sum(x)*sum(ym)))/(n*sum(x.^2) - (sum(x))^2);
            a0 = ym_tb - a1*xm_tb;
            a = exp(a0);
            b = a1;
        end
    end
end