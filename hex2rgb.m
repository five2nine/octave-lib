function rgb = hex2rgb(hex)
    % hex2rgb - Octave용 HEX 색상 코드를 [R G B]로 변환하는 함수
    %
    % 입력:
    %   hex - HEX 색상 코드 (예: "#RRGGBB" 또는 "RRGGBB")
    %
    % 출력:
    %   rgb - [R G B] 형태의 색상 배열 (0~1 범위)
    %
    % 사용 예:
    %   rgb = hex2rgb("#3498db") % 결과: [0.2039 0.5961 0.8588]

    if hex(1) == "#"
        hex = hex(2:end); % '#' 제거
    end

    rgb = [hex2dec(hex(1:2)), hex2dec(hex(3:4)), hex2dec(hex(5:6))] / 255;
end
