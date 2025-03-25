function fig = figured(varargin)
    % figured - 중앙 정렬 및 크기 설정이 가능한 figure 생성 함수
    %
    % 지원:
    %   - Octave
    %
    % 입력:
    %   varargin - 다양한 figure 속성을 설정하는 옵션 목록:
    %       'Position'    - [left bottom width height] 형식의 위치 및 크기 (기본값: 자동 중앙 정렬)
    %       'Size'        - [width height] 형식의 창 크기 (기본값: 화면 크기의 1/3)
    %       'Move'        - 상대적 위치 이동값 [dx dy] (기본값: [0 0])
    %       'Name'        - 창 제목 (기본값: 'Figure')
    %       'Color'       - 배경색 [R G B] 형식 (기본값: [1 1 1])
    %       'NumberTitle' - 창의 번호 표시 여부 (true 또는 false, 기본값: false)
    %
    % 출력:
    %   fig - 생성된 figure의 핸들
    %
    % 설명:
    %   - figure 창을 화면 중앙에 배치
    %   - 창 크기 및 위치를 설정 가능
    %   - 배경색 및 창 제목 설정 지원
    %   - figure 핸들을 반환
    %
    % 사용 예시:
    %   fig = figured();                        % 기본 설정으로 figure 생성
    %   fig = figured('Size', [800, 600]);      % 크기를 800x600으로 설정
    %   fig = figured('Move', [200, 100]);      % 중앙에서 200px 우측, 100px 위로 이동
    %   fig = figured('NumberTitle', false);    % 숫자 제목 숨김

    % varargin에서 첫 번째 인자가 셀 배열인 경우 처리
    if length(varargin) == 1 && iscell(varargin{1})
        varargin = varargin{1};
    end

    % 창 크기 및 위치를 설정
    screenSize = get(0, 'ScreenSize'); % [x y width height]
    screenWidth = screenSize(3);
    screenHeight = screenSize(4);
    
    sizeIdx = find(strcmp(varargin, "Size"));
    moveIdx = find(strcmp(varargin, "Move"));
    
    if ~isempty(sizeIdx) && sizeIdx < length(varargin)
        sizeVal = varargin{sizeIdx + 1};
        windowWidth = sizeVal(1);
        windowHeight = sizeVal(2);
    else
        windowWidth = floor(screenWidth / 3);
        windowHeight = floor(screenHeight / 3);
    end
    
    if ~isempty(moveIdx) && moveIdx < length(varargin)
        moveVal = varargin{moveIdx + 1};
        moveX = moveVal(1);
        moveY = moveVal(2);
    else
        moveX = 0;
        moveY = 0;
    end

    % 화면 중앙 정렬 및 이동 적용
    left = (screenWidth - windowWidth) / 2 + moveX;
    bottom = (screenHeight - windowHeight) / 2 + moveY;
    
    % 최종 position 값 설정
    position = [left, bottom, windowWidth, windowHeight];

    % 'Size' 및 'Move' 옵션 제거
    varargin([sizeIdx, sizeIdx + 1, moveIdx, moveIdx + 1]) = [];

    param_f = {
        "Position", position, "Name", "Figure", ...
        "NumberTitle", false, "Color", [1 1 1], ...
    };
    param_f = merge_params(param_f, varargin);

    % figure 생성 및 속성 적용
    fig = figure(param_f{:});
end
