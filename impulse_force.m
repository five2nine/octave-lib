function F = impulse_force(tspan, dt, impulse_span, x0)
    % 임펄시브 신호를 생성하는 함수
    % tspan : 시간 구간 [t_start, t_end]
    % dt : 시간 간격
    % impulse_span : 임펄스가 발생하는 시간 구간 [t1, t2]
    % x0 : 초기 위치 벡터 (자유도 개수에 맞춰 크기 결정)
    
    % 자유도의 개수
    dof = length(x0);
    
    % 시간 점의 개수
    nt = floor((tspan(2) - tspan(1)) / dt);
    
    % 외력 행렬 초기화
    F = zeros(dof, nt);
    
    % 시간 구간에 해당하는 인덱스 계산
    impulse_start_index = floor((impulse_span(1) - tspan(1)) / dt) + 1;
    impulse_end_index = floor((impulse_span(2) - tspan(1)) / dt) + 1;
    
    % 하프 사인 신호 생성 (t1에서 t2까지)
    time = linspace(impulse_span(1), impulse_span(2), impulse_end_index - impulse_start_index + 1);
    half_sine_wave = sin(pi * (time - impulse_span(1)) / (impulse_span(2) - impulse_span(1)));
    
    % 하프 사인 신호의 적분값을 1로 만들기 위해 크기 보정
    scaling_factor = pi / 2;
    half_sine_wave = half_sine_wave * scaling_factor;
    
    % 1번 자유도에 하프 사인 외력 적용
    F(1, impulse_start_index:impulse_end_index) = half_sine_wave;
    
end
