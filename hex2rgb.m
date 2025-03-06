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
    %   rgb - [R G B] 형태의 색상 배열 (0~1 범위)
    %
    % 사용 예:
    %   rgb = hex2rgb("#3498db") % 결과: [0.2039 0.5961 0.8588]

    % hex 색상 코드에서 '#'을 제거하고 RGB로 변환
    hex = strrep(hex, '#', '');
    r = hex2dec(hex(1:2)) / 255;
    g = hex2dec(hex(3:4)) / 255;
    b = hex2dec(hex(5:6)) / 255;
    rgb = [r, g, b];
end
