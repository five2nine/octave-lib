function names = varname(varargin)
    % varname - 변수의 이름을 문자열로 반환하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   varargin - 하나 이상의 변수 입력
    %       - 단일 변수 입력 시 해당 변수의 이름을 반환
    %       - 여러 개의 변수 입력 시 각 변수의 이름을 셀 배열로 반환
    %       - {x1, x2}와 같은 셀 배열 입력 시 변수 이름을 얻을 수 없음
    %
    % 출력:
    %   names - 변수 이름 (문자열 또는 문자열의 셀 배열)
    %
    % 설명:
    %   - Octave에서 셀 배열({x1, x2})을 함수에 전달할 때, 변수 이름을 유지할 수 없음
    %   - MATLAB 및 Octave의 `inputname`은 직접 전달된 변수의 이름만 반환 가능
    %
    % 사용 예시:
    %   a = 10; b = 20;
    %   name = varname(a)      % "a"
    %   names = varname(a, b)  % {"a", "b"}
    %   names = varname({a, b})% {"", ""} (셀 내부 변수 이름을 얻을 수 없음)
    
    % 만약 하나의 인자만 전달되었고, 그것이 셀 배열이라면
    if nargin == 1 && iscell(varargin{1})
        % 변수 이름을 가져올 수 없음 (Octave 및 MATLAB의 한계)
        names = repmat({''}, size(varargin{1}));

    elseif nargin == 1
        % 하나의 변수가 전달되면 그 변수 이름을 반환
        names = inputname(1);

    else
        % 여러 개의 인자가 전달되면, 각 변수 이름을 추출하여 셀 배열로 반환
        names = arrayfun(@inputname, 1:nargin, 'UniformOutput', false);
    end
end
