10 REM simple bench index: scruss 202012 zx
20 GO TO 80
30 REM subs - pls step around
40 RETURN 
50 REM output routine
60 PRINT FN p(r(b));"s;";FN p(k(b)/r(b));"/s; i=";FN r(100*60/r(b))
70 RETURN 
80 PRINT 
90 PRINT "basic bench index"
100 PRINT ">i good. ntsc c64=100"
120 PRINT 
130 REM loop counts for test
140 DIM k(8)
150 REM results in seconds
160 DIM r(8)
170 FOR i=1 TO 8
180 READ k(i)
190 NEXT i
200 REM mod-10 function 2..11
210 DEF FN m(x)=2+x-INT (x/10)*10
220 REM round function
230 DEF FN r(x)=INT (0.5+x)
240 REM one decimal place function
250 DEF FN p(x)=FN r(10*x)/10
260 REM machine specific time function
262 DEF FN n(x,y)=(x+y+ABS (x-y))/2
264 DEF FN u()=(65536*PEEK 23674+256*PEEK 23673+PEEK 23672)/50
266 DEF FN t()=FN n(FN u(),FN u())
270 DEF FN d(x)=FN t()-x
280 REM benchmark counter
290 LET b=1
300 REM test string
310 LET q$="abcdefghijklmnopqrstuvwxyz1234567890"
320 REM test array
330 DIM s(12)
340 FOR i=1 TO 12
350 LET s(i)=i
360 NEXT i
370 REM scratch variables
380 LET x=1
390 LET y=1
400 REM *** 1: for test
410 PRINT "1/8 - for:"
420 LET v=FN t()
430 FOR i=1 TO k(b)
440 NEXT i
450 LET r(b)=FN d(v)
460 GO SUB 60
470 REM *** 2: goto test
480 LET b=2
490 PRINT "2/8 - go to:"
500 LET v=FN t()
510 FOR i=1 TO k(b)
520 GO TO 530
530 NEXT i
540 LET r(b)=FN d(v)
550 GO SUB 60
560 REM *** 3: gosub test
570 LET b=3
580 PRINT "3/8 - go sub:"
590 LET v=FN t()
600 FOR i=1 TO k(b)
610 GO SUB 40
620 NEXT i
630 LET r(b)=FN d(v)
640 GO SUB 60
650 REM *** 4: if test
660 LET b=4
670 PRINT "4/8 - if:"
680 LET v=FN t()
690 FOR i=1 TO k(b)
700 IF i>0 THEN NEXT i
710 LET r(b)=FN d(v)
720 GO SUB 60
730 REM *** 5: fn  test
740 LET b=5
750 PRINT "5/8 - fn :"
760 LET v=FN t()
770 FOR i=1 TO k(b)
780 LET x=FN m(i)
790 NEXT i
800 LET r(b)=FN d(v)
810 GO SUB 60
820 REM *** 6: maths test
830 LET b=6
840 PRINT "6/8 - maths:"
850 LET v=FN t()
860 FOR i=1 TO k(b)
870 LET y=(TAN (ATN (SQR (y*y)))+1)/y
880 NEXT i
890 LET r(b)=FN d(v)
900 GO SUB 60
910 REM *** 7: string test
920 LET b=7
930 PRINT "7/8 - string:"
940 LET v=FN t()
950 FOR i=1 TO k(b)
960 LET q$=q$(2 TO )+q$(1 TO 1)
970 NEXT i
980 LET r(b)=FN d(v)
990 GO SUB 60
1000 REM *** 8: array test
1010 LET b=8
1020 PRINT "8/8 - array:"
1030 LET v=FN t()
1040 FOR i=1 TO k(b)
1050 LET x=FN m(i)
1060 LET s(x)=(s(x-1)+s(x)+s(x+1))/3
1070 NEXT i
1080 LET r(b)=FN d(v)
1090 GO SUB 60
1100 PRINT 
1110 REM *** overall index
1120 LET x=0
1130 FOR i=1 TO 8
1140 LET x=x+r(i)
1150 NEXT i
1160 PRINT "overall index=";FN r(100*8*60/x)
1170 PRINT 
1190 REM c64 std - do not edit
1200 DATA 40468,26522,21046,14568
1210 DATA 3642,383,4933,1675
