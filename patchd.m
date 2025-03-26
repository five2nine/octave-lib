function h1 = patchd(varargin)
    % patchd: patch 함수의 확장 버전으로, 다각형 패치를 생성하고
    %         사용자 지정 옵션과 레전드를 처리하는 함수입니다.
    %
    % 지원:
    %   Octave
    %
    % 입력:
    %   varargin - 다양한 입력 인자들
    %             - 첫 번째 인자: axes 핸들 (선택사항)
    %             - 이후 인자들: 'Vertices' 및 'Faces'를 포함한 패치 속성들
    %
    % 출력:
    %   h1 - 생성된 패치 객체의 핸들
    %
    % 설명:
    %   - 첫 번째 인자가 axes 핸들인 경우 해당 axes에 패치를 그립니다.
    %   - 'Vertices'와 'Faces'는 필수 입력값입니다.
    %   - 사용자 지정 patch 옵션을 추가적으로 처리하고, 자동으로 레전드를 생성합니다.
    %
    % 사용 예시:
    %   h1 = patchd(ax, "Vertices", xyz_nod, "Faces", elm_nod);
    %   h1 = patchd("vertices", xyz_nod, "faces", elm_nod, "FaceColor", "red");
    
    % 첫 번째 인자가 axes 핸들인지 확인
    if nargin >= 1 && length(varargin{1}) == 1 && isaxes(varargin{1})
        ax = varargin{1};
        varargin(1) = [];
    else
        ax = gca;
    end

    % 필수 입력 검증을 위한 변수 초기화
    vertices = [];
    faces = [];
    
    % 'vertices'와 'faces'를 찾고 제거 (대소문자 구분 없이 비교)
    idx_to_remove = [];
    for i = 1:2:length(varargin)
        if i+1 > length(varargin)
            error("patchd: 잘못된 입력 형식입니다.");
        end
        key = lower(varargin{i}); % 키워드를 소문자로 변환
        if strcmp(key, "vertices")
            vertices = varargin{i+1};
            idx_to_remove = [idx_to_remove, i, i+1];
        elseif strcmp(key, "faces")
            faces = varargin{i+1};
            idx_to_remove = [idx_to_remove, i, i+1];
        end
    end

    % 필수 입력값 검증
    if isempty(vertices) || isempty(faces)
        error("patchd: 'Vertices'와 'Faces'는 필수 입력값입니다.");
    end

    % `varargin`에서 'vertices'와 'faces' 제거
    varargin(idx_to_remove) = [];

    % 기본 patch 파라미터 설정
    param_p = {
        "Vertices", vertices, "Faces", faces, ...
        "FaceColor", "Interp", "FaceAlpha", 1.0
    };
    % 사용자 지정 인자와 병합
    param_p = merge_params(param_p, varargin);

    % 패치 생성 실행
    h1 = patch(ax, param_p{:});
end
