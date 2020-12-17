# bench64 - a new BASIC benchmark index for 8-bit computers

This is a portable BASIC benchmark that tests eight separate aspects
of interpreter speed. Each test has been designed to run for exactly
one minute on an NTSC Commodore 64. A computer that completes all of
the tests in exactly eight minutes has a performance index
of 100. Such a computer would generate the following report:

    BASIC BENCH INDEX
    >I GOOD. NTSC C64=100
    
    1/8 - FOR:
     60 S; 674.5 /S; I= 100
    2/8 - GOTO:
     60 S; 442.3 /S; I= 100
    3/8 - GOSUB:
     60 S; 350.8 /S; I= 100
    4/8 - IF:
     60 S; 242.9 /S; I= 100
    5/8 - FN:
     60 S; 60.7 /S; I= 100
    6/8 - MATHS:
     60 S; 6.4 /S; I= 100
    7/8 - STRING:
     60 S; 82.2 /S; I= 100
    8/8 - ARRAY:
     60 S; 27.9 /S; I= 100
    
    OVERALL INDEX= 100

![C64c Output](img/bench64-c64c.png "Commodore 64c Results")

The numbers given for each test are the elapsed time in seconds, the
rate (per second) that each test ran, and the computed index for that
test.

## Guiding principles

> “… many professionals and computer enthusiasts criticized BASIC for
> its simplicity, how it handled tasks, and the way in which it did
> not maximize or fully utilize the power of the computer
> itself. However, those criticisms missed the point completely.”

> — Rankin, Joy Lisi. [A People’s History of Computing in the United
> States](https://www.hup.harvard.edu/catalog.php?isbn=9780674970977)
> Harvard University Press, 2018. Chapter 3, p.66–7

1. All synthetic benchmarks are false.
   
2. My computer is better than your computer because *thbbft*!


## Design Guidelines

* The suite uses a stock North American (NTSC) Commodore 64 ("C64") as
  a baseline. These are perhaps the most common 8-bit computers ever
  made, and thus the stock of suitable testbenches is still large.
  
* A result of 100 would indicate the same performance as a C64. 200
  would indicate twice the performance, and 50 half
  
* Any features not available in Commodore BASIC 2.0 will not be tested

* Portability is a key goal: commands will be separated by spaces (not
  "crunched"), and only one command per line
  
* Each test should take as close to 60 seconds on a C64 as practical

* The tests will be timed with the computer's own internal clock, and
  require 0.1 s or better resolution
  
* Tests will be incremental, where possible. That is to say, each test
  will rely on the results of earlier tests to calculate the time
  burden particular to that test.
  
* Minor changes to the code for compatibility are allowed, but changes
  for the sake of speed are not. For example, Sinclair BASIC uses `GO
  TO` and `GO SUB` instead of `GOTO` and `GOSUB`, string slicing instead of
  LEFT$ (etc.) and requires a sequence of PEEKs to get the elapsed time
  (ref:
  [Motion](https://worldofspectrum.org/ZXBasicManual/zxmanchap18.html)). These
  are all allowable. Using BBC BASIC's fast integer variables,
  however, is not.
  
* For improved portability, variables will be assigned using `LET`

## Test Descriptions

All tests are carried out inside `FOR ... NEXT` loops. The number of
loops is initially tuned to take 60 s on an NTSC Commodore 64.

1. **FOR** - a `FOR ... NEXT` loop with no content.

2. **GOTO** - a `GOTO` the `NEXT` statement.
   
3. **GOSUB** - a `GOSUB` out of the loop with a simple `RETURN` as the
   target. 

4. **IF** - in place of the simple loop's `NEXT` statement, use
   `IF I>0 THEN NEXT I`. This is followed for every iteration.

5. **FN** - a modulo 10 user-defined function is run across the loop
   variable. Note that C64 BASIC has no `MOD` function: use
   `A-INT(A/B)*B` instead.
   
6. **Maths** - the equivalent of `LET A=(TAN(ATN(SQR(A*A)))+1)/A` is
   calculated. This is modified from [ClockSp
   3.00](https://stardot.org.uk/forums/viewtopic.php?f=2&t=19819&start=30#p276764). The
   modification prevents overflow, and by happy coincidence, the value
   of A converges onto the [golden
   ratio](https://en.wikipedia.org/wiki/Golden_ratio).

7. **String Manipulation** - the 36 character string
   `"ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"` is rotated left one
   character, becoming `"BCDEFGHIJKLMNOPQRSTUVWXYZ1234567890A"` after
   the first iteration.

8. **Array Subscripts** - a 12 entry `a()` is pre-filled with 1
   .. 12. For all but the first and last items,
   `A(X)=(A(X-1)+A(X)+A(X+1))/3` where `X` is calculated from the loop
   variable using the user-defined function used in test 5.

## Limitations

Does not produce useful results for very fast computers where test
durations tend towards zero. BASIC is not typically used on such
computers.

## Results

### Reporting results

1. Please use the machine exactly as it would appear when turned
   on. Tricks like turning off interrupts to get better results should
   not be done.
   
2. The index value is to be reported as an integer. Benchmarking 8-bit
   computers is not an exact science.
   
3. The code should be modified as little as possible to ensure that it
   runs and (where possible) reports time fairly. "Crunching" the code
   or modifying it to use integer variables (where available) must not
   be done. Portability and clarity of the code is more important than
   optimization. *If it runs any faster, it's not the same code.*
   
4. The overall index value is the goal. While individual test index
   values have passing interest, if your platform can't reasonably run
   all of the tests (perhaps through lack of floating point support),
   it cannot return a valid overall index.

### Real 8-bit hardware platform results

* MinZ v1.1 (36.864 Z180, CP/M 2.2, BBC BASIC [Z80] v3): 1839

* Commodore 64c (NTSC): 100

* ZX Spectrum 48k: 29

The glorious MinZ results in full:

    BASIC BENCH INDEX
    >I GOOD. NTSC C64=100
    
    1/8 - FOR:
     3.2 S; 12778 /S; I= 1895 
    2/8 - GOTO:
     6.1 S; 4324.5 /S; I= 978 
    3/8 - GOSUB:
     3.1 S; 6789 /S; I= 1935 
    4/8 - IF:
     2.9 S; 4966.9 /S; I= 2046 
    5/8 - FN:
     3.5 S; 1030.6 /S; I= 1698 
    6/8 - MATHS:
     1.5 S; 255.3 /S; I= 4000 
    7/8 - STRING:
     2.6 S; 1871.6 /S; I= 2279 
    8/8 - ARRAY:
     3.1 S; 540.3 /S; I= 1935 
    
    OVERALL INDEX= 1839 

(I also have an Apple IIgs, a 6502 40th Anniversary badge and a
SBC-6120 [Digital PDP-8 compatible] but haven't benchmarked those yet.)

### Emulated platform results

Baseline I=100 for "new" NTSC Commodore 64c. Older machines (`x64sc
--model oldntsc`) may be very slightly slower, but still average out
to give I=100. Any Commodore machines listed below are NTSC unless
stated otherwise.

* Commodore PET 2001: 90 (would be >100, but `GOTO` performance is dismal)

* Commodore PET 4032: 87
  
* Commodore PET 8032 / 8296: 83
  
* Commodore VIC-20: 106

* Commodore 64 (PAL): 97

* Commodore C128: 71

* Commodore C128 (C64 mode): 100

* Commodore +4 / C-16: 78

* Amstrad CPC6128: 169

* Amstrad CPC6128 (BBC BASIC): 130

* BBC Micro: 202

Beeb users are probably the most likely to nitpick these results, so
here are their results in full, too:

    BASIC BENCH INDEX
    >I GOOD. NTSC C64=100
    
    1/8 - FOR:
          29.2S;1384/S; I=205
    2/8 - GOTO:
          44.4S;597.2/S; I=135
    3/8 - GOSUB:
          22.9S;919.4/S; I=262
    4/8 - IF:
          21.9S;665.8/S; I=274
    5/8 - FN:
          30.4S;119.7/S; I=197
    6/8 - MATHS:
            32S;12/S; I=187
    7/8 - STRING:
          28.6S;172.3/S; I=210
    8/8 - ARRAY:
          27.9S;60/S; I=215
    
    OVERALL INDEX=202

### Porting notes by platform

#### Amstrad CPC

Change

    DEF FND(X)=(TIME-X)/60

to

    DEF FND(X)=(TIME-X)/300

#### BBC Micro

Change

    DEF FND(X)=(TIME-X)/60

to

    DEF FND(X)=(TIME-X)/100

#### Generic - No Timer

Change

    260 REM MACHINE SPECIFIC TIME FUNCTION
    270 DEF FND(X)=(TIME-X)/60

to

    260 REM MACHINE SPECIFIC TIME FUNCTION
	265 LET TIME=0
    270 DEF FND(X)=60

Doesn't actually do anything, so you have to time output and calculate
results yourself. The program `bench64_output` will help you do
that. A screen recorder can help work out timings by reviewing when
each test starts and stops by counting video frames.

Note that some interpreters (notably BBC BASIC for CP/M) reserve the
`TIME` function name but don't use it. For platforms like this, please
rename the `TIME` variable.

#### ZX Spectrum

Has no timer function built-in, but change

    260 REM MACHINE SPECIFIC TIME FUNCTION
    270 DEF FND(X)=(TIME-X)/60

to

    260 REM MACHINE SPECIFIC TIME FUNCTION
	262 DEF FN N(X,Y)=(X+Y+ABS (X-Y))/2
	264 DEF FN U()=(65536*PEEK 23674+256*PEEK 23673+PEEK 23672)/50
	266 DEF FN T()=FN N(FN U(),FN U())
    270 DEF FN D(X)=FN T()-X

then use `FN T()` instead of `TIME`. The *T* variable should be
changed to avoid a clash with the user-defined function: I used *V*,
for no particular reason. Don't forget to address `GO TO` and 
`GO SUB`, plus Sinclair BASIC's unique `a$([n] TO [m])` string-slicing
syntax.

## Author

Stewart Russell - scruss.com - First release: 2020-12.

## Licence

This work is licensed under Creative Commons [Attribution-ShareAlike
4.0 International (CC BY-SA
4.0)](https://creativecommons.org/licenses/by-sa/4.0/). 
