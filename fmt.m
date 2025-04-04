function formatted_str = fmt(fmt_str, varargin)
    % fmt 함수는 Python의 f-string과 유사하게 중괄호 {변수:형식}을 사용하여
    % 문자열 내에서 변수를 치환하는 함수입니다.
    %
    % 입력:
    % fmt_str - 포맷팅할 문자열 (예: "Value: {value:.2f}")
    % varargin - 전체 문자열에 적용할 색 (선택 사항)
    %
    % 출력:
    % formatted_str - 포맷팅된 결과 문자열
    %
    % 사용 예시:
    %   name = "Alice";
    %   age = 30;
    %   formatted_str = fmt("Name: {name}, Age: {age}");
    %   disp(formatted_str);
    %
    %   formatted_str = fmt("Hello, {name}!", "#00FF00");
    %   printf(formatted_str);

    % 하드코딩된 숫자 색상 설정
    hightlight = false;
    color_code = "#FFD700";
    
    % 중괄호 안의 변수명과 형식을 추출 (정규 표현식 사용)
    % 중괄호 표시하는 세트 인덱싱을 사용하지 못함
    tokens = regexp(fmt_str, "\{([^}:]+)(?::([^}]+))?\}", "tokens");
    
    for i = 1:length(tokens)
        var_name = tokens{i}{1};  % 변수명
        format_spec = "";
        
        if length(tokens{i}) > 1 && ~isempty(tokens{i}{2})
            format_spec = tokens{i}{2};  % 형식 지정자
        end
        
        % 호출된 환경에서 변수 값을 가져오기
        try
            var_value = evalin("caller", var_name);
        catch
            error("Undefined variable: %s", var_name);
        end
        
        % 값이 숫자일 경우 지정된 형식 적용
        if isnumeric(var_value) && ~isempty(format_spec)
            format_str = ["%" format_spec];
            var_value_str = sprintf(format_str, var_value);
        elseif isnumeric(var_value)
            var_value_str = num2str(var_value);
        else
            var_value_str = var_value;
        end
        
        % 숫자 값에 하드코딩된 색상 적용
        if hightlight && isnumeric(var_value)
            var_value_str = colored(var_value_str, color_code);
        end
        
        % 원본 문자열에서 `{변수:형식}`을 실제 값으로 치환
        match_pattern = ["{" var_name "(:[^}]*)?}"];
        fmt_str = regexprep(fmt_str, match_pattern, var_value_str, "once");
    end
    
    % 전체 문자열 색상 적용 (varargin이 제공된 경우)
    if nargin > 1
        fmt_str = colored(fmt_str, varargin{1});
    end
    
    formatted_str = fmt_str;
end