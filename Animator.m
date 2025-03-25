classdef Animator < handle
    % Animator - 시뮬레이션 애니메이션 저장 클래스
    %
    % 지원:
    %   Octave
    %
    % 속성:
    %   VideoWriterObj - VideoWriter 객체 (애니메이션 저장을 위한 핸들)
    %   FrameRate      - 애니메이션 프레임 속도 (기본값: 60)
    %   SaveFlag       - 애니메이션 저장 여부 (기본값: true)
    %
    % 메서드:
    %   Animator(filename, varargin) - 객체 생성자, 파일명과 옵션을 설정하여 초기화
    %   captureFrame()               - 현재 figure의 프레임을 캡처하여 영상에 추가
    %   close()                      - VideoWriter 객체를 닫아 파일 저장 완료
    %   delete()                     - 객체 소멸 시 자동으로 close() 실행
    %
    % 설명:
    %   - Octave에서 VideoWriter를 사용하여 동영상을 저장합니다.
    %   - captureFrame()을 호출하면 현재 figure의 화면을 캡처하여 영상에 추가합니다.
    %   - close()를 호출하면 동영상 저장을 완료하고 파일을 닫습니다.
    %   - SaveFlag가 false이면 애니메이션을 저장하지 않습니다.
    %
    % 사용 예시:
    %   anim = Animator("output.mp4", "FrameRate", 30, "SaveFlag", true);
    %   for i = 1:100
    %       plot(rand(1,10)); drawnow;
    %       anim.captureFrame();
    %   end
    %   clear anim; % 객체 삭제 시 자동으로 close() 실행

    properties
        FigureHandle % 캡처할 figure 핸들
        VideoWriterObj  % VideoWriter 객체 핸들
        FrameRate = 60; % 기본 프레임 속도
        SaveFlag = true; % 애니메이션 저장 여부
    end

    methods

        function obj = Animator(varargin)
            % Animator - 애니메이션 객체 생성자
            % 
            % 입력:
            %   filename (string) - 저장할 동영상 파일명 (기본값: "output.mp4")
            %   'FrameRate' (int) - 프레임 속도 설정
            %   'SaveFlag' (bool) - 저장 여부 설정 (true/false)
            %
            % 설명:
            %   - filename을 지정하지 않으면 기본적으로 "output.mp4"로 저장됩니다.
            %   - 'FrameRate'를 통해 프레임 속도를 조정할 수 있습니다.
            %   - 'SaveFlag'가 false이면 동영상을 저장하지 않습니다.

            % 비디오 패키지 로드
            pkg load video;

            obj.FigureHandle = gcf; % 현재 활성 figure를 저장

            if nargin == 0
                filename = "output.mp4";
            elseif nargin == 1
                filename = varargin{1};
                varargin(1) = [];
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

            % 애니메이션 저장이 활성화된 경우 VideoWriter 객체 생성
            if obj.SaveFlag
                obj.VideoWriterObj = VideoWriter(filename);
                obj.VideoWriterObj.FrameRate = obj.FrameRate;
                open(obj.VideoWriterObj);
            end
        end

        function captureFrame(obj)
            % captureFrame - 현재 figure의 프레임을 캡처하여 영상에 추가
            %
            % 설명:
            %   - 현재 활성화된 figure의 화면을 캡처하여 저장합니다.
            %   - SaveFlag가 true일 때만 실행됩니다.

            if obj.SaveFlag
                frame = getframe(obj.FigureHandle); % 특정 figure에서 캡처
                writeVideo(obj.VideoWriterObj, frame);
            end
        end

        function close(obj)
            % close - VideoWriter 객체를 닫아 파일 저장 완료
            %
            % 설명:
            %   - 저장된 동영상을 마무리하고 파일을 닫습니다.
            %   - SaveFlag가 true일 때만 실행됩니다.

            if obj.SaveFlag
                close(obj.VideoWriterObj);
            end
        end

        function delete(obj)
            % delete - 객체 소멸 시 자동으로 close() 실행
            %
            % 설명:
            %   - 객체가 삭제될 때 자동으로 close()를 호출하여 리소스를 정리합니다.

            obj.close();
        end

    end

end
