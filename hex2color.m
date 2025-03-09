function rgb = hex2color(hex)
    % hex2color - HEX 색상 코드를 [R G B]로 변환하는 함수
    %
    % 지원:
    %   Matlab and Octave
    %
    % 입력:
    %   hex - HEX 색상 코드 (예: "#RRGGBB" 또는 "RRGGBB")
    %
    % 출력:
    %   rgb - [R G B] 형태의 색상 배열 (0~1 범위)
    %
    % 사용 예:
    %   rgb = hex2color("#3498db") % 결과: [0.2039 0.5961 0.8588]

    % '#' 제거
    hex = strrep(hex, '#', '');

    % 16진수를 0~1 범위로 변환
    r = hex2dec(hex(1:2)) / 255;
    g = hex2dec(hex(3:4)) / 255;
    b = hex2dec(hex(5:6)) / 255;

    % RGB 값 반환
    rgb = [r, g, b];
end
