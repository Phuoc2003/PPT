classdef NoiSuy < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        xa;
        ya;
        x;
        ppNoiSuy;
    end

    methods
        function d =  DividedDifference(obj)
            n = length(obj.xa);
            d = obj.ya;
            for i = 1:n
                for j = 1:i-1
                    d(i) = (d(i) - d(j)) / (obj.xa(i) - obj.xa(j));
                end
            end
        end

        function result = NewtonForm(obj, da, xi)
            n = length(da);
            result = da(n);

            for i = n-1:-1:1
                result = result * (xi - obj.xa(i)) + da(i);
            end
        end

        function result = NewtonInterpolation(obj, xi)
            da = obj.DividedDifference();
            result = obj.NewtonForm(da, xi);
        end

        function result = NewtonPolynominal(obj)
            syms f(x);
            f(x) = obj.NewtonInterpolation(x);
            f(x) = simplify(f(x));
            result = f(x);
        end

        function result = Lagrange(obj, xi)
            n = length(obj.xa);
            sum = 0;
            for i = 1:n
                product = obj.ya(i);
                for j = 1:n
                    if i ~= j
                        product = (product * (xi - obj.xa(j)))/(obj.xa(i) - obj.xa(j));
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

    end
end