function [t, x, v, a] = newmark_beta(M, C, K, F, tspan, x0, v0, dt, varargin)
    % 뉴마크-베타 방법을 사용한 동적 시스템 해석
    % M : 질량 행렬, C : 감쇠 행렬, K : 강성 행렬, F : 외력 벡터 (n x nt)
    % tspan : 시간 구간, x0 : 초기 위치, v0 : 초기 속도
    % dt : 시간 간격, varargin : (선택적) beta, gamma 값
    
    % 시스템 차원
    n = length(x0);
    
    % 시간 구간 설정
    t_start = tspan(1);
    t_end = tspan(2);
    t = t_start:dt:(t_end-dt);
    nt = length(t);
    
    % 기본값 설정
    beta_default = 1/4;  % 기본 beta 값
    gamma_default = 1/2; % 기본 gamma 값
    
    % varargin을 사용하여 beta, gamma 값을 받음
    if nargin >= 9
        beta = varargin{1};
    else
        beta = beta_default;
    end
    
    if nargin >= 10
        gamma = varargin{2};
    else
        gamma = gamma_default;
    end
    
    % 초기화
    x = zeros(n, nt);
    v = zeros(n, nt);
    a = zeros(n, nt);
    
    % 초기 조건 설정
    x(:,1) = x0;
    v(:,1) = v0;
    
    % 첫 번째 시간 단계에서 가속도 계산
    a(:,1) = M \ (F(:,1) - C*v(:,1) - K*x(:,1));  % F(:,1) 사용
    
    % 예측-수정 루프
    for i = 2:nt
        % 예측 단계
        x_pred = x(:,i-1) + dt*v(:,i-1) + (0.5 - beta)*dt^2*a(:,i-1);
        v_pred = v(:,i-1) + (1 - gamma)*dt*a(:,i-1);
        
        % 시스템의 응답 계산
        rhs = F(:,i) - C*v_pred - K*x_pred;  % F(:,i) 사용
        a(:,i) = M \ rhs;  % 가속도 계산
        v(:,i) = v_pred + gamma*dt*a(:,i);  % 속도 수정
        x(:,i) = x_pred + beta*dt^2*a(:,i);  % 위치 수정
    end
end
