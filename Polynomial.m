classdef Polynomial < handle
    % Polynomial 클래스는 다항식의 계수들을 관리하고, 다양한 다항식 연산을 수행하는 방법을 정의합니다.
    %
    % 이 클래스는 다항식의 덧셈, 뺄셈, 곱셈, 미분, 평가 등의 연산을 지원하며,
    % 다항식의 계수 배열을 기반으로 계산을 수행합니다.
    % 계수 배열은 고차항부터 차례대로 저장됩니다.
    
    properties
        % coeff: 다항식의 계수 배열
        % 예: 2x^2 + 3x + 5는 [2, 3, 5]로 저장됩니다.
        % 계수 배열의 길이는 다항식의 차수와 관련이 있습니다.
        coeff  
    end
    
    methods
        % 생성자
        function obj = Polynomial(coeffs)
            % 생성자는 다항식의 계수 배열을 입력받아 Polynomial 객체를 생성합니다.
            % 입력된 계수 배열을 객체의 coeff 속성에 저장합니다.
            % 계수 배열이 주어지지 않으면 기본적으로 빈 배열로 객체를 생성합니다.
            if nargin > 0
                obj.coeff = coeffs;
            else
                obj.coeff = [];
            end
        end
        
        % 다항식을 문자열로 반환
        function str = string(obj)
            n = length(obj.coeff);
            poly_str = "";
            
            for i = 1:n
                coeff = obj.coeff(i);
                if coeff == 0; continue; end
                % 부호 처리
                if i > 1 && coeff > 0
                    poly_str = [poly_str, " + ", num2str(coeff)];
                elseif i > 1 && coeff < 0
                    poly_str = [poly_str, " - ", num2str(abs(coeff))];
                else
                    poly_str = [poly_str, num2str(coeff)];
                end
                % x의 차수 처리
                if i < n
                    poly_str = [poly_str, "x^", num2str(n-i)];
                end
            end
            
            % 다항식 문자열 반환
            str = poly_str;
        end

        % 객체 출력하는 disp 함수
        function disp(obj)
            fprintf("%s\n", obj.string());
        end

        function result = call(obj)
            disp("call")
            result = obj.coeff;
        end

        % 다항식 덧셈 연산자 (+)
        function result = plus(obj1, obj2)
            result_coeffs = polyadd(obj1.coeff, obj2.coeff);
            result = Polynomial(result_coeffs);
        end

        % 다항식 뺄셈 연산자 (-)
        function result = minus(obj1, obj2)
            result_coeffs = polyadd(obj1.coeff, -obj2.coeff);
            result = Polynomial(result_coeffs);
        end

        % 다항식 곱셈 연산자 (*)
        function result = mtimes(obj1, obj2)
            result_coeffs = polymul(obj1.coeff, -obj2.coeff);
            result = Polynomial(result_coeffs);
        end
        
        % 다항식 미분
        function result = derivative(obj)
            new_coeffs = polyder(obj.coeff);
            result = Polynomial(new_coeffs);
        end
        
        % 다항식 평가
        function values = evaluate(obj, x)
            values = polyval(obj.coeff, x);
        end

        % 오버로딩
        function result = subsref(obj, S)
            if length(S) == 1 && strcmp(S(1).type, "()")
                % obj() 호출 시 evaluate 수행
                result = obj.evaluate(S(1).subs{1});
            elseif length(S) == 1 && strcmp(S(1).type, "{}")
                % obj{} 호출 시 coeff 반환
                result = obj.coeff;
            else
                % 기본 동작 유지
                result = builtin("subsref", obj, S);
            end
        end
    end % methods

end % classdef
