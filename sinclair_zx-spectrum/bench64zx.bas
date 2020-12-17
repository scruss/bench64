10 rem simple bench index: scruss 202012 zx
20 go to 80
30 rem subs - pls step around
40 return
50 rem output routine
60 print fn p(r(b));"s;";fn p(k(b)/r(b));"/s; i="; fn r(100*60/r(b))
70 return
80 print
90 print "basic bench index"
100 print ">i good. ntsc c64=100"
120 print
130 rem loop counts for test
140 dim k(8)
150 rem results in seconds
160 dim r(8)
170 for i=1 to 8
180 read k(i)
190 next i
200 rem mod-10 function 2..11
210 def fn m(x)=2+x-int(x/10)*10
220 rem round function
230 def fn r(x)=int(0.5+x)
240 rem one decimal place function
250 def fn p(x)=fn r(10*x)/10
260 rem machine specific time function
262 def fn n(x,y)=(x+y+abs (x-y))/2
264 def fn u()=(65536*peek 23674+256*peek 23673+peek 23672)/50
266 def fn t()=fn n(fn u(),fn u())
270 def fn d(x)=fn t()-x
280 rem benchmark counter
290 let b=1
300 rem test string
310 let q$="abcdefghijklmnopqrstuvwxyz1234567890"
320 rem test array
330 dim s(12)
340 for i=1 to 12
350 let s(i)=i
360 next i
370 rem scratch variables
380 let x=1
390 let y=1
400 rem *** 1: for test
410 print "1/8 - for:"
420 let v=fn t()
430 for i=1 to k(b)
440 next i
450 let r(b)=fn d(v)
460 go sub 60
470 rem *** 2: goto test
480 let b=2
490 print "2/8 - go to:"
500 let v=fn t()
510 for i=1 to k(b)
520 go to 530
530 next i
540 let r(b)=fn d(v)
550 go sub 60
560 rem *** 3: gosub test
570 let b=3
580 print "3/8 - go sub:"
590 let v=fn t()
600 for i=1 to k(b)
610 go sub 40
620 next i
630 let r(b)=fn d(v)
640 go sub 60
650 rem *** 4: if test
660 let b=4
670 print "4/8 - if:"
680 let v=fn t()
690 for i=1 to k(b)
700 if i>0 then next i
710 let r(b)=fn d(v)
720 go sub 60
730 rem *** 5: fn  test
740 let b=5
750 print "5/8 - fn :"
760 let v=fn t()
770 for i=1 to k(b)
780 let x=fn m(i)
790 next i
800 let r(b)=fn d(v)
810 go sub 60
820 rem *** 6: maths test
830 let b=6
840 print "6/8 - maths:"
850 let v=fn t()
860 for i=1 to k(b)
870 let y=(tan(atn(sqr(y*y)))+1)/y
880 next i
890 let r(b)=fn d(v)
900 go sub 60
910 rem *** 7: string test
920 let b=7
930 print "7/8 - string:"
940 let v=fn t()
950 for i=1 to k(b)
960 let q$=q$(2 to )+q$(1 to 1)
970 next i
980 let r(b)=fn d(v)
990 go sub 60
1000 rem *** 8: array test
1010 let b=8
1020 print "8/8 - array:"
1030 let v=fn t()
1040 for i=1 to k(b)
1050 let x=fn m(i)
1060 let s(x)=(s(x-1)+s(x)+s(x+1))/3
1070 next i
1080 let r(b)=fn d(v)
1090 go sub 60
1100 print
1110 rem *** overall index
1120 let x=0
1130 for i=1 to 8
1140 let x=x+r(i)
1150 next i
1160 print "overall index="; fn r(100*8*60/x)
1170 print
1190 rem c64 std - do not edit
1200 data 40468,26522,21046,14568
1210 data  3642,  383, 4928, 1675
