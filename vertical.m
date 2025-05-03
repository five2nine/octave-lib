function vertical(ax, x, varargin)
    % vertical: 수평선을 그리는 함수
    % ax: axes 핸들
    % x: x 위치
    % Sample
    % vertical(ax(1, 1), 0.0);
    % vertical(ax(1, 1), 0.0, "Color", [1.0, 0.0, 0.0], "Linestyle", ":", "Linewidth", 1.0);

    line(ax, "XData", [x, x], "YData", get(ax, "YLim"), varargin{:});
end
