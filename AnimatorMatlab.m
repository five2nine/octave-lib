classdef AnimatorMatlab < handle
    % AnimatorMatlab - simulation animation saving class
    %
    % 지원:
    %   Matlab
    %
    % Properties:
    %   VideoWriterObj - VideoWriter object (for saving animation)
    %   FrameRate      - Animation frame rate (default: 60)
    %   SaveFlag       - Whether to save the animation (default: true)
    %
    % Methods:
    %   Animator(filename, varargin) - Constructor, initializes with options
    %   captureFrame()               - Captures the current figure frame and adds to the video
    %   close()                      - Closes the VideoWriter object and saves the file
    %   delete()                     - Automatically calls close() when object is deleted
    %
    % Description:
    %   - Uses MATLAB's built-in VideoWriter to save videos
    %   - captureFrame() adds the current figure screen to the video
    %   - close() finalizes the video and closes the file
    %   - If SaveFlag is false, no video is saved
    %
    % Example usage:
    %   anim = AnimatorMatlab("output.mp4", "FrameRate", 30, "SaveFlag", true);
    %   for i = 1:100
    %       plot(rand(1,10)); drawnow;
    %       anim.captureFrame();
    %   end
    %   clear anim; % Automatically calls close() on object deletion

    properties
        VideoWriterObj
        FrameRate = 60; % Default frame rate
        SaveFlag = true; % Whether to save animation
    end

    methods

        function obj = AnimatorMatlab(filename, varargin)
            % Check if filename is provided
            if nargin < 1
                error("Please provide a filename.");
            end

            % Parse optional parameters
            for i = 1:2:length(varargin)
                switch lower(varargin{i})
                    case "framerate"
                        obj.FrameRate = varargin{i + 1};
                    case "saveflag"
                        obj.SaveFlag = varargin{i + 1};
                    otherwise
                        error("Unknown option: %s", varargin{i});
                end
            end

            % If saving is enabled, initialize VideoWriter
            if obj.SaveFlag
                obj.VideoWriterObj = VideoWriter(filename, 'MPEG-4'); % You can change to other formats if needed
                obj.VideoWriterObj.FrameRate = obj.FrameRate;
                open(obj.VideoWriterObj);
            end
        end

        function captureFrame(obj)
            % Capture frame from the current figure and write it to the video
            if obj.SaveFlag
                frame = getframe(gcf); % Capture current figure
                writeVideo(obj.VideoWriterObj, frame);
            end
        end

        function close(obj)
            % Close the VideoWriter object if saving is enabled
            if obj.SaveFlag
                close(obj.VideoWriterObj);
            end
        end

        function delete(obj)
            % Automatically close the VideoWriter when object is deleted
            obj.close();
        end

    end

end
