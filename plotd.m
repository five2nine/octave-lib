function h1 = plotd(varargin)
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
    if n >= 2
        x = varargin{1};
        varargin(1) = [];
        y = varargin{1};
        varargin(1) = [];
    else
        error('x, y 값이 필요합니다.');
    end

    % 자동 레전드 형식 추출(앞뒤 세미콜론 형식)
    filtered_varargin = {};
    single_string_param = '';

    for i = 1:length(varargin)
        if ischar(varargin{i}) && startsWith(varargin{i}, ";") && endsWith(varargin{i}, ";")
            single_string_param = varargin{i}(2:end-1);
        else
            filtered_varargin{end+1} = varargin{i};
        end
    end

    % 파라미터 파싱 (일반 옵션만 저장)
    p = inputParser;
    p.CaseSensitive = false;
    addParameter(p, 'LineWidth', 1.2, @isnumeric);
    addParameter(p, 'DisplayName', '', @ischar);
    parse(p, filtered_varargin{:});

    % 파라미터 설정
    linewidth = p.Results.LineWidth;

    % 파라미터 묶기
    param_p = {'LineWidth', linewidth};
    param_p = merge_params(param_p, filtered_varargin);

    # DisplayName 항목을 제거하고 ;display_name; 형식 추가
    idx = find(strcmp(param_p(1:2:end), "DisplayName"), 1);
    if ~isempty(idx)
        display_name = param_p{2*idx};
        param_p([2*idx-1, 2*idx]) = [];  % "DisplayName" 키와 값 제거
        param_p = [param_p, [";", display_name, ";"]];
    elseif ~isempty(single_string_param)  % 빈 문자열이 아닌 경우
        display_name = single_string_param;
        param_p = [param_p, [";", display_name, ";"]];
    end

    % 플로팅 실행
    h1 = plot(ax, x, y, param_p{:});
end

function merged_params = merge_params(default_params, user_params)
    % 기본값과 사용자 입력을 병합하는 함수
    merged_params = default_params;
    for i = 1:2:length(user_params)
        key = user_params{i};
        idx = find(strcmp(merged_params(1:2:end), key), 1); % 기존 키 검색
        if ~isempty(idx)
            merged_params{2*idx} = user_params{i+1}; % 기존 값 덮어쓰기
        else
            merged_params = [merged_params, key, user_params{i+1}]; % 새로운 키 추가
        end
    end
end
