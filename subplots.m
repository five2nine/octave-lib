function axes = subplots(varargin)
    % subplots - 다중 서브플롯을 생성하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   varargin - 서브플롯의 행(nrows)과 열(ncols) 개수 및 기타 figure 및 axes 설정을 위한 파라미터 리스트
    %     nrows    - 서브플롯의 행 개수 (기본값: 1)
    %     ncols    - 서브플롯의 열 개수 (기본값: 1)
    %     varargin - figure 및 axes 설정을 위한 추가적인 파라미터들 (기본값: {})
    %
    % 출력:
    %   axes - 생성된 서브플롯의 axes 핸들 (nrows x ncols 크기 행렬)
    %
    % 설명:
    %   - 서브플롯을 행 우선 순서(C 스타일)로 배치합니다.
    %   - nrows와 ncols가 생략되면 기본값(1)으로 설정됩니다.
    %   - varargin을 통해 figure와 axes의 추가적인 속성을 설정할 수 있습니다.
    %
    % 사용 예시:
    %   axes = subplots();                % 기본값 1x1 서브플롯 생성
    %   axes = subplots(2, 3);            % 2x3 서브플롯 생성
    %   axes = subplots(2, 3, {'XGrid', 'on'}); % X축 격자 활성화 설정

    % 기본 색상 팔레트 정의
    color_base = [
        h2c("#69A1FA"), % 파란색
        h2c("#CF87DA"), % 보라색
        h2c("#00CC6A"), % 녹색
        h2c("#FADB79"), % 노란색
        h2c("#5678C5"), % 진한 파란색
        h2c("#A84AC5"), % 깊은 보라색
        h2c("#00B85A"), % 진한 녹색
        h2c("#E5C441"), % 진한 노란색
        h2c("#508BD1"), % 회색이 섞인 파란색
        h2c("#9A59D7")  % 고급스러운 보라색
    ];
    
    % 입력 인자가 1개 이하인 경우 기본값 설정
    if nargin <= 1
        nrows = 1;
        ncols = 1;
    elseif nargin >= 2
        % 첫 번째와 두 번째 인자는 nrows와 ncols로 할당
        nrows = varargin{1};
        ncols = varargin{2};
        varargin([1, 2]) = [];
    end

    % varargin에서 첫 번째 인자가 셀 배열인 경우 처리
    if length(varargin) == 1 && iscell(varargin{1})
        varargin = varargin{1};
    end

    % 기본 figure 및 axes 설정 파라미터
    param_a = {
        "NextPlot", "add", ...
        "XGrid", "on", "YGrid", "on", "ZGrid", "on", ...
        "Xlabel", "x", "Ylabel", "y", "Zlabel", "z", ...
        "FontSize", 20, ...
        "ColorOrder", color_base, ...
    };
    % 사용자 지정 인자와 병합
    param_a = merge_params(param_a, varargin);

    % 서브플롯 axes 핸들을 저장할 행렬 초기화
    axes = zeros(nrows, ncols);

    % 서브플롯 생성 및 axes 핸들 저장
    for j = 1:ncols
        for i = 1:nrows
            ax = subplot(nrows, ncols, ncols * (i - 1) + j, param_a{:});
            axes(i, j) = ax;
        end
    end
end
