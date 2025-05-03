function set_axes_shrink(ax, ratio)
    # 대상 축의 가로폭을 줄임

    if nargin < 2
        ratio = 0.88;
    end

    position = get(ax, "Position");
    position(3) = position(3) * ratio;
    set(ax, "Position", position);

end
