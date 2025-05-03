function set_axes_layout(ax, vsec_ratio, hsec_ratio)
    % set_axes_layout: axes의 위치를 설정하는 함수
    % ax: axes 핸들 배열
    % vsec_ratio: 각 행의 높이 비율 (1xN 배열)
    % hsec_ratio: 각 열의 너비 비율 (1xN 배열)
    % 예시: set_axes_layout(ax, [1, 1, 1], [4, 1])
    % 2D 배열일 떄 유용함
    %
    % identity equation
    % sum(vsec_ratio) * vsec_norm + (nrow + 1) * gapratio * vsec_norm  == 1
    % sum(hsec_ratio) * hsec_norm + (ncol + 1) * gapratio * hsec_norm  == 1

    [nrow, ncol] = size(ax);  % axes의 행과 열 개수
    if nrow != length(vsec_ratio) || ncol != length(hsec_ratio)
        error("axes의 크기와 비율이 일치하지 않습니다.");
    end

    # minimum gap in normal unit (*)
    vgapmin_norm = 0.06; # 6% of figure size
    hgapmin_norm = 0.06; # 6% of figure size

    # minimum gap to section
    vgap_to_vsec_ratio = 0.10; # vgap_norm / vsec_norm
    hgap_to_hsec_ratio = 0.10; # hgap_norm / hsec_norm

    # section size evaluation
    vsec_norm = 1 / (sum(vsec_ratio) + vgap_to_vsec_ratio * (nrow + 1));
    hsec_norm = 1 / (sum(hsec_ratio) + hgap_to_hsec_ratio * (ncol + 1));

    # gap size evaluation
    vgap_norm = vgap_to_vsec_ratio * vsec_norm;
    hgap_norm = hgap_to_hsec_ratio * hsec_norm;

    # size update
    while vgap_norm < vgapmin_norm
        vgap_to_vsec_ratio = vgap_to_vsec_ratio + 0.001;
        vsec_norm = 1 / (sum(vsec_ratio) + vgap_to_vsec_ratio * (nrow + 1));
        vgap_norm = vgap_to_vsec_ratio * vsec_norm;
    end 

    # size update
    while hgap_norm < hgapmin_norm
        hgap_to_hsec_ratio = hgap_to_hsec_ratio + 0.001;
        hsec_norm = 1 / (sum(hsec_ratio) + hgap_to_hsec_ratio * (ncol + 1));
        hgap_norm = hgap_to_hsec_ratio * hsec_norm;
    end

    % 각 행의 세로 비율에 맞게 높이 계산 (normal unit considering gap)
    vfac = vsec_ratio / sum(vsec_ratio);
    vfac = vfac * (1 - 2 * vgap_norm - vgap_norm * (nrow - 1));

    % 각 열의 가로 비율에 맞게 너비 계산 (normal unit considering gap)
    hfac = hsec_ratio / sum(hsec_ratio);
    hfac = hfac * (1 - 2 * hgap_norm - hgap_norm * (ncol - 1));
    
    % axes position
    for i = 1:nrow
        for j = 1:ncol
            # LTWH [x, y, w, h]
            x = j * hgap_norm + sum(hfac(1:j-1));  # left
            y = 1 - i * vgap_norm - sum(vfac(1:i)); # bottom
            w = hfac(j);  # width
            h = vfac(i);  # height
            set(ax(i, j), "Units", "normalized", "Position", [x, y, w, h]); % 각 축의 위치 설정
        end
    end

end
