classdef Animator < handle
    % Animator - Octave용 시뮬레이션 애니메이션 저장 클래스
    %
    % 속성:
    %   VideoWriterObj - VideoWriter 객체 (애니메이션 저장)
    %   FrameRate      - 애니메이션 프레임 속도 (기본값: 60)
    %   SaveFlag       - 애니메이션 생성 여부 (기본값: true)
    %
    % 메서드:
    %   Animator(filename, varargin) - 객체 생성자, 옵션을 설정하여 초기화
    %   captureFrame()               - 현재 figure의 프레임을 캡처하여 영상에 추가
    %   close()                      - VideoWriter 객체를 닫아 파일 저장 완료
    %
    % 설명:
    %   - Octave에서 VideoWriter를 사용하여 동영상을 저장
    %   - captureFrame() 호출 시 현재 figure의 화면을 캡처하여 영상에 추가
    %   - close()를 호출하면 동영상 저장을 완료하고 파일을 닫음
    %   - SaveFlag가 false이면 애니메이션을 저장하지 않음
    %
    % 사용 예시:
    %   anim = Animator("output.mp4", "FrameRate", 30, "SaveFlag", true);
    %   for i = 1:100
    %       plot(rand(1,10)); drawnow;
    %       anim.captureFrame();
    %   end
    %   anim.close();

    properties
        VideoWriterObj
        FrameRate = 60; % 기본 프레임 속도
        SaveFlag = true; % 애니메이션 생성 여부
    end

    methods

        function obj = Animator(filename, varargin)
            % 필수 입력 확인
            if nargin < 1
                error("파일명을 입력하세요.");
            end

            % 옵션 파싱 (varargin 직접 처리)
            for i = 1:2:length(varargin)

                switch lower(varargin{i})
                    case "framerate"
                        obj.FrameRate = varargin{i + 1};
                    case "saveflag"
                        obj.SaveFlag = varargin{i + 1};
                    otherwise
                        error("알 수 없는 옵션: %s", varargin{i});
                end

            end

            % 애니메이션 비활성화 시 VideoWriter 생성 안 함
            if obj.SaveFlag
                obj.VideoWriterObj = VideoWriter(filename);
                obj.VideoWriterObj.FrameRate = obj.FrameRate;
                open(obj.VideoWriterObj);
            end

        end

        function captureFrame(obj)

            if obj.SaveFlag
                frame = getframe(gcf);
                writeVideo(obj.VideoWriterObj, frame);
            end

        end

        function close(obj)

            if obj.SaveFlag
                close(obj.VideoWriterObj);
            end

        end

    end

end
