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

    properties (Constant)
        OH = 0;
        OH_2 = 1;
        XX_TIEN = 0;
        XX_LUI = 1;
        XX_TTAM = 2;
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
            x = obj.xDH;
            hF = obj.h;
            f = obj.fx;

            if obj.Oh == obj.OH %O(h)
                if obj.derivativeMethod == obj.XX_TIEN % Xap xi tien
                    obj.result = (f(x + hF) - f(x))/hF;
                elseif obj.derivativeMethod == obj.XX_LUI % Xap xi lui
                    obj.result = (f(x) - f(x - hF))/hF;
                else
                    obj.result = (f(x + hF) - f(x - hF))/(2*hF);
                end 
            else
                if obj.derivativeMethod == obj.XX_TIEN  % Xap xi tien
                    obj.result = (-f(x + 2*hF) + 4*f(x + hF) - 3*f(x))/(2*hF);
                elseif obj.derivativeMethod == obj.XX_LUI % Xap xi lui
                    obj.result = (3*f(x) - 4*f(x - hF) + f(x - 2*hF))/(2*hF);
                else
                    obj.result = (f(x + hF) - f(x - hF))/(2*hF);
                end 
            end
            
            result = double(obj.result);
        end
    end   
end