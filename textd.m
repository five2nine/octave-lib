function h1 = textd(varargin)
    % textd: 텍스트를 플로팅하는 함수, 사용자 지정 옵션을 처리하며
    %        주어진 (x, y) 좌표에 텍스트를 표시합니다.
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   varargin - 다양한 입력 인자들
    %             - 첫 번째 인자: axes 핸들 (선택사항)
    %             - 두 번째, 세 번째, 네 번째 인자: x, y, 텍스트 문자열
    %             - 나머지 인자들: 사용자 정의 텍스트 옵션 (예: 'FontSize', 16)
    %
    % 출력:
    %   h1 - 그려진 텍스트 객체의 핸들
    %
    % 설명:
    %   - 첫 번째 인자가 axes 핸들인 경우 해당 axes에 텍스트를 그립니다.
    %   - x와 y 좌표, 텍스트 문자열을 입력받아 텍스트를 지정된 위치에 표시합니다.
    %   - 텍스트의 색상, 글꼴 크기 등은 기본값을 가지며, 추가적인 사용자 정의 옵션을 지정할 수 있습니다.
    %   - 텍스트 스타일은 기본값을 사용할 수 있으며, 나머지 옵션들은 `varargin`을 통해 처리됩니다.
    %
    % 사용 예시:
    %   % 기본 텍스트 그리기
    %   textd(x, y, 'Hello, World!');
    %
    %   % 사용자 정의 텍스트 스타일 적용 예시
    %   textd(gca, x, y, 'Custom Text', 'FontSize', 14, 'Color', 'red');
    %   % 여기서 'Custom Text'는 (x, y) 위치에 빨간색 글꼴 크기 14로 표시됩니다.
    
    % 첫 번째 인자가 axes 핸들인지 확인
    if nargin >= 1 && length(varargin{1})==1 && isaxes(varargin{1})
        ax = varargin{1};
        varargin(1) = [];
    else
        ax = gca;
    end

    % x, y 값 설정
    if nargin >= 3
        % 나머지의 첫 번째, 두 번째, 세 번째 인자는 x, y, t로 할당
        x = varargin{1};
        y = varargin{2};
        t = varargin{3};
        varargin([1, 2, 3]) = [];
    else
        error('x, y, t 값이 필요합니다.');
    end

    % 기본 text 파라미터
    param_t = {
        "Units", "Normalized", "Color", hex2color("#293134"), ...
        "FontSize", 20, "FontWeight", "normal", "Interpreter", "none"
    };

    % 사용자 지정 인자와 병합
    param_t = merge_params(param_t, varargin);

    % 텍스트 그리기
    h1 = text(ax, x, y, t, param_t{:});
end
