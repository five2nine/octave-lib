function [fig, axes] = subplots(nrows, ncols, paramf, parama)
    % subplots - 다중 서브플롯을 생성하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   nrows      - 서브플롯의 행 개수 (기본값: 1)
    %   ncols      - 서브플롯의 열 개수 (기본값: 1)
    %   paramf  - figure 설정을 위한 파라미터 리스트 (셀 배열, 기본값: {})
    %   parama - axes 설정을 위한 파라미터 리스트 (셀 배열, 기본값: {})
    %
    % 출력:
    %   fig  - 생성된 figure 핸들
    %   axes - 생성된 서브플롯의 axes 핸들 (nrows x ncols 행렬)
    %
    % 설명:
    %   - 지정된 행(nrows)과 열(ncols) 크기로 서브플롯을 배치함
    %   - subplot 인덱스는 C 언어 스타일(행 우선) 순서로 배치됨
    %   - fig의 ID는 무작위로 생성됨 (hex 값 범위: F000 ~ FFFF)
    %   - nrows, ncols, paramf, param_axes가 없을 경우 기본값을 사용
    %
    % 사용 예시:
    %   [fig, axes] = subplots();           % 1x1 서브플롯 생성
    %   [fig, axes] = subplots(2, 3);       % 2x3 서브플롯 생성
    %   [fig, axes] = subplots(2, 3, {'Size', [800, 600]});
    %   [fig, axes] = subplots(2, 3, {'Size', [800, 600]}, {'XGrid', 'on'});

    if nargin < 1, nrows = 1; end
    if nargin < 2, ncols = 1; end
    if nargin < 3, paramf = {"Size", [720, 480]}; end
    if nargin < 4, parama = {"FontSize", 16, "NextPlot", "add", "XGrid", "on", "YGrid", "on"}; end

    % figure 생성
    fig = createCenteredFigure(paramf{:});
    
    % axes 핸들 저장용 행렬 초기화
    axes = zeros(nrows, ncols);
    
    % 서브플롯 생성 및 axes 핸들 저장
    # axes 인덱스는 Fortran 방식 subplot 인덱스는 C 방식
    for j = 1:ncols
        for i = 1:nrows
            ax = subplot(nrows, ncols, ncols * (i - 1) + j, "parent", fig, parama{:});
            axes(i, j) = ax;
        end
    end

end
