function param = default_param()
    % default_param 함수는 그래픽 객체의 다양한 속성을 저장하는 구조체를 반환합니다.
    % 각 파라미터 그룹은 특정 그래픽 요소에 대한 속성 설정을 포함합니다.
    
    % Axes 속성 설정 (폰트 크기, 플롯 모드, 그리드 설정)
    color_base = [
        h2c("#69A1FA"), % 파란색
        h2c("#CF87DA"), % 보라색
        h2c("#00CC6A"), % 녹색
        h2c("#FADB79"), % 노란색
        h2c("#5678C5"), % 조금 더 진한 파란색
        h2c("#A84AC5"), % 깊은 보라색
        h2c("#00B85A"), % 진한 녹색
        h2c("#E5C441"), % 진한 노란색
        h2c("#508BD1"), % 회색이 섞인 파란색
        h2c("#9A59D7")  % 고급스러운 보라색
    ];
    color_pastel = [
        h2c("#A7C7E7"); % 연한 파란색
        h2c("#D8BFD8"); % 연보라색 (라벤더)
        h2c("#A1D6A1"); % 연한 녹색
        h2c("#F9E79F"); % 연한 노란색
        h2c("#F7A1A1"); % 연한 분홍색
        h2c("#C3B1E1"); % 연한 퍼플
        h2c("#AFE1AF"); % 연한 민트색
        h2c("#FAD2A5"); % 살구색
        h2c("#B0E0E6"); % 연한 청록색 (파우더 블루)
        h2c("#F5CBA7")  % 연한 오렌지색
    ];
    color_vibrant = [
        h2c("#5678C5"), % 조금 더 진한 파란색
        h2c("#A84AC5"), % 깊은 보라색
        h2c("#00B85A"), % 진한 녹색
        h2c("#E5C441"), % 진한 노란색
        h2c("#508BD1"), % 회색이 섞인 파란색
        h2c("#9A59D7"), % 고급스러운 보라색
        h2c("#FF5733"), % 강렬한 오렌지색
        h2c("#D72E6A"), % 강렬한 분홍색
        h2c("#FFC300"), % 밝은 노란색
        h2c("#FF1493")  % 딥핑크
    ];

    % 각 파라미터 그룹은 특정 그래픽 요소에 대한 속성 설정을 포함합니다.

    % Figure 속성 설정 (크기, 이동 위치, 제목)
    param_f1 = {"Size", [1280, 720], "Move", [0, 0], "Name", "Figure", "NumberTitle", "off"};

    param_a1 = {"NextPlot", "add", "XGrid", "on", "YGrid", "on", "ColorOrder", color_base};
    param_a2 = {"FontSize", 14, "Xlabel", "Time [sec]", "Ylabel", "Amplitude"};
    param_a3 = {"FontSize", 14, "Xlabel", "Frequency [Hz]", "Ylabel", "Amplitude"};
    
    % Plot 속성 설정 (선 두께)
    param_p1 = {"Linewidth", 1.2};

    % Legend 속성 설정 (테두리, 색상, 엣지 색상)
    param_l1 = {"Box", "on", "Color", "none", "EdgeColor", hex2color("#C0C0C0")};

    % Text 속성 설정 (정렬, 폰트 크기, 굵기, 색상, 해석기 설정)
    param_t1 = {"Units", "Normalized", "FontSize", 14, "FontWeight", "bold"};
    param_t2 = {"Interpreter", "none", "Color", hex2color("#293134")};

    % 구조체에 각 파라미터 그룹 저장
    param.f = param_f1;
    param.at = [param_a1, param_a2];
    param.af = [param_a1, param_a3];
    param.p = param_p1;
    param.l = param_l1;
    param.t = [param_t1, param_t2];
end
