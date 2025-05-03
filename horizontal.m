function horizontal(ax, y, varargin)
    % horizontal: 수평선을 그리는 함수
    % ax: axes 핸들
    % y: y 위치
    % Sample
    % horizontal(ax(1, 1), 0.0);
    % horizontal(ax(1, 1), 0.0, "Color", [1.0, 0.0, 0.0], "Linestyle", ":", "Linewidth", 1.0);

    line(ax, "XData", get(ax, "XLim"), "YData", [y, y], varargin{:});
end
