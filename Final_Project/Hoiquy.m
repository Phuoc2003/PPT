classdef Hoiquy < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        xa;
        ya;
        ppHoiQuy;
        doThi;
        phuongTrinh;
        inDuDoan;
        outDuDoan;
    end

    methods
<<<<<<< HEAD
        function [a1, a0] = hoiquytuyentinh(obj)
            n = length(obj.xa);
            x_tb = sum(obj.xa)/n;
            y_tb = sum(obj.ya)/n;
            a1 = (n*sum(obj.xa.*obj.ya) - sum(obj.xa)*sum(obj.ya))/(n*sum(obj.xa.^2) - (sum(obj.xa)^2));
            a0 = y_tb - a1*x_tb;
        end

        function [a, b] = hoiquyhammu(obj)
            n = length(obj.xa);
=======
        function [a1, a0] = hoiQuyTuyenTinh(obj)
            n = length(obj.xa);
            x_tb = sum(obj.xa)/n;
            y_tb = sum(obj.ya)/n;
            a1 = (n * sum(obj.xa .* obj.ya) - sum(obj.xa) * sum(obj.ya))/(n*sum(obj.xa.^2) - (sum(obj.xa)^2));
            a0 = y_tb - a1*x_tb;
        end

        function [a, b] = hoiQuyHamMu(obj)
            n = length(obj.xa);
            xm = zeros(n);
            ym = zeros(n);
>>>>>>> 4d524393726895953e04e3b23a9124b91fa89b4d
            for i = 1:n
                xm(i) = log10(obj.xa(i));
                ym(i) = log10(obj.ya(i));
            end
            xm_tb = sum(xm)/n;
            ym_tb = sum(ym)/n;
            a1 = (n*sum(xm.*ym) - sum(xm)*sum(ym))/(n*sum(xm.^2) - (sum(xm)^2));
            a0 = ym_tb - a1*xm_tb;
            a = 10^a0;
            b = a1;
        end

<<<<<<< HEAD
        function [a, b] = hoiquylogarit(obj)
            n = length(obj.xa);
=======
        function [a, b] = hoiQuyLogarit(obj)
            n = length(obj.xa);
            ym = zeros(n);
>>>>>>> 4d524393726895953e04e3b23a9124b91fa89b4d
            for i = 1:n
                ym(i) = log(obj.ya(i));
            end
            xm_tb = sum(obj.xa)/n;
            ym_tb = sum(ym)/n;
            a1 = (n*sum(obj.xa.*ym) - (sum(obj.xa)*sum(ym)))/(n*sum(obj.xa.^2) - (sum(obj.xa))^2);
            a0 = ym_tb - a1*xm_tb;
            a = exp(a0);
            b = a1;
        end
    end
end