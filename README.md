# Common Octave Libraries

This is a collection of common Octave libraries.

## Objective

- Octave language is supported
- Support common visualization

## Instructions

Download as a subfolder

```sh
git clone https://github.com/five2nine/octave-lib
Remove-Item -Recurse -Force .\octave-lib\.git
```

then add folder to Octave project

```octave
addpath(genpath("octave-lib))
```

or 

```octave
addpath(genpath(pwd))
```

## 플롯 확장 함수

자주 사용하는 함수의 확장을 만들고 기본 파라메타를 부여하였다.

- figured: figure 기본 파라메타를 가지며 창을 중앙에 위치시킨다.
- subplots: 다중 서브플롯을 생성하며 기본 파라메타를 가진다.
- plotd: plot 함수의 확장 버전으로서 기본 파라메타를 가진다.
- textd: text 함수의 확장 버전으로서 기본 파라메타를 가진다.
- default_parameter: 기본 파라메타의 값을 구조체로 가진다. (deprecated)
- Animator: 애니메이션을 동영상으로 저장하는 클래스이다.

## 기본 설정

startup.m 파일에 기본 설정을 정의할 수 있다.
claude.ai에서 전체 목록을 얻을 수 있었다. 메뉴얼에는 나오지 않는다.
각 그래픽 요소들은 독립적이지 않다.

- 차트축과 레전드축은 동등한 축이다. 차트축에 기본 레이블을 지정하면 레전드축에도 나타난다.
- 텍스트와 레전드 텍스트도 동등하다. 텍스트 유닛이 노말이면 레전드 텍스트도 노말이 되어 이탈한다.
- 따라서 figure와 같이 독립인 속성은 기본값이 유효하지만 축과 텍스스로 얽힌 요소는 생성하는 시점에 파라메타를 정의해야 해당 속성이 독립적으로 유지된다.

테스트 결과는 다음과 같다.

- figure 기본 파라메타는 잘 작동한다.
- axes 기본 파라메타는 잘 작동하지만 레전드도 하나의 축이므로 영향을 받아서 설정이 충돌한다.
- legend 기본 파라메타는 잘 작동하지 않는다.
- text 기본 파라메타는 잘 작동하지만 레전트 텍스트에 영향을 주어서 설정이 충돌한다.
- legend 문제가 핵심이며 기본 파라메타는 이 때문에 전반적으로 **잘 작동하지는 않는다**.
- startup.m 기본 파라메타를 생각하기 전에 작성한 figured, subplots, plotd, textd는 잘 작동한다.
