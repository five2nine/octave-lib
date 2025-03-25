function h1 = legendd(varargin)
    % legendd: 범례(legend)를 추가하는 함수로, 사용자 지정 옵션을 처리하며
    %          지정된 axes에 범례를 표시합니다.
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   varargin - 다양한 입력 인자들
    %             - 첫 번째 인자: axes 핸들 (선택사항)
    %             - 나머지 인자들: 범례 항목 리스트 및 사용자 정의 옵션
    %               - 범례 항목 리스트는 문자열 또는 문자열 셀 배열로 제공
    %               - 사용자 정의 옵션을 통해 박스, 색상, 테두리 등을 설정 가능
    %
    % 출력:
    %   h1 - 생성된 범례 객체의 핸들
    %
    % 설명:
    %   - 첫 번째 인자가 axes 핸들인 경우 해당 axes에 범례를 추가합니다.
    %   - 범례 항목은 개별 문자열 또는 문자열 셀 배열로 전달됩니다.
    %   - 기본적으로 박스가 활성화된 투명한 배경의 범례가 생성됩니다.
    %   - 추가적인 범례 속성은 varargin을 통해 지정할 수 있습니다.
    %
    % 사용 예시:
    %   % 기본 범례 추가
    %   legendd({'Data1', 'Data2'});
    %
    %   % 특정 axes에 범례 추가
    %   ax = gca;
    %   legendd(ax, {'Curve A', 'Curve B'});
    %
    %   % 사용자 정의 스타일 적용
    %   legendd({'A', 'B'}, {'Box', 'off', 'TextColor', 'blue'});

    % 첫 번째 인자가 axes 핸들인지 확인
    if nargin >= 1 && length(varargin{1}) == 1 && isaxes(varargin{1})
        ax = varargin{1};
        varargin(1) = [];
    else
        ax = gca;
    end

    if iscell(varargin{end})
        text_l = varargin(1:end-1);
        varargin = varargin{end};
    else
        text_l = varargin;
        varargin = {};
    end

    % 기본 legend 파라미터
    param_l = {
        "Box", "on", "Color", "none", "Interpreter", "none", "Location", "NorthEast", ...
        "EdgeColor", hex2color("#C0C0C0"), ...
        "TextColor", hex2color("#171717"), ...        
    };
    % 사용자 지정 인자와 병합
    param_l = merge_params(param_l, varargin);

    h1 = legend(ax, text_l{:}, param_l{:});
end
