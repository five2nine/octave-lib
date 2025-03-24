function h1 = textd(varargin)
    % plotd: plot 함수의 확장 버전
    % varargin: ax, x, y, 그리고 사용자 정의 옵션

    % 입력 인자 개수 확인
    n = nargin;

    % 첫 번째 인자가 axes 핸들인지 확인
    if n >= 1 && length(varargin{1})==1 && isaxes(varargin{1})
        ax = varargin{1};
        varargin(1) = [];
    else
        ax = gca;
    end

    % x, y 값 설정
    if n >= 3
        x = varargin{1};
        varargin(1) = [];
        y = varargin{1};
        varargin(1) = [];
        t = varargin{1};
        varargin(1) = [];
    else
        error('x, y 값이 필요합니다.');
    end

    % 파라미터 파싱 (일반 옵션만 저장)
    p = inputParser;
    p.CaseSensitive = false;
    addParameter(p, 'Units', 'Normalized', @ischar);
    addParameter(p, 'FontSize', 20, @isnumeric);
    addParameter(p, 'FontWeight', 'normal', @ischar);
    addParameter(p, 'Interpreter', 'none', @ischar);
    addParameter(p, 'Color', hex2color("#293134"), @ischar);
    parse(p, varargin{:});

    % 파라미터 설정
    units = p.Results.Units;
    fontSize = p.Results.FontSize;
    fontWeight = p.Results.FontWeight;
    interpreter = p.Results.Interpreter;
    color = p.Results.Color;

    % 추가 옵션 저장
    param_t0 = varargin(~ismember(varargin, fieldnames(p.Results)));

    % 파라미터 묶기
    param_t1 = {"Units", units, "FontSize", fontSize, "FontWeight", fontWeight, "Interpreter", interpreter, "Color", color};

    % 파라미터 합치기
    param_t = [param_t0, param_t1];

    % 텍스트 그리기
    h1 = text(ax, x, y, t, param_t{:});
end
