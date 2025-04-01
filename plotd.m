function h1 = plotd(varargin)
    % plotd: plot 함수의 확장 버전으로, x, y 데이터를 플로팅하고
    %        추가적으로 사용자 지정 옵션과 레전드를 처리하는 함수입니다.
    %
    % 지원:
    %   Octave
    %
    %
    % 입력:
    %   varargin - 다양한 입력 인자들
    %             - 첫 번째 인자: axes 핸들 (선택사항)
    %             - 두 번째와 세 번째 인자: x, y 데이터
    %             - 나머지 인자들: 사용자 정의 plot 옵션 (예: 'LineWidth', 2)
    %
    % 출력:
    %   h1 - 플로팅된 그래프의 핸들
    %
    % 설명:
    %   - 첫 번째 인자가 axes 핸들인 경우 해당 axes에 그래프를 그립니다.
    %   - x와 y 데이터는 두 번째와 세 번째 인자로 입력받습니다.
    %   - 사용자 지정 plot 옵션을 추가적으로 처리하고, 자동으로 레전드를 생성합니다.
    %   - 만약 'DisplayName'이 포함되면 이를 레전드에 자동으로 반영합니다.
    %   - 세미콜론으로 감싸진 문자열을 레전드 텍스트로 사용합니다.
    %
    % 사용 예시:
    %   % 기본 플로팅 예시
    %   plotd(x, y);
    %
    %   % 사용자 정의 옵션과 레전드를 포함한 플로팅 예시
    %   plotd(gca, x, y, 'LineWidth', 2, 'DisplayName', 'My Data');
    %   % 여기서 'My Data'는 레전드에 자동으로 추가됩니다.
    %
    %   % 세미콜론으로 감싸진 레전드 텍스트 예시
    %   plotd(x, y, ';Custom Legend;');
    %   % 'Custom Legend'가 레전드로 추가됩니다.
    
    % 첫 번째 인자가 axes 핸들인지 확인
    if nargin >= 1 && length(varargin{1})==1 && isaxes(varargin{1})
        ax = varargin{1};
        varargin(1) = [];
    else
        ax = gca;
    end

    if nargin >= 2
        % 나머지의 첫 번째와 두 번째 인자는 x와 y로 할당
        x = varargin{1};
        y = varargin{2};
        varargin([1, 2]) = [];
    else
        error('x, y 값이 필요합니다.');
    end

    % 자동 레전드 형식 추출
    [varargin, legend_texts] = extract_semi_colon_string(varargin);

    % 자동 플롯 패턴 (색상, 마커, 라인 스타일)
    [varargin, style_texts] = extract_plot_style_string(varargin);

    % 기본 plot 파라미터
    param_p = {"LineWidth", 1.2};
    
    % 사용자 지정 인자와 병합
    param_p = merge_params(param_p, varargin);

    % DisplayName -> 자동 레전드
    idx = find(strcmp(param_p(1:2:end), "DisplayName"), 1);
    if ~isempty(idx)
        display_name = param_p{2*idx};
        param_p([2*idx-1, 2*idx]) = [];
        # param_p = [param_p, [";", display_name, ";"]];
        param_p = [param_p, "DisplayName", display_name];
    elseif ~isempty(legend_texts)
        display_name = legend_texts{1};
        # param_p = [param_p, [";", display_name, ";"]];
        param_p = [param_p, "DisplayName", display_name];
    end
    if ~isempty(style_texts)
        param_p = [param_p, [style_texts]];
    end

    % 플로팅 실행
    h1 = plot(ax, x, y, param_p{:});
    legend();
end


