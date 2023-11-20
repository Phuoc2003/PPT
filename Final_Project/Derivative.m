classdef Derivative < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        xa;
        ya;
        fx;
        h;
        Oh;
        derivativeMethod;
        x;
        switchState;
        result;
    end

    methods
        function result = Lagrange(obj, xi)
            n = length(obj.xa);
            sum = 0;
            for i = 1:n
                product = obj.ya(i);
                for j = 1:n
                    if i ~= j
                        product = (product * (xi-obj.xa(j)))/(obj.xa(i)-obj.xa(j));
                    end
                end
                sum = sum + product;
            end
        result = sum;
        end

        function result = LagrangePolynominal(obj)
            syms f(xi);
            f(xi) = obj.Lagrange(xi);
            f(xi) = simplify(f(xi));
            result = f(xi);
        end

        function result = LagrangeDerivative(obj)
            syms f(xi);
            f(xi) = obj.LagrangePolynominal();
            obj.fx = symfun(f(xi), xi);
            obj.h = obj.xa(2) - obj.xa(1);
            obj.result = double((obj.fx(obj.x+obj.h)-obj.fx(obj.x))/obj.h);
            result = obj.result;
        end
    end   
end