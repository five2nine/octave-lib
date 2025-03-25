function merged_params = merge_params(old_params, new_params)
    % merge_params - 기존 파라미터와 새로운 파라미터를 병합하는 함수
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   old_params - 기존 파라미터 셀 배열 (key-value 쌍)
    %   new_params - 새로운 파라미터 셀 배열 (key-value 쌍)
    %
    % 출력:
    %   merged_params - 병합된 파라미터 셀 배열 (key-value 쌍)
    %
    % 설명:
    %   - 새로운 파라미터에서 기존 파라미터에 없는 키는 추가하고,
    %     기존 파라미터에 이미 있는 키는 값을 덮어씁니다.
    %   - 병합된 파라미터는 key-value 쌍을 순차적으로 하나의 셀 배열로 반환됩니다.
    %
    % 사용 예시:
    %   old_params = {'XGrid', 'on', 'YGrid', 'off'};
    %   new_params = {'YGrid', 'on', 'ZGrid', 'on'};
    %   merged_params = merge_params(old_params, new_params);
    %   % merged_params는 {'XGrid', 'on', 'YGrid', 'on', 'ZGrid', 'on'}임.

    % 기존 파라미터에서 key-value 쌍을 분리
    old_keys = old_params(1:2:end);  % 홀수 번째 인덱스는 key
    old_values = old_params(2:2:end);  % 짝수 번째 인덱스는 value
    
    % 새로운 파라미터에서 key-value 쌍을 분리
    new_keys = new_params(1:2:end);  % 홀수 번째 인덱스는 key
    new_values = new_params(2:2:end);  % 짝수 번째 인덱스는 value
    
    % 기존 파라미터에 새로운 파라미터를 병합
    for i = 1:length(new_keys)
        key = new_keys{i};
        % 기존 파라미터에서 동일한 key의 위치 찾기
        idx = find(strcmp(old_keys, key)); 
        
        if isempty(idx)
            % 새로운 key이면 기존 목록에 추가
            old_keys{end+1} = key;
            old_values{end+1} = new_values{i};
        else
            % 기존 key이면 해당 값 덮어쓰기
            old_values{idx} = new_values{i};
        end
    end
    
    % 병합된 key-value 쌍을 하나의 셀 배열로 반환
    merged_params = reshape([old_keys; old_values], 1, []);
end
