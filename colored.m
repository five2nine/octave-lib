function outputText = colored(text, hex)
    % colored - 텍스트에 hex 색상 코드를 적용하여 ANSI escape 코드 형식으로 출력하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   text - 출력할 텍스트
    %   hex - 16진수 색상 코드 (예: '#FF5733')
    %
    % 출력:
    %   outputText - 색상 코드가 적용된 텍스트 (ANSI escape 코드 포함)
    %
    % 설명:
    %   - 주어진 hex 색상 코드를 RGB로 변환하고, 텍스트에 색상을 적용하여 출력합니다.
    %   - 이 함수는 Octave에서만 동작합니다.
    %
    % 사용 예시:
    %   result = colored('This is red text', '#FF0000');
    %   disp(result);

    % hex 색상 코드에서 '#'을 제거하고 RGB로 변환
    hex = strrep(hex, '#', '');
    r = hex2dec(hex(1:2));
    g = hex2dec(hex(3:4));
    b = hex2dec(hex(5:6));

    % 색상 코드가 적용된 텍스트 생성
    outputText = sprintf('\033[38;2;%d;%d;%dm%s\033[0m', r, g, b, text);
end
