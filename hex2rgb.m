function rgb = hex2rgb(hex)
    % hex2rgb - HEX 색상 코드를 [R G B]로 변환하는 함수
    %
    % 지원:
    %   Matlab and Octave
    %
    % 입력:
    %   hex - HEX 색상 코드 (예: "#RRGGBB" 또는 "RRGGBB")
    %
    % 출력:
    %   rgb - [R G B] 형태의 색상 배열 (0~255 범위)
    %
    % 사용 예:
    %   rgb = hex2rgb("#3498db") % 결과: [52 152 219]

    % '#' 제거
    hex = strrep(hex, '#', '');

    % 16진수를 10진수로 변환
    r = hex2dec(hex(1:2));
    g = hex2dec(hex(3:4));
    b = hex2dec(hex(5:6));

    % RGB 값 반환 (0~255 범위)
    rgb = [r, g, b];
end
