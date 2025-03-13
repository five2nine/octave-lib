function formatted_str = fmt(fmt_str)
    % fmt 함수는 Python의 f-string과 유사하게 중괄호 {변수명}을 사용하여
    % 문자열 내에서 변수를 치환하는 함수입니다.
    %
    % 입력:
    % fmt_str - 포맷팅할 문자열 (예: 'Name: {name}, Age: {age}')
    %
    % 출력:
    % formatted_str - 포맷팅된 결과 문자열
    %
    % 설명:
    %   - 입력된 문자열 내에서 중괄호({}) 안에 있는 변수명을 찾아,
    %     호출된 환경에서 해당 변수의 값을 가져와 치환합니다.
    %   - 만약 변수가 숫자라면 문자열로 변환하여 출력합니다.
    %   - 변수명이 정의되지 않으면 오류 메시지가 출력됩니다.
    %
    % 사용 예시:
    %   name = 'Alice';
    %   age = 30;
    %   formatted_str = fmt('Name: {name}, Age: {age}');
    %   disp(formatted_str);
    % 
    % 결과: 
    % 'Name: Alice, Age: 30'
    % 
    % 사용 예시:
    %   name = "Alice";
    %   age = 25;
    %   height = 168.5;
    %   printf(colored("Candidate\n", "#FF5733"))
    %   printf(colored(fmt("- Name: {name}\n- Age: {age}\n- Height: {height} cm\n")))
    % 
    % 결과: 
    % Candidate가 빨간색으로 출력되고,
    % - Name: Alice
    % - Age: 25
    % - Height: 168.5 cm가 출력됨

    % 중괄호 안의 변수명을 추출 (정규 표현식 사용)
    tokens = regexp(fmt_str, '\{([^}]+)\}', 'tokens');
    
    % 추출된 변수명에 대해 반복
    for i = 1:length(tokens)
        varname = tokens{i}{1};  % 변수명 가져오기
        
        % 호출된 환경에서 해당 변수의 값을 가져오기
        try
            var_value = evalin("caller", varname);
        catch
            error("Undefined variable: %s", varname);  % 변수명이 정의되지 않으면 오류 발생
        end
        
        % 만약 값이 숫자라면 문자열로 변환
        if isnumeric(var_value)
            var_value = num2str(var_value);
        end
        
        % 원본 문자열에서 `{변수}`를 실제 값으로 치환
        fmt_str = strrep(fmt_str, ['{' varname '}'], var_value);
    end
    
    % 포맷팅된 문자열을 반환
    formatted_str = fmt_str;
end
