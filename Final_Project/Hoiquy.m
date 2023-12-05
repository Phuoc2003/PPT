classdef Hoiquy < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        xa;
        ya;
        x;
        ppHoiQuy;
        phuongTrinh;
    end

    methods
        function [y, a1, a0] = hoiQuyTuyenTinh(obj)
            n = length(obj.xa);
            sumX = 0;
            sumY = 0;
            sumXY = 0;
            sumX2 = 0;
            for i = 1:n
                sumX = sumX + obj.xa(i);
                sumY = sumY + obj.ya(i);
                sumXY = sumXY + obj.xa(i) * obj.ya(i);
                sumX2 = sumX2 + obj.xa(i) * obj.xa(i);
            end
            xm = sumX/n;
            ym = sumY/n;
            a1 = (n * sumXY- sumX * sumY)/(n * sumX2 - sumX * sumX);
            a0 = ym - a1 * xm;
            y = a0 + a1 * obj.x;
        end

        function [y, a, b] = hoiQuyHamMu(obj)
            n = length(obj.xa);
            xlog = zeros(n);
            ylog = zeros(n);
            for i = 1:n
                xlog(i) = log10(obj.xa(i));
                ylog(i) = log10(obj.ya(i));
            end
            sumX = 0;
            sumY = 0;
            sumXY = 0;
            sumX2 = 0;
            for i = 1:n
                sumX = sumX + xlog(i);
                sumY = sumY + ylog(i);
                sumXY = sumXY + xlog(i) * ylog(i);
                sumX2 = sumX2 + xlog(i) * xlog(i);
            end
            xm = sumX/n;
            ym = sumY/n;
            a1 = (n * sumXY- sumX * sumY)/(n * sumX2 - sumX * sumX);
            a0 = ym - a1 * xm;
            a = 10^a0;
            b = a1;
            y = a * obj.x ^ b;
        end

        function [y, a, b] = hoiQuyLogarit(obj)
            n = length(obj.xa);
            ylog = zeros(n);
            for i = 1:n
                ylog(i) = log(obj.ya(i));
            end
            sumX = 0;
            sumY = 0;
            sumXY = 0;
            sumX2 = 0;
            for i = 1:n
                sumX = sumX + obj.xa(i);
                sumY = sumY + ylog(i);
                sumXY = sumXY + obj.xa(i) * ylog(i);
                sumX2 = sumX2 + obj.xa(i) * obj.xa(i);
            end
            xm = sumX/n;
            ym = sumY/n;
            a1 = (n * sumXY- sumX * sumY)/(n * sumX2 - sumX * sumX);
            a0 = ym - a1 * xm;
            a = exp(a0);
            b = a1;
            y = a * exp(b * obj.x);
        end
        function result = phuongTrinhHoiQuyTuyenTinh(obj)
            syms x;
            [y,a1,a0] = obj.hoiQuyTuyenTinh();
            y = a0 + a1 * x;
            result = y;
        end
        function result = phuongTrinhHoiQuyHamMu(obj)
            syms x;            
            [y,a,b] = obj.hoiQuyHamMu();
            y = a * x ^ b;
            y = simplify(y);
            result = y;
        end
        function result = phuongTrinhHoiQuyLogarit(obj)
            syms x;
            [y,a,b] = obj.hoiQuyLogarit();
            y = a * exp(b * x);
            y = simplify(y);
            result = y;
        end
    end
end