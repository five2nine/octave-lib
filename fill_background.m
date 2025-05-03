function fill_background(ax, varargin)
    # fill_background: axes 내부에 fill 영역을 그리는 함수
    # 새로운 axes 생성하므로 기존 axes에 영향을 주지 않느다.
    # ax: axes 핸들
    # varargin: fill 영역 그리기를 위한 인자
    # XLim, YLim, Color, FaceAlpha
    # Sample
    # fill_background(ax(1, 1));
    # fill_background(ax(1, 1), "Ylim", [0, get(ax(1, 1), "YLim")(2)], "Color", h2c("#FAD466"), "FaceAlpha", 0.05);
    # fill_background(ax(1, 1), "Ylim", [get(ax(1, 1), "YLim")(1), 0], "Color", h2c("#327EEF"), "FaceAlpha", 0.05);

    xlim = get(ax, "XLim");
    ylim = get(ax, "YLim");
    color = h2c("#327EEF");
    facealpha = 0.1;

    for k = 1:2:length(varargin)
        key = varargin{k};
        val = varargin{k+1};

        switch lower(key)
            case "xlim"
                xlim = val;
            case "ylim"
                ylim = val;
            case "color"
                color = val;
            case "facealpha"
                facealpha = val;
        end
    end

    ax_fill = axes("Position", get(ax, "Position"));

    # LB -> RB -> -> RT -> LT
    fill(ax_fill, [xlim(1) xlim(2) xlim(2) xlim(1)], ...
        [ylim(1) ylim(1) ylim(2) ylim(2)], ...
        color, "FaceAlpha", facealpha, "EdgeColor", "none"
    );
    
    set(ax_fill, ...
        "XLim", get(ax, "XLim"), ...
        "YLim", get(ax, "YLim"), ...
        "XScale", get(ax, "XScale"), ...
        "YScale", get(ax, "YScale"), ...
        "Position", get(ax, "Position"), ...
        "Color", "none", "XTick", [], "YTick", [], "Box", "off"
    );
end