function [filtered_varargin, legend_texts] = extract_semi_colon_string(varargin)
    % extract_semi_colon_string - 세미콜론으로 감싸진 문자열을 추출하고 나머지 인자들을 필터링하는 함수
    %
    % 입력:
    %   varargin - 다양한 입력 인자들
    %
    % 출력:
    %   filtered_varargin - 세미콜론으로 감싸지지 않은 나머지 인자들
    %   legend_texts - 세미콜론으로 감싸진 문자열들의 셀 배열 (있다면)
    %
    % 설명:
    %   - 입력 인자 중 앞뒤에 세미콜론이 있는 문자열들을 추출하여 legend_text에 저장
    %   - 나머지 인자들은 filtered_varargin에 저장하여 반환
    %
    % 사용 예시:
    %   [filtered_varargin, legend_texts] = extract_semi_colon_string('param1', ';myString;', 'param2');
    %   % filtered_varargin = {'param1', 'param2'}
    %   % legend_texts = {'myString'}

    % varargin이 셀 배열인 경우 이를 평탄화
    if length(varargin) == 1 && iscell(varargin{1})
        varargin = varargin{1};
    end

    % 초기화
    filtered_varargin = {};
    legend_texts = {};

    % 입력 인자 처리
    for i = 1:length(varargin)
        % 세미콜론으로 감싸진 문자열 처리
        if ischar(varargin{i}) && startsWith(varargin{i}, ";") && endsWith(varargin{i}, ";")
            legend_texts{end+1} = varargin{i}(2:end-1);  % 세미콜론 제거 후 저장
        else
            filtered_varargin{end+1} = varargin{i};
        end
    end
end

function [varargin, plot_style_texts] = extract_plot_style_string(varargin)
    % extract_plot_style_string - varargin에서 색상, 마커, 라인스타일을 포함하는 스타일 문자열을 추출하는 함수
    %
    % 입력:
    %   varargin - 다양한 입력 인자들 (셀 배열 또는 단일 인자들)
    %
    % 출력:
    %   varargin - 스타일 문자열을 제외한 나머지 인자들
    %   plot_style_texts - 추출된 스타일 문자열 (색상, 마커, 라인스타일 포함; 없으면 빈 문자열)
    %
    % 설명:
    %   - 입력 인자 중 첫 번째로 발견되는 색상, 마커, 라인스타일을 포함하는 스타일 문자열을 추출하여 plot_style_texts에 저장
    %   - 나머지 인자들은 varargin에 남겨두고 반환
    %
    % 사용 예시:
    %   [varargin, plot_style_texts] = extract_plot_style_string('ro-', 'LineWidth', 2, 'Color', 'b');
    %   % varargin = {'LineWidth', 2, 'Color', 'b'}
    %   % plot_style_texts = 'ro-'
    %
    %   [varargin, plot_style_texts] = extract_plot_style_string({"LineWidth", 2, "r*-"});
    %   % varargin = {'LineWidth', 2}
    %   % plot_style_texts = 'r*-'
    
    % varargin이 셀 배열인 경우 이를 평탄화
    if length(varargin) == 1 && iscell(varargin{1})
        varargin = varargin{1};
    end

    % 색상 패턴 (bgrcmykw)
    color_pattern = '[bgrcmykw]';
    % 마커 패턴 (.+ox*sdv^<>ph)
    marker_pattern = '[\.\+ox\*sdv\^<>ph]';
    % 라인 스타일 패턴 (-, --, :, -.)
    linestyle_pattern = '(-{1,2}|:|-\.)';

    % 초기화
    plot_style_texts = "";

    % varargin을 순회하며 첫 번째 스타일 문자열 찾기
    for i = 1:length(varargin)
        arg = varargin{i};
        if ischar(arg) || isstring(arg) % 문자열인지 확인
            % 포함된 요소 개수 판정
            num_elements = 0;
            if !isempty(regexp(arg, color_pattern, "match", "once"))
                num_elements += 1;
            end
            if !isempty(regexp(arg, marker_pattern, "match", "once"))
                num_elements += 1;
            end
            if !isempty(regexp(arg, linestyle_pattern, "match", "once"))
                num_elements += 1;
            end

            % 유효한 스타일 문자열이면 추출 후 종료
            if num_elements >= 1 && num_elements <= 3
                plot_style_texts = arg;
                varargin(i) = []; % 해당 요소 제거
                return;
            end
        end
    end
end
