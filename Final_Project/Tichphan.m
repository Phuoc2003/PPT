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
        K;
        PP;
    end
    
    methods
        function result = hinhthang(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;
            sum = obj.fx(obj.canDuoi) + obj.fx(obj.canTren);
                for i= 1:obj.N - 1
                     sum = sum + 2*obj.fx(obj.canDuoi + i*h);
                end
                obj.result = (h/2) * sum;
                result = obj.result;
        end
        function result = simpsom13(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;
            sum = obj.fx(obj.canDuoi) + obj.fx(obj.canTren);
                for i= 1:2:obj.N - 1
                         sum = sum + 4*obj.fx(obj.canDuoi + i*h);
                end
                for i= 2:2:obj.N-1
                         sum = sum + 2*obj.fx(obj.canDuoi + i*h);
                end
                obj.result = (h/3) * sum;
                result = obj.result;
        end
        function result = simpson38(obj)
            h = (obj.canTren - obj.canDuoi)/obj.N;  
            sum = obj.fx(obj.canDuoi) + obj.fx(obj.canTren);
                 if mod(obj.N, 3) ~= 0                  
                    sum = 0;
                 else
                    for i= 1:3:obj.N - 1  
                        sum = sum + 3*obj.fx(obj.canDuoi + i*h);
                    end  
                    for i= 2:3:obj.N - 1  
                        sum = sum + 3*obj.fx(obj.canDuoi + i*h);
                    end
                    for i= 3:3:obj.N-1
                        sum = sum + 2*obj.fx(obj.canDuoi + i*h);
                    end
                 end
                obj.result = ((3*h)/8) * (sum);
                result = obj.result;
        end
        function obj = Tichphan(K, PP)
            obj.K = K;
            obj.PP = PP;
        end
        function result = XYTichphan(obj)
            syms f(x);
            f(x) = obj.LagrangePolynominal();
            obj.fx = symfun(f(x), x);
            result = obj.fxTichphan();
            
        end
        function result = fxTichphan(obj)            
            if obj.PP == 0 % hinh thang
               result = double(obj.hinhthang());   
            elseif obj.PP == 1 % 1/3
               result = double(obj.simpsom13());  
            else
               result = double(obj.simpsom38()); 
            end           
        end        
    end
end

