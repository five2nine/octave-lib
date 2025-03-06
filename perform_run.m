function perform_run(func, varargin)
    % 이 함수는 주어진 Octave용 함수(func)의 실행 시간을 측정하고, 해당 함수의 이름과 실행 시간을 출력합니다.
    % 인수를 전달할 수 있도록 일반화되었습니다.
    %
    % 입력:
    %   func : 실행할 함수 핸들. 이 함수는 인수 없이 호출될 수 있습니다.
    %   varargin : 함수에 전달할 임의의 인수들입니다.
    %
    % 출력:
    %   없음. 함수의 실행 시간이 콘솔에 출력됩니다.
    %
    % 사용 예:
    %   perform_run(@example_function, arg1, arg2);  % 예시 함수와 인수를 전달하여 실행 시간 측정

    % 함수 핸들 'func'를 문자열로 변환하여 함수 이름을 추출
    func_name = func2str(func); % func2str: 함수 핸들을 문자열로 변환

    running_c = colored('Running', '#FF5733');
    elapsed_c = colored('Elapsed', '#FF5733');
    seconds_c = colored('seconds', '#FF5733');
    funcstr_c = colored(func_name, '#FFFF00');

    % 실행 시작 메시지 출력
    fprintf('%s "%s"\033[0m\n', running_c, funcstr_c);

    tic; % tic은 시간 측정을 시작하는 함수입니다.

    feval(func, varargin{:}); % feval을 사용해 인수를 전달하며 함수 실행

    elapsedTime = toc; % toc은 시간 측정을 종료하고 경과 시간을 반환합니다.

    elapsed_t = colored(sprintf('%.2f', elapsedTime), '#20A0F1');

    % 함수의 실행 시간 출력
    fprintf('%s "%s" %s %s\n', elapsed_c, funcstr_c, elapsed_t, seconds_c);

end
