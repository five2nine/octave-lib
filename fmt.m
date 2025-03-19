function formatted_str = fmt(fmt_str, varargin)
    % fmt 함수는 Python의 f-string과 유사하게 중괄호 {변수명}을 사용하여
    % 문자열 내에서 변수를 치환하는 함수입니다.
    %
    % 입력:
    % fmt_str - 포맷팅할 문자열 (예: 'Name: {name}, Age: {age}')
    % hex (선택) - 색상을 지정하는 16진수 문자열 (예: '#FF5733')
    %
    % 출력:
    % formatted_str - 포맷팅된 결과 문자열
    %
    % 사용 예시:
    %   name = 'Alice';
    %   age = 30;
    %   formatted_str = fmt('Name: {name}, Age: {age}');
    %   disp(formatted_str);
    %
    %   formatted_str = fmt('Hello, {name}!', '#00FF00');
    %   printf(formatted_str);
    
    % 중괄호 안의 변수명을 추출 (정규 표현식 사용)
    tokens = regexp(fmt_str, '\{([^}]+)\}', 'tokens');
    
    % 추출된 변수명에 대해 반복
    for i = 1:length(tokens)
        var_name = tokens{i}{1};  % 변수명 가져오기
        
        % 호출된 환경에서 해당 변수의 값을 가져오기
        try
            var_value = evalin("caller", var_name);
        catch
            error("Undefined variable: %s", var_name);  % 변수명이 정의되지 않으면 오류 발생
        end
        
        % 값이 숫자라면 문자열로 변환
        if isnumeric(var_value)
            var_value = num2str(var_value);
        end
        
        % 원본 문자열에서 `{변수}`를 실제 값으로 치환
        fmt_str = strrep(fmt_str, ['{' var_name '}'], var_value);
    end
    
    % hex 값이 제공되었으면 colored 적용
    if nargin > 1
        hex = varargin{1};
        formatted_str = colored(fmt_str, hex);
    else
        formatted_str = fmt_str;
    end
end
