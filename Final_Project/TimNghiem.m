classdef TimNghiem < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here

    properties(Access = public)
        f;
        fp;
        a;
        b;
        saiso;
        ppTimNghiem;
        nghiem;
        solanlap;
    end

    methods
        function [nghiem, solanlap] = chiadoi(obj)
             left = obj.a;
             right = obj.b;
             n = 0;
             while((right - left) > obj.saiso) 
                mid = (right+left)/2;
                n = n + 1;
                if (obj.f(left) * obj.f(mid))<=0
                    right = mid; 
                else
                    left = mid;
                end 
             end
             nghiem = left;
             solanlap = n;
        end
        
        function [nghiem, solanlap] = lap(obj)
             c=(obj.a+obj.b)/2;
             if (obj.f(obj.a)*obj.f(c)) < 0
                x0 = obj.a;
             else
                x0 = obj.b;
             end
             n = 0;
             while(1)
                 x1 = obj.fp(x0);
                 n = n + 1;
             if(abs(x1 - x0) < obj.saiso)
                break;
             end
                x0 = x1;
             end
             nghiem = x1;
             solanlap = n;
        end

        function [nghiem,solanlap] = tieptuyen_new(obj)
             left = obj.a;
             right = obj.b;
             syms x;
             fd1 = str2func(['@(x)' char(diff(obj.f(x)))]);
             fd2 = str2func(['@(x)' char(diff(fd1(x)))]);
             c = (obj.a+obj.b)/2;
             if (obj.f(obj.a) * obj.f(c))<0 
                obj.b = c; 
             else
                obj.a = c;
             end
             x0 = obj.a;
             n = 0;
             while(1)
                if((obj.f(x0) * fd2(x0)) > 0)
                    break;
                end
                x0 = (x0+obj.b)/2; 
             end
             while(1)
                 x1 = x0 - (obj.f(x0)/fd1(x0));
                 n = n + 1;
                 if(abs(x1 - x0) < obj.saiso)
                    break;
                 end
                 x0 = x1;
             end
             obj.a = left;
             obj.b = right;
             nghiem = x1;
             solanlap = n;
        end

        function [nghiem, solanlap] = daycung(obj)
             left = obj.a;
             right = obj.b;
             n = 0;
             current = ((left*obj.f(right))-(right*obj.f(left)))/(obj.f(right)-obj.f(left));
             prev = 0;
             while(abs(current - prev) > obj.saiso) 
                 if obj.f(left) * obj.f(current)<0
                    right = current; 
                 else
                    left = current;
                 end
                 prev = current;
                 current = ((left*obj.f(right))-(right*obj.f(left)))/(obj.f(right)-obj.f(left));
                 n = n + 1;
             end
             nghiem = current;
             solanlap = n;
        end
    end
end