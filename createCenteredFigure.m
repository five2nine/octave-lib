function fig = createCenteredFigure(figNumber, varargin)
    % createCenteredFigure - figure 창을 중앙에 위치시키고 크기를 설정하는 함수
    %
    % 지원:
    %   Matlab and Octave
    %
    % 입력:
    %   figNumber: figure 번호 (예: 111)
    %   옵션 (varargin):
    %       'Size'   - [Width Height] 형식의 크기 튜플 (기본값: [800, 600])
    %       'Move'   - [dx, dy] 형식의 상대적 이동값 (기본값: [0, 0])
    %       'Name'  - 창의 제목 (기본값: 'Figure')
    %       'Color'  - 배경색 ([R G B] 형식의 0~1 범위 실수 벡터, 기본값: [1 1 1])
    %
    % 설명:
    %   - 기존 figure가 존재하면 닫고 새 figure를 생성
    %   - 배경색과 제목을 설정 가능
    %   - figure 핸들을 반환
    %
    % 사용 예시:
    %   fig = createCenteredFigure(111);
    %   fig = createCenteredFigure(112, 'Size', [800, 600]);
    %   fig = createCenteredFigure(113, 'Size', [800, 600], 'Move', [200, 100]);
    %   fig = createCenteredFigure(114, 'Size', [800, 600], 'Name', 'Custom Figure', 'Color', [0.7, 0.7, 0.7]);
    # 
    # 복합 예시:
    # 
    #   설명: centeredFigure와 subplot을 직접 사용
    # 
    #   createCenteredFigure(111, "Size", [1280, 960], "Move", [-1280, 0], "Name", "Time Data");
    #   
    #   params1 = {"FontSize", 20, "NextPlot", "add", "XGrid", "on", "YGrid", "on"};
    #   params2 = {"Xlabel", "Time [sec]", "Ylabel", "Acc. [m/s^2]"};
    #   ax1 = subplot(2, 1, 1, "parent", 111, [params1 params2]{:}); labeltext1 = {};
    #   ax2 = subplot(2, 1, 2, "parent", 111, [params1 params2]{:}); labeltext2 = {};
    #   
    #   plot(ax1, tt, x1, "color", hex2color("#69A1FA"), "linewidth", 1.2); labeltext1{end+1} = varname(x1);
    #   plot(ax1, tt, x2, "color", hex2color("#CF87DA"), "linewidth", 1.2); labeltext1{end+1} = varname(x2);
    #   if ~isempty(labeltext1); legend1 = legend(ax1, labeltext1); end
    #   
    #   plot(ax2, tt, ff1, "linewidth", 1.2); labeltext2{end+1} = varname(ff1);;
    #   plot(ax2, tt, ffg, "linewidth", 1.2); labeltext2{end+1} = varname(ffg);;
    #   plot(ax2, tt, ffc, "linewidth", 1.2); labeltext2{end+1} = varname(ffc);;
    #   if ~isempty(labeltext2); legend2 = legend(ax2, labeltext2); end
    #   
    #   # Option axes(2, 1) position [left, bottom, width, height] and legend
    #   params_legend = {"Orientation", "vertical", "Location", "northeastoutside"};
    #   set(legend1, params_legend{:});
    #   set(legend2, params_legend{:});
    #   set(ax1, "Position", [0.1, 0.55, 0.78, 0.39]); # Base [0.1, 0.60, 0.8, 0.4] [left, bottom, width, height]
    #   set(ax2, "Position", [0.1, 0.08, 0.78, 0.39]); # Base [0.1, 0.10, 0.8, 0.4] [left, bottom, width, height]

    % 옵션 파싱
    p = inputParser;
    p.CaseSensitive = false;
    addRequired(p, 'figNumber', @isnumeric);
    addParameter(p, 'Size', [800, 600], @(x) isnumeric(x) && numel(x) == 2 && all(x > 0));
    addParameter(p, 'Move', [0, 0], @(x) isnumeric(x) && numel(x) == 2);
    addParameter(p, 'Name', 'Figure', @ischar);
    addParameter(p, 'Color', [1 1 1], @(x) isnumeric(x) && numel(x) == 3);

    parse(p, figNumber, varargin{:});

    % 값 할당
    sizeTuple = p.Results.Size;
    moveTuple = p.Results.Move;
    titleStr = p.Results.Name;
    bgColor = p.Results.Color;

    width = sizeTuple(1);
    height = sizeTuple(2);
    dx = moveTuple(1);
    dy = moveTuple(2);

    % 화면 중앙 위치로 자동 계산 (Move 옵션이 [0, 0]인 경우)
    screenSize = get(0, 'ScreenSize'); % [left, bottom, width, height]
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    % 창 위치 계산 (중앙 정렬)
    left = (screenWidth - width) / 2 + dx;
    bottom = (screenHeight - height) / 2 + dy;

    % 기존 figure가 존재하면 닫기
    if isvalidFigure(figNumber)
        close(figNumber);
    end

    % figure 생성 및 속성 설정
    fig = figure(figNumber);
    set(fig, 'Position', [left, bottom, width, height]);
    set(fig, 'Color', bgColor);
    set(fig, 'Name', titleStr);
    set(fig, 'NumberTitle', 'off');
end

% 유효한 figure 핸들인지 확인하는 함수
function tf = isvalidFigure(figNumber)
    tf = ishandle(figNumber) && strcmp(get(figNumber, 'Type'), 'figure');
end

