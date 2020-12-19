10 REM SIMPLE BENCH INDEX: SCRUSS 202012
20 GOTO 80
30 REM SUBS - PLS STEP AROUND
40 RETURN
50 REM OUTPUT ROUTINE
60 PRINT FNP(R(B));"S;";FNP(K(B)/R(B));"/S; I=";FNR(100*60/R(B))
70 RETURN
80 PRINT
90 PRINT "BASIC BENCH INDEX"
100 PRINT ">I GOOD. NTSC C64=100"
120 PRINT
130 REM LOOP COUNTS FOR TEST
140 DIM K(8)
150 REM RESULTS IN SECONDS
160 DIM R(8)
170 FOR I=1 TO 8
180 READ K(I)
190 NEXT I
200 REM MOD-10 FUNCTION 2..11
210 DEF FNM(X)=2+X-INT(X/10)*10
220 REM ROUND FUNCTION
230 DEF FNR(X)=INT(0.5+X)
240 REM ONE DECIMAL PLACE FUNCTION
250 DEF FNP(X)=FNR(10*X)/10
260 REM MACHINE SPECIFIC TIME FUNCTION
270 DEF FND(X)=(TIME-X)/100
280 REM BENCHMARK COUNTER
290 LET B=1
300 REM TEST STRING
310 LET Q$="ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
320 REM TEST ARRAY
330 DIM S(12)
340 FOR I=1 TO 12
350 LET S(I)=I
360 NEXT I
370 REM SCRATCH VARIABLES
380 LET X=1
390 LET Y=1
400 REM *** 1: FOR TEST
410 PRINT "1/8 - FOR:"
420 LET T=TIME
430 FOR I=1 TO K(B)
440 NEXT I
450 LET R(B)=FND(T)
460 GOSUB 60
470 REM *** 2: GOTO TEST
480 LET B=2
490 PRINT "2/8 - GOTO:"
500 LET T=TIME
510 FOR I=1 TO K(B)
520 GOTO 530
530 NEXT I
540 LET R(B)=FND(T)
550 GOSUB 60
560 REM *** 3: GOSUB TEST
570 LET B=3
580 PRINT "3/8 - GOSUB:"
590 LET T=TIME
600 FOR I=1 TO K(B)
610 GOSUB 40
620 NEXT I
630 LET R(B)=FND(T)
640 GOSUB 60
650 REM *** 4: IF TEST
660 LET B=4
670 PRINT "4/8 - IF:"
680 LET T=TIME
690 FOR I=1 TO K(B)
700 IF I>0 THEN NEXT I
710 LET R(B)=FND(T)
720 GOSUB 60
730 REM *** 5: FN TEST
740 LET B=5
750 PRINT "5/8 - FN:"
760 LET T=TIME
770 FOR I=1 TO K(B)
780 LET X=FNM(I)
790 NEXT I
800 LET R(B)=FND(T)
810 GOSUB 60
820 REM *** 6: MATHS TEST
830 LET B=6
840 PRINT "6/8 - MATHS:"
850 LET T=TIME
860 FOR I=1 TO K(B)
870 LET Y=(TAN(ATN(SQR(Y*Y)))+1)/Y
880 NEXT I
890 LET R(B)=FND(T)
900 GOSUB 60
910 REM *** 7: STRING TEST
920 LET B=7
930 PRINT "7/8 - STRING:"
940 LET T=TIME
950 FOR I=1 TO K(B)
960 LET Q$=RIGHT$(Q$,35)+LEFT$(Q$,1)
970 NEXT I
980 LET R(B)=FND(T)
990 GOSUB 60
1000 REM *** 8: ARRAY TEST
1010 LET B=8
1020 PRINT "8/8 - ARRAY:"
1030 LET T=TIME
1040 FOR I=1 TO K(B)
1050 LET X=FNM(I)
1060 LET S(X)=(S(X-1)+S(X)+S(X+1))/3
1070 NEXT I
1080 LET R(B)=FND(T)
1090 GOSUB 60
1100 PRINT
1110 REM *** OVERALL INDEX
1120 LET X=0
1130 FOR I=1 TO 8
1140 LET X=X+R(I)
1150 NEXT I
1160 PRINT "OVERALL INDEX=";FNR(100*8*60/X)
1170 PRINT
1180 END
1190 REM C64 STD - DO NOT EDIT
1200 DATA 40468,26522,21046,14568
1210 DATA 3642,383,4933,1675

