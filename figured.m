function fig = figured(varargin)
    % figured - figure 창을 중앙에 위치시키고 크기를 설정하는 함수
    %
    % 지원:
    %   Matlab and Octave
    %
    % 입력:
    %   옵션 (varargin):
    %       'Position'   - [left bottom width height] 형식의 위치 및 크기 (기본값: 없음)
    %       'Size'       - [Width Height] 형식의 크기 튜플 (기본값: [1280, 720])
    %       'Move'       - [dx, dy] 형식의 상대적 이동값 (기본값: [0, 0])
    %       'Name'       - 창의 제목 (기본값: 'Figure')
    %       'Color'      - 배경색 ([R G B] 형식의 0~1 범위 실수 벡터, 기본값: [1 1 1])
    %       'NumberTitle' - 숫자 제목 표시 여부 (true 또는 false, 기본값: false)
    %
    % 설명:
    %   - figure를 화면 중앙에 생성하고 이동 가능
    %   - 배경색과 제목을 설정 가능
    %   - figure 핸들을 반환
    %   
    % 사용 예시:
    %   fig = figured();
    %   fig = figured('Size', [800, 600]);
    %   fig = figured('Move', [200, 100]);
    %   fig = figured('NumberTitle', false);

    % 파라미터 파싱
    p = inputParser;
    p.CaseSensitive = false;
    addParameter(p, 'Position', [], @(x) isnumeric(x) && numel(x) == 4);
    addParameter(p, 'Size', [1280, 720], @(x) isnumeric(x) && numel(x) == 2 && all(x > 0));
    addParameter(p, 'Move', [0, 0], @(x) isnumeric(x) && numel(x) == 2);
    addParameter(p, 'Name', 'Figure', @ischar);
    addParameter(p, 'Color', [1 1 1], @(x) isnumeric(x) && numel(x) == 3);
    addParameter(p, 'NumberTitle', false, @(x) islogical(x) || (isnumeric(x) && ismember(x, [0, 1])));

    parse(p, varargin{:});

    % 파라미터 설정
    pos = p.Results.Position;
    sizeTuple = p.Results.Size;
    moveTuple = p.Results.Move;
    titleStr = p.Results.Name;
    bgColor = p.Results.Color;
    numberTitle = p.Results.NumberTitle;

    % 위치 및 크기 설정 (Move 기준 중앙 배치)
    screenSize = get(0, 'ScreenSize'); % [left, bottom, width, height]
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    % 중앙 기준 이동
    left = (screenWidth - sizeTuple(1)) / 2 + moveTuple(1);
    bottom = (screenHeight - sizeTuple(2)) / 2 + moveTuple(2);
    pos = [left, bottom, sizeTuple(1), sizeTuple(2)];

    % 추가 옵션 저장
    parma_f0 = varargin(~ismember(varargin, fieldnames(p.Results)));

    % 파라미터 묶기
    param_f1 = {'Position', pos, 'Color', bgColor, 'Name', titleStr, 'NumberTitle', numberTitle};

    % 파라미터 합치기
    param_f = [parma_f0, param_f1];

    % figure 생성 및 속성 설정
    fig = figure(param_f{:});
end
