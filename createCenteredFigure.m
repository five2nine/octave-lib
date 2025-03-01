function fig = createCenteredFigure(figNumber, width, height)
    % createCenteredFigure - Octave용 figure 창을 중앙에 위치시키고 크기를 설정하는 함수
    %
    % 입력:
    %   figNumber: figure 번호 (예: 111)
    %   width: 창의 너비 (기본값: 800)
    %   height: 창의 높이 (기본값: 600)
    %
    % 설명:
    %   - 기존 figure가 존재하면 닫고 새 figure를 생성
    %   - 화면 중앙에 창을 배치
    %   - 배경색을 흰색으로 설정

    % 기본값 설정
    if nargin < 2, width = 800; end
    if nargin < 3, height = 600; end

    % 기존 figure가 존재하는지 확인하고 닫기
    if ishandle(figNumber)
        close(figNumber);
    end

    % 화면 크기 가져오기
    screenSize = get(0, "ScreenSize"); % [left, bottom, width, height]
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    % 중앙 위치 계산
    windowLeft = (screenWidth - width) / 2;
    windowBottom = (screenHeight - height) / 2;

    % figure 생성 및 설정
    fig = figure(figNumber);
    set(fig, "Position", [windowLeft, windowBottom, width, height]);
    set(fig, "Color", [1 1 1]); % 배경색을 흰색으로 설정

end
