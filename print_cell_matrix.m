function print_cell_matrix(data, varargin)
    # print a cell matrix of {item, value, unit}
    # input:
    #   data: data matrix
    #   head: header
    #   warr: width array

    % 기본값
    head = {"Item", "Value", "Unit"};
    warr = [10, 8, 8];

    % 이름-값 쌍 처리
    for k = 1:2:length(varargin)
        key = varargin{k};
        val = varargin{k+1};

        switch lower(key)
            case 'head'
                head = val;
            case 'warr'
                warr = val;
        end
    end

    ww = warr;
    hdr = head;

    fmt_head = sprintf("%%-%ds %% %ds %%-%ds\n", ww(1), ww(2), ww(3));
    fmt_data = sprintf("%%-%ds %% %d.2f %%-%ds\n", ww(1), ww(2), ww(3));

    sep = {repmat('-', 1, ww(1)), repmat('-', 1, ww(2)), repmat('-', 1, ww(3))};
    hdr = {"Item", "Value", "Unit"};


    str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));
    str = sprintf(fmt_head, hdr{:}); printf(fmt("{str}", "#9A59D7"));
    str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));

    for i = 1:size(data, 1)
        printf(fmt_data, data{i,1}, data{i,2}, data{i,3});
    end

    str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));

end


# function print_data(data, head, warr)
#     # print a cell matrix of {item, value, unit}
#     # input:
#     #   data: data matrix
#     #   head: header
#     #   warr: width array

#     if nargin < 3
#         warr = [10, 8, 8];
#     end

#     if nargin < 2
#         head = {"Item", "Value", "Unit"};
#     end

#     ww = warr;
#     hdr = head;

#     fmt_head = sprintf("%%-%ds %% %ds %%-%ds\n", ww(1), ww(2), ww(3));
#     fmt_data = sprintf("%%-%ds %% %d.2f %%-%ds\n", ww(1), ww(2), ww(3));

#     sep = {repmat('-', 1, ww(1)), repmat('-', 1, ww(2)), repmat('-', 1, ww(3))};
#     hdr = {"Item", "Value", "Unit"};


#     str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));
#     str = sprintf(fmt_head, hdr{:}); printf(fmt("{str}", "#9A59D7"));
#     str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));

#     for i = 1:size(data, 1)
#         printf(fmt_data, data{i,1}, data{i,2}, data{i,3});
#     end

#     str = sprintf(fmt_head, sep{:}); printf(fmt("{str}", "#6B6B6B"));

# end

