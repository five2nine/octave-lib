classdef TimeTracker < handle
    % TimeTracker - 시간을 추적하고 계산하는 클래스
    % 
    % 이 클래스는 반복적인 작업에서 각 단계별 소요 시간, 예상 시간 및 남은 시간을 추적하고 
    % 이를 기반으로 진행 상황을 계산하여 표시할 수 있습니다. 
    % 또한, 시간을 기록하고 이를 파일로 저장하거나 그래프를 그릴 수 있습니다.
    %
    % 지원:
    %   Matlab
    %
    % 속성:
    %   totalIter        - 전체 반복 횟수
    %   startTime        - 시작 시간 (tic()에서 반환된 값)
    %   estimaTimerec    - 각 반복에서 예상 시간 기록 (전체 예상 시간)
    %   elapseTimerec    - 각 반복에서 소요된 시간 기록 (현재까지 경과된 시간)
    %   remainTimerec    - 각 반복에서 남은 시간 기록 (예상 전체 시간에서 경과된 시간 차이)
    %
    % 메서드:
    %   start()          - 시간 측정을 시작합니다 (tic() 호출).
    %   update(i)        - 반복 횟수 i에 맞춰 시간을 업데이트합니다.
    %   displayProgress() - 진행 상태를 출력합니다. 각 단계별 예상, 경과, 남은 시간을 표시합니다.
    %   saveTimeRecords() - 시간 기록을 파일로 저장합니다.
    %   plotTimeRecords() - 시간 기록을 그래프 형태로 표시합니다.
    % 
    % 사용 예:
    %   % 100번 반복을 추적하려는 경우
    %   tracker = TimeTracker(100);
    %   tracker.start();  % 시간 측정 시작
    %   for i = 1:100
    %       tracker.update(i);  % 매 반복마다 시간 업데이트
    %       tracker.displayProgress(i);  % 진행 상태 출력
    %   end
    %   tracker.saveTimeRecords('time_data.mat');  % 시간 기록 저장
    %   tracker.plotTimeRecords();  % 시간 기록을 그래프로 표시
    %

    properties
        totalIter        % 전체 반복 횟수
        startTime        % 시작 시간 (tic() 반환값)
        estimaTimerec    % 예상 시간 기록
        elapseTimerec    % 소요 시간 기록
        remainTimerec    % 남은 시간 기록
    end

    methods
        function obj = TimeTracker(totalIter)
            % 생성자 함수:
            % 전체 반복 횟수를 설정하고 시간 기록을 위한 배열을 초기화합니다.
            % 
            % 입력:
            %   totalIter - 전체 반복 횟수
            % 
            % 예:
            %   tracker = TimeTracker(100);  % 100번 반복을 추적
            obj.totalIter = totalIter;
            obj.estimaTimerec = zeros(1, totalIter);  % 예상 시간 배열 초기화
            obj.elapseTimerec = zeros(1, totalIter);  % 소요 시간 배열 초기화
            obj.remainTimerec = zeros(1, totalIter);  % 남은 시간 배열 초기화
        end

        function start(obj)
            % 시간 측정을 시작합니다.
            % tic() 함수로 시작 시간을 기록합니다.
            %
            % 예:
            %   tracker.start();  % 시간 측정 시작
            obj.startTime = tic;
        end

        function update(obj, i)
            % 시간 기록을 업데이트합니다.
            % 반복 횟수 `i`에 따라 예상 시간, 소요 시간 및 남은 시간을 계산하여 기록합니다.
            %
            % 입력:
            %   i - 현재 반복 횟수 (1부터 `totalIter`까지)
            % 
            % 예:
            %   tracker.update(i);  % i번째 반복에 대한 시간 업데이트
            elapsedTime = toc(obj.startTime);  % 경과 시간 계산
            estimatedTotalTime = elapsedTime / (i / obj.totalIter);  % 전체 예상 시간 계산
            remainingTime = estimatedTotalTime - elapsedTime;  % 남은 시간 계산

            % 계산된 값을 각 배열에 기록
            obj.estimaTimerec(i) = estimatedTotalTime;
            obj.elapseTimerec(i) = elapsedTime;
            obj.remainTimerec(i) = remainingTime;
        end

        function displayProgress(obj, i)
            % 진행 상태를 출력합니다.
            % 반복 `i`에 대해 예상 시간, 경과 시간, 남은 시간을 출력합니다.
            %
            % 입력:
            %   i - 현재 반복 횟수 (1부터 `totalIter`까지)
            % 
            % 예:
            %   tracker.displayProgress(i);  % 진행 상태 출력
            percentage = (i / obj.totalIter) * 100;  % 진행률 계산
            fprintf('Progress: %6.2f%% ', percentage);
            fprintf('Estimated: %.2f s ', obj.estimaTimerec(i));  % 예상 시간
            fprintf('Elapsed: %.2f s ', obj.elapseTimerec(i));  % 경과 시간
            fprintf('Remaining: %.2f s\n', obj.remainTimerec(i));  % 남은 시간
        end

        function saveTimeRecords(obj, filename)
            % 시간 기록을 파일로 저장합니다.
            % `estimaTimerec`, `elapseTimerec`, `remainTimerec`를 .mat 파일로 저장합니다.
            %
            % 입력:
            %   filename - 저장할 파일 이름 (예: 'time_data.mat')
            % 
            % 예:
            %   tracker.saveTimeRecords('time_data.mat');  % 시간 기록을 파일로 저장
            estimaTimerecLoc = obj.estimaTimerec;
            elapseTimerecLoc = obj.elapseTimerec;
            remainTimerecLoc = obj.remainTimerec;
            save(filename, 'estimaTimerecLoc', 'elapseTimerecLoc', 'remainTimerecLoc');
        end

        function plotTimeRecords(obj)
            % 시간 기록을 그래프 형태로 표시합니다.
            % Gcode Position Index에 따라 예상 시간, 경과 시간, 남은 시간을 그래프에 그립니다.
            % 
            % 예:
            %   tracker.plotTimeRecords();  % 시간 기록을 그래프로 표시
            idx = 1:length(obj.elapseTimerec);  % 시간 기록 배열의 길이를 기준으로 인덱스 생성

            % 새로운 figure 생성
            createCenteredFigure(111, 'Size', [800, 800], 'Title', 'TimeRecords', 'Color', hex2rgb('#FFFFFF'));

            % 데이터 플로팅
            hold on;
            plot(idx, obj.estimaTimerec, 'LineWidth', 1.5);
            plot(idx, obj.elapseTimerec, 'LineWidth', 1.5);
            plot(idx, obj.remainTimerec, 'LineWidth', 1.5);

            % 축 라벨
            xlabel("Gcode Position Index");
            ylabel("Time [sec]");

            % 축(FontSize 설정)
            ax = gca;  % 현재 축 가져오기
            ax.FontSize = 12;  % (Label, Tick)만 적용

            % 레전드 설정
            lgdObj = legend("estimaTimerec", "elapseTimerec", "remainTimerec");
            lgdObj.FontName = 'FiraCodeNerdFontMono-Light';
            lgdObj.FontSize = 12;
            lgdObj.FontWeight = 'bold';

            % 그래프를 깔끔하게 보이도록 설정
            hold off;
        end
    end
end
