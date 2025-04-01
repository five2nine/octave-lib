% REPL(Read-Eval-Print Loop)은 대화형 환경이다.
% startup.m REPL 세션이 시작할 떄 가장 먼저 자동으로 실행된다.
% main.m 프로세스가 시작할 때 clear all 명령에 의해 무효화될 수 있다.
% 메인 코드에서 clear all 하면 pkg는 무효화되고 default param은 유지된다.

clc; clear all; close all; 
addpath(genpath("C:\\dev_now\\octave-lib"));

pkg load io
pkg load signal
# pkg load statistics
# pkg load image
# pkg load optim
# pkg load control
# pkg load symbolic

printf(fmt("{mfilename} - project\n", "#FF5733"));

fontsize = 16;

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

% Position
screenSize = get(0, 'ScreenSize'); % [x y width height]
screenWidth = screenSize(3);
screenHeight = screenSize(4);
windowWidth = floor(screenWidth / 3);
windowHeight = floor(screenHeight / 3);
left = (screenWidth - windowWidth) / 2;
bottom = (screenHeight - windowHeight) / 2;
position = [left, bottom, windowWidth, windowHeight];

% figure
set(0, "defaultFigurePosition", position);
set(0, "defaultFigureName", "Figure");
set(0, "defaultFigureColor", "#FFFFFF");
set(0, "defaultFigureNumberTitle", "off");

% axes
set(0, "defaultAxesFontSize", fontsize);
set(0, "defaultAxesLineWidth", 0.5);
set(0, "defaultAxesXGrid", "on");
set(0, "defaultAxesYGrid", "on");
set(0, "defaultAxesZGrid", "on");
set(0, "defaultAxesNextPlot", "add");
set(0, "defaultAxesColorOrder", color_base);

# set(0, "defaultAxesXlabel", "Time [sec]");  # 레전드축에도 적용된다.
# set(0, "defaultAxesYlabel", "Amplitude");  # 레전드축에도 적용된다.
# set(0, "defaultAxesXColor", "#FF0000");  # 일반적이지 않다.
# set(0, "defaultAxesYColor", "#00FF00");  # 일반적이지 않다.
# set(0, "defaultAxesZColor", "#0000FF");  # 일반적이지 않다.

% plot
set(0, "defaultLineLineWidth", 1.2);
# set(0, "defaultLineMarkerSize", 8);

% text
set(0, "defaultTextFontSize", fontsize);

# set(0, "defaultTextInterpreter", "none");
# set(0, "defaultTextColor", "#293134");
# set(0, "defaultTextUnits", "normalized");  # 레전드 텍스트가 이탈한다
# set(0, "defaultTextFontWeight", "bold");  # 너무 굵다

% patch
# set(0, "defaultPatchFaceColor", [1, 1, 1]);
# set(0, "defaultAxesColorOrder", color_base);

% legend
# set(0, "defaultLegendLocation", "northeast");
# set(0, "defaultLegendAutoUpdate", "on");
# set(0, "defaultLegendBox", "on");
# set(0, "defaultLegendColor", "none");
# set(0, "defaultLegendEdgeColor", "#C0C0C0");
# set(0, "defaultLegendFontSize", fontsize);
# set(0, "defaultLegendTextInterpreter", "none")
