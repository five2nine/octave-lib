function [fig, axes] = subplots(nrows, ncols, param_fig, param_axes)
    % subplots - 다중 서브플롯을 생성하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   nrows      - 서브플롯의 행 개수
    %   ncols      - 서브플롯의 열 개수
    %   param_fig  - figure 설정을 위한 파라미터 리스트 (셀 배열)
    %   param_axes - axes 설정을 위한 파라미터 리스트 (셀 배열)
    %
    % 출력:
    %   fig  - 생성된 figure 핸들
    %   axes - 생성된 서브플롯의 axes 핸들 (nrows x ncols 행렬)
    %
    % 설명:
    %   - 지정된 행(nrows)과 열(ncols) 크기로 서브플롯을 배치함
    %   - subplot 인덱스는 C 언어 스타일(행 우선) 순서로 배치됨
    %   - fig의 ID는 무작위로 생성됨 (hex 값 범위: F000 ~ FFFF)
    %
    % 사용 예시:
    %   [fig, ax] = subplots(2, 3, {'Size', [800, 600]}, {'XGrid', 'on'});
    %   plot(ax(1,1), x, y);
    %   title(ax(1,1), 'Plot 1');
    
    % 랜덤한 figure ID 생성
    figid = randi([hex2dec('F000'), hex2dec('FFFF')]);
    
    % figure 생성
    fig = createCenteredFigure(figid, param_fig{:});
    
    % axes 핸들 저장용 행렬 초기화
    axes = zeros(nrows, ncols);
    
    % 서브플롯 생성 및 axes 핸들 저장
    for i = 1:nrows
        for j = 1:ncols
            ax = subplot(nrows, ncols, ncols * (i - 1) + j, "parent", fig, param_axes{:});
            axes(i, j) = ax;
        end
    end
end
