classdef Tichphan < NoiSuy
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Access = public)
        fx;
        canTren;
        canDuoi;
        N;
        result;
        onOff;
        chonPP;
        OnOff;
        PP;
    end

    methods
        function obj = Tichphan(canTren, canDuoi, OnOff, PP)
            obj.canTren = canTren;
            obj.canDuoi = canDuoi;
            obj.OnOff = OnOff;
            obj.PP = PP;
        end

        function result = hinhthang(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;
            sum = obj.fx(obj.canDuoi) + obj.fx(obj.canTren);
            for i= 1:obj.N - 1
                sum = sum + 2*obj.fx(obj.canDuoi + i*h);
            end
            obj.result = (h/2) * sum;
            result = obj.result;
        end

        function result = simpson13(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;
            a = obj.canDuoi;
            b = obj.canTren;
            sumChan = 0;
            sumLe = 0;
            for i= 1:obj.N - 1
                if mod(i,2) == 1
                    sumLe = sumLe + obj.fx(a + i*h);
                else
                    sumChan = sumChan + obj.fx(a + i*h);
                end
            end
            obj.result = (h/3) * (obj.fx(a) + obj.fx(b) + 4*sumLe + 2*sumChan);
            result = obj.result;
        end

        function result = simpson38(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;
            a = obj.canDuoi;
            b = obj.canTren;
            sum1 = obj.fx(a) + obj.fx(b);
            sumMod1 = 0;
            sumMod2 = 0;
            sumMod0 = 0;
            if mod(obj.N, 3) ~= 0
                sum1 = 0;
            else
                for i= 1:obj.N - 1
                    if mod(i,3) == 1
                        sumMod1 = sumMod1 + obj.fx(a + i*h);
                    elseif mod(i,3) == 2
                        sumMod2 = sumMod2 + obj.fx(a + i*h);
                    else
                        sumMod0 = sumMod0 + obj.fx(a + i*h);
                    end
                end
                obj.result = ((3*h)/8) * (sum1 + 3*sumMod1 + 3*sumMod2 + 2*sumMod0);
                result = obj.result;
            end
        end

        function result = XYTichphan(obj)
            syms f(x);
            f(x) = obj.LagrangePolynominal();
            obj.fx = symfun(f(x), x);
            result = obj.fxTichphan();

        end
        function result = fxTichphan(obj)
            if obj.PP == 0 % hinh thang
                result = obj.hinhthang();
            elseif obj.PP == 1 % 1/3
                result = obj.simpson13();
            else
                result = obj.simpson38();
            end
        end
    end
end

