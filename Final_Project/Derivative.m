classdef Derivative < NoiSuy
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        fx;
        h;
        Oh;
        derivativeMethod;
        xDH;
        switchState;
        result;
    end

    methods
        function obj = Derivative(switchState, derivativeMethod, Oh)
            obj.switchState = switchState;
            obj.derivativeMethod = derivativeMethod;
            obj.Oh = Oh;
        end

        function result = LagrangeDerivative(obj)
            syms f(x);
            f(x) = obj.LagrangePolynominal();
            obj.fx = symfun(f(x), x);
            obj.h = obj.xa(2) - obj.xa(1);

            result = obj.fxDerivative();
        end

        function result = fxDerivative(obj)
            if obj.Oh == 0 %O(h)
                if obj.derivativeMethod == 0 % Xap xi tien
                    obj.result = double((obj.fx(obj.xDH + obj.h) - obj.fx(obj.xDH))/obj.h);
                elseif obj.derivativeMethod == 1 % Xap xi lui
                    obj.result = double((obj.fx(obj.xDH) - obj.fx(obj.xDH - obj.h))/obj.h);
                else
                    obj.result = double((obj.fx(obj.xDH + obj.h) - obj.fx(obj.xDH - obj.h))/2*obj.h);
                end 
            else
                if obj.derivativeMethod == 0 % Xap xi tien
                    obj.result = double((-obj.fx(obj.xDH + 2*obj.h) + 4*obj.fx(obj.xDH + obj.h) - 3*obj.fx(obj.xDH))/2*obj.h);
                elseif obj.derivativeMethod == 1 % Xap xi lui
                    obj.result = double((3*obj.fx(obj.x)  - 4*obj.fx(obj.xDH - obj.h) + obj.fx(obj.xDH - 2*obj.h))/2*obj.h);
                else
                    obj.result = double((obj.fx(obj.xDH + obj.h)-obj.fx(obj.xDH - obj.h))/2*obj.h);
                end 
            end
            
            result = obj.result;
        end
    end   
end