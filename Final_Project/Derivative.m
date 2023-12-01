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
        function obj = Derivative(switchState, derivativeMethod, Oh)
            obj.switchState = switchState;
            obj.derivativeMethod = derivativeMethod;
            obj.Oh = Oh;
        end

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
            if obj.derivativeMethod == 0 % Xap xi tien
                obj.result = double((obj.fx(obj.x + obj.h) - obj.fx(obj.x))/obj.h);
            elseif obj.derivativeMethod == 1 % Xap xi lui
                obj.result = double((obj.fx(obj.x) - obj.fx(obj.x - obj.h))/obj.h);
            else
                obj.result = double((obj.fx(obj.x + obj.h)-obj.fx(obj.x - obj.h))/2*obj.h);
            end 
            result = obj.result;
        end

        function result = fxDerivative(obj)
            if obj.Oh == 0 %O(h)
                if obj.derivativeMethod == 0 % Xap xi tien
                    obj.result = double((obj.fx(obj.x + obj.h) - obj.fx(obj.x))/obj.h);
                elseif obj.derivativeMethod == 1 % Xap xi lui
                    obj.result = double((obj.fx(obj.x) - obj.fx(obj.x - obj.h))/obj.h);
                else
                    obj.result = double((obj.fx(obj.x + obj.h) - obj.fx(obj.x - obj.h))/2*obj.h);
                end 
            else
                if obj.derivativeMethod == 0 % Xap xi tien
                    obj.result = double((-obj.fx(obj.x + 2*obj.h) + 4*obj.fx(obj.x + obj.h) - 3*obj.fx(obj.x))/2*obj.h);
                elseif obj.derivativeMethod == 1 % Xap xi lui
                    obj.result = double((3*obj.fx(obj.x)  - 4*obj.fx(obj.x - obj.h) + obj.fx(obj.x - 2*obj.h))/2*obj.h);
                else
                    obj.result = double((obj.fx(obj.x + obj.h)-obj.fx(obj.x - obj.h))/2*obj.h);
                end 
            end
            result = obj.result;
        end
    end   
end