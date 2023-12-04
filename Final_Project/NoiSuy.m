classdef NoiSuy < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        xa;
        ya;
        x;
        ppNoiSuy;
        result;
    end

    methods
        function [d] =  DividedDifference(xa, ya)
            n = length(xa);
            d = ya;
            for i = 1:n
                for j = 1:i-1
                    d(i) = (d(i) - d(j)) / (xa(i) - xa(j));
                end
            end
        end

        function result = NewtonForm(xa, da, x)
            n = length(da);
            result = da(n);

            for i = n-1:-1:1
                result = result * (x - xa(i)) + da(i);
            end
        end

        function result = NewtonInterpolation(xa, ya, x)
            da = DividedDifference(xa, ya);
            result = NewtonForm(xa, da, x);
        end

        function expression = NewtonInterpolationExpression(xa, ya)

            n = length(xa);
            da = DividedDifference(xa, ya);
            syms x;

            result = ya(1); % Giá trị ban đầu
            for i = 2:n
                tem = 1;
                for j = 1:i - 1
                    tem = tem * (x - xa(j));
                end
                result = result + da(i) * tem;
            end

            expression = result;
            fprintf('Biểu thức nội suy Newton: %s\n', char(expression));
        end

        function result = Lagrange(xa, ya, x)
            n = length(xa)
            sum = 0
            for i = 1:n
                product = ya(i)
                for j= 1:n
                    if (i ~= j)
                        product= product*(x-xa(j)) / (xa(i)-xa(j))
                    end
                end
                sum = sum + product
            end
            result = sum
        end

        function LagrangeInterpolation = ExpressionLagrangeInterpolation(xa, ya)
            syms x;
            n = length(xa);
            LagrangeInterpolation = 0;

            for i = 1:n
                Li = 1;
                for j = 1:n
                    if i ~= j
                        Li = Li * (x - xa(j)) / (xa(i) - xa(j));
                    end
                end
                LagrangeInterpolation = LagrangeInterpolation + Li * ya(i);
            end

            disp('Đa thức nội suy Lagrange:');
            disp(LagrangeInterpolation);
        end
        
    end
end