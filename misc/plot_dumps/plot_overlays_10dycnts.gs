* Draws bar graph of tank counts from past 10 days of both legacy
* TAC tank and new corresponding BUFR tank.

function main(args)

tacctlfil=subwrd(args,1)
bufrctlfil=subwrd(args,2)
tactank=subwrd(args,3)
bufrtank=subwrd(args,4)

tactankname=''
bufrtankname=''
if(tactank='NC000000') ; tactankname='SYNOPR' ; endif
if(tactank='NC000001') ; tactankname='SYNOP' ; endif
if(tactank='NC000002') ; tactankname='SYNOPM' ; endif
if(tactank='NC004001') ; tactankname='AIREP' ; endif
if(tactank='NC004003') ; tactankname='AMDAR' ; endif
if(bufrtank='NC000100') ; bufrtankname='SYNPBR' ; endif
if(bufrtank='NC000101') ; bufrtankname='SYNOPB' ; endif
if(bufrtank='NC000102') ; bufrtankname='SYNPMB' ; endif
if(bufrtank='NC004103') ; bufrtankname='AMDAR' ; endif

'open 'tacctlfil''
'open 'bufrctlfil''
'q files'
say result

* Determine y-axis range
'set dfile 1'
'q ctlinfo'
say result
tdefline=sublin(result,7)
last=subwrd(tdefline,2)
'set t 1 'last''
'set gxout stat'
'd count'
say result
resline=sublin(result,9)
fl1cmin=subwrd(resline,5)
fl1cmax=subwrd(resline,6)
'set dfile 2'
'd count'
say result
resline=sublin(result,9)
fl2cmin=subwrd(resline,5)
fl2cmax=subwrd(resline,6)
if(fl2cmin<=fl1cmin)
  lo=fl2cmin
else
  lo=fl1cmin
endif
if(lo<0); lo=0; endif
if(fl1cmax>=fl2cmax)
  hi=fl1cmax
else
  hi=fl2cmax
endif
'set vrange 'lo' 'hi''

* Determine avg count from t=1 to t=last
'set dfile 1'
'define avg1 = ave(count,t=1,t='last')'
'set gxout stat'
'd avg1'
say result
resline=sublin(result,8)
avgtxt=subwrd(resline,4)
avgtac=math_nint(avgtxt)
'set dfile 2'
'define avg2 = ave(count,t=1,t='last')'
'set gxout stat'
'd avg2'
say result
resline=sublin(result,8)
avgtxt=subwrd(resline,4)
avgbfr=math_nint(avgtxt)

* Set up graphic options 
'set dfile 1'
'set background 1'
'set gxout bar'
'set bargap 50'
'set baropts filled'
'set ccolor 4'
* Display counts
'd count'
'set dfile 2'
'set ccolor 3'
'd count'

* Display avg lines
'set gxout line'
'set ccolor 4'
'set cstyle 2'
'set cmark 0'
'd avg1'
'set ccolor 3'
'set cstyle 2'
'set cmark 0'
'd avg2'

* Draw titles
'set string 4 l 5 0'
'set strsiz 0.15 0.15'
'draw string 0.5 8.25 'tactank' ('tactankname') 10 day count - TAC'
'set string 3 l 5 0'
'draw string 0.5 8.0 'bufrtank' ('bufrtankname') 10 day count - BUFR'
if(lo=0 & hi=0)
  'set string 4 l 5 0'
  'set strsiz 0.25 0.25'
  'draw string 3.5 4.5 Tanks Empty last 10 days'
endif
* Draw avg info
'set string 4 l 5 0'
'set strsiz 0.13 0.13'
'draw string 8.5 8.25 Avg count: 'avgtac''
'set string 3 l 5 0'
'draw string 8.5 8.0 Avg count: 'avgbfr''

* Make hard copy png
'printim /ptmpp1/Shelley.Melchior/plot_tnkcnts/'tactank'.'bufrtank'.10dycnt.OVERLAY.png png x800 x600 white'

'c'
'close 2'
'close 1'
'quit'

