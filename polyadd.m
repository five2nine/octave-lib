function poly3 = polyadd(poly1, poly2)
    % polyadd 함수는 두 다항식 poly1, poly2를 입력받아 합을 반환합니다.
    %
    % 입력:
    %   poly1 - 첫 번째 다항식 계수 벡터 (예: [1 -3 2] -> x^2 - 3x + 2)
    %   poly2 - 두 번째 다항식 계수 벡터 (예: [2 0 -1] -> 2x^2 - 1)
    %
    % 출력:
    %   poly3 - 두 다항식의 합 (poly1 + poly2)
    %
    % 예제:
    %   >> polyadd([1 -3 2], [2 0 -1])
    %   ans = [3 -3 1]
  
    % 두 다항식의 길이를 맞추기 위해 0을 추가
    len1 = length(poly1);
    len2 = length(poly2);
    
    if len1 > len2
        poly2 = [zeros(1, len1 - len2), poly2];
    elseif len2 > len1
        poly1 = [zeros(1, len2 - len1), poly1];
    end
    
    % 다항식 합 계산
    poly3 = poly1 + poly2;
  end
