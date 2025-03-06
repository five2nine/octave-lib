
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
'''

or 

```octave
addpath(genpath(pwd))
``
