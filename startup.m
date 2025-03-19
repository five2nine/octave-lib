% Octave 20231208
% startup.m REPL 세션이 시작할 떄 가장 먼저 자동으로 실행된다.
% REPL(Read-Eval-Print Loop)은 대화형 환경이다.
################################################################################
# clc; clear all; close all; addpath(genpath(".")); prm = params();
clc;
clear all;
close all;
addpath(genpath("."));  # 로컬 라이브러리 사용
# prm = params();  # 그래픽 기본 설정

################################################################################
% 주어진 Octave 코드는 설치된 모든 패키지를 나열하고, 그 패키지들을 모두 로드한다.
% 아래 패키지 나열은 일반적으로 작업을 시작할 떄 방해가 된다.

# packs = pkg('list');  % 설치된 패키지 목록을 가져옵니다.
# for jj = 1:numel(packs)  % 각 패키지를 반복하여
#   pkg('load', packs{jj}.name);  % 각 패키지를 로드합니다.
# end
