function fig = createCenteredFigure(figNumber, varargin)
    % createCenteredFigure - Octave용 figure 창을 중앙에 위치시키고 크기를 설정하는 함수
    %
    % 입력:
    %   figNumber: figure 번호
    %   옵션 (varargin):
    %       'Width'  - 창의 너비 (기본값: 800)
    %       'Height' - 창의 높이 (기본값: 600)
    %       'Title'  - 창의 제목 (기본값: 'noname')
    %       'Color'  - 배경색 ([R G B] 형식의 0~1 범위 실수 벡터)
    %
    % 사용 예:
    %   createCenteredFigure(1)
    %   createCenteredFigure(2, 1024, 768) % 첫 두 개 숫자는 너비, 높이로 간주
    %   createCenteredFigure(3, "Title", "My Title", "Color", [0.2 0.6 0.8])
    %   createCenteredFigure(4, 960, 720, "Title", mp4name)
    %
    % 설명:
    %   - figure 창을 화면 중앙에 배치하고 크기를 설정함
    %   - 기존 figure가 존재하면 닫고 새로 생성함
    %   - 옵션을 사용하여 제목과 배경색을 설정할 수 있음
    %   - 배경색은 [R G B] 형식의 0~1 범위 실수 벡터로만 설정 가능
    %   - 그림 번호는 제목에 표시하지 않음

    % 기본값 설정
    w = 800;
    h = 600;
    titleStr = "noname";
    bgColor = [1 1 1];

    % 첫 두 개 인자가 숫자면 Width, Height로 간주
    if length(varargin) >= 2 && isnumeric(varargin{1}) && isnumeric(varargin{2})
        w = varargin{1};
        h = varargin{2};
        varargin(1:2) = []; % 처리된 인자 제거
    end

    % 옵션 처리
    for i = 1:2:length(varargin)

        switch lower(varargin{i})
            case "width"
                w = varargin{i + 1};
            case "height"
                h = varargin{i + 1};
            case "title"
                titleStr = varargin{i + 1};
            case "color"
                bgColor = varargin{i + 1};
        end

    end

    % 기존 figure가 존재하면 닫기
    if ishandle(figNumber)
        close(figNumber);
    end

    % 화면 크기 가져오기
    screenSize = get(0, "ScreenSize");
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);

    % 중앙 위치 계산
    windowLeft = (screenWidth - w) / 2;
    windowBottom = (screenHeight - h) / 2;

    % figure 생성 및 설정
    fig = figure(figNumber);
    set(fig, "Position", [windowLeft, windowBottom, w, h]);
    set(fig, "Color", bgColor);
    set(fig, "Name", titleStr, "NumberTitle", "off");
end
