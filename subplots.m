function [fig, axes] = subplots(nrows, ncols, varargin)
    % subplots - 다중 서브플롯을 생성하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   nrows      - 서브플롯의 행 개수 (기본값: 1)
    %   ncols      - 서브플롯의 열 개수 (기본값: 1)
    %   varargin - figure 설정 및 axes 설정을 위한 파라미터 리스트 (기본값: {})
    %
    % 출력:
    %   axes - 생성된 서브플롯의 axes 핸들 (nrows x ncols 행렬)
    %
    % 설명:
    %   - 지정된 행(nrows)과 열(ncols) 크기로 서브플롯을 배치함
    %   - subplot 인덱스는 C 언어 스타일(행 우선) 순서로 배치됨
    %   - nrows, ncols, varargin 없을 경우 기본값을 사용
    %
    % 사용 예시:
    %   [fig, axes] = subplots();           % 1x1 서브플롯 생성
    %   [fig, axes] = subplots(2, 3);       % 2x3 서브플롯 생성
    %   [fig, axes] = subplots(2, 3, {'XGrid', 'on'}); % axes 설정

    color_base = [
        h2c("#69A1FA"), % 파란색
        h2c("#CF87DA"), % 보라색
        h2c("#00CC6A"), % 녹색
        h2c("#FADB79"), % 노란색
        h2c("#5678C5"), % 조금 더 진한 파란색
        h2c("#A84AC5"), % 깊은 보라색
        h2c("#00B85A"), % 진한 녹색
        h2c("#E5C441"), % 진한 노란색
        h2c("#508BD1"), % 회색이 섞인 파란색
        h2c("#9A59D7")  % 고급스러운 보라색
    ];

    % 기본값 설정
    if nargin < 2
        nrows = 1;
        ncols = 1;
    end
    disp("varargin")
    disp(varargin)

    % 파라미터 파싱
    p = inputParser;
    p.CaseSensitive = false;
    addParameter(p, 'FontSize', 20, @(x) isnumeric(x) && isscalar(x)); % 기본값: 16
    addParameter(p, 'NextPlot', 'add', @(x) ischar(x) && ismember(x, {'replace', 'add', 'new'})); % 기본값: 'add'
    addParameter(p, 'XGrid', 'on', @(x) ischar(x) && ismember(x, {'on', 'off'})); % 기본값: 'on'
    addParameter(p, 'YGrid', 'on', @(x) ischar(x) && ismember(x, {'on', 'off'})); % 기본값: 'on'
    addParameter(p, 'Xlabel', 'Time [sec]', @ischar);  % 기본값: 'x'
    addParameter(p, 'Ylabel', 'Amplitude', @ischar);  % 기본값: 'y'
    addParameter(p, 'ColorOrder', color_base, @(x) ismatrix(x) && size(x, 2) == 3);  % 기본값: color_base (RGB 배열)

    parse(p, varargin{:});

    % 파라미터 설정
    fontSize = p.Results.FontSize;
    nextPlot = p.Results.NextPlot;
    xGrid = p.Results.XGrid;
    yGrid = p.Results.YGrid;
    xLabel = p.Results.Xlabel;
    yLabel = p.Results.Ylabel;
    colorOrder = p.Results.ColorOrder;

    % 추가 옵션 저장
    param_a0 = varargin(~ismember(varargin, fieldnames(p.Results)));
    disp("param_a0")
    disp(param_a0)

    % 파라미터 묶기
    param_a1 = {'FontSize', fontSize, 'NextPlot', nextPlot, 'XGrid', xGrid, 'YGrid', yGrid};
    param_a2 = {'Xlabel', xLabel, 'Ylabel', yLabel, 'ColorOrder', colorOrder};

    % 파라미터 합치기
    param_a = [param_a0, param_a1, param_a2];

    % figure 생성
    fig = figured;  % 기본 설정을 가진 figure

    % axes 핸들 저장용 행렬 초기화
    axes = zeros(nrows, ncols);

    % 서브플롯 생성 및 axes 핸들 저장
    for j = 1:ncols
        for i = 1:nrows
            ax = subplot(nrows, ncols, ncols * (i - 1) + j, param_a{:});
            axes(i, j) = ax;
        end
    end

end
