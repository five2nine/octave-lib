function rgb = h2c(hex)
    % h2c - HEX 색상 코드를 [R G B] 값으로 변환하는 함수
    %
    % 설명:
    %   - hex2color(hex) 함수를 호출하여 HEX 색상 코드를 RGB로 변환합니다.
    %   - 별도의 추가 처리 없이 hex2color의 반환값을 그대로 반환합니다.
    %
    % 입력:
    %   hex - HEX 색상 코드 (예: "#RRGGBB" 또는 "RRGGBB")
    %
    % 출력:
    %   rgb - [R G B] 형태의 색상 배열 (0~1 범위)
    %
    % 사용 예:
    %   rgb = h2c("#FF5733") % 결과: [1.0000 0.3412 0.2000]

    rgb = hex2color(hex);
end
