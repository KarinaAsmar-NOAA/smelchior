* Draws tank counts (bar graphs)

function main(args)

ctlfil=subwrd(args,1)
tank=subwrd(args,2)

tankname=''
if(tank='NC000000') ; tankname='SYNOPR' ; endif
if(tank='NC000001') ; tankname='SYNOP' ; endif
if(tank='NC000002') ; tankname='SYNOPM' ; endif
if(tank='NC000100') ; tankname='SYNPBR' ; endif
if(tank='NC000101') ; tankname='SYNOPB' ; endif
if(tank='NC000102') ; tankname='SYNPMB' ; endif
if(tank='NC004006') ; tankname='EAMDAR' ; endif
if(tank='NC004003' | tank='NC004103') ; tankname='AMDAR' ; endif
if(tank='NC004004') ; tankname='MDCRS' ; endif
if(tank='NC004009') ; tankname='CAMDAR' ; endif
if(tank='NC004011') ; tankname='KAMDAR' ; endif

'open 'ctlfil''

* Get tdef info to set time
'set gxout stat'
'q ctlinfo'
say result
tdefline=sublin(result,7)
last=subwrd(tdefline,2)
'set t 1 'last''

* Determine vrange
'd count'
say result
resline=sublin(result,8)
min=subwrd(resline,4)
max=subwrd(resline,5)
resline=sublin(result,9)
cmin=subwrd(resline,5)
cmax=subwrd(resline,6)

* Determine avg count from t=1 to t=last
'define avg = ave(count,t=1,t='last')'
'set gxout stat'
'd avg'
say result
resline=sublin(result,8)
avgtxt=subwrd(resline,4)
avgtxt=math_nint(avgtxt)

* Set up graphic options
'set background 1'
'set gxout bar'
'set bargap 50'
'set baropts filled'
'set ccolor 4'
if(min<=0)
  'set vrange 0 'cmax''
endif

* Display counts in bars
'd count'

* Display avg line
'set gxout line'
'set ccolor 4'
'set cstyle 2'
'set cmark 0'
'd avg'

* Draw titles
'set string 4 l 5 0'
'set strsiz 0.15 0.15'
'draw string 0.5 8.25 'tank' 10-day Counts ('tankname')'
if(min<=0 & max<=0)
  'set string 4 l 5 0'
  'set strsiz 0.25 0.25'
  'draw string 3.5 4.5 Tank Empty last 10 days'
endif 
* Draw avg info
'set string 4 l 5 0'
'set strsiz 0.13 0.13'
'draw string 8.5 8.25 Avg count: 'avgtxt''

* Make hard copy png
'printim /ptmpp1/Shelley.Melchior/plot_tnkcnts/'tank'.10dycnt.png png x800 x600 white'

'c'
'close 1'
'quit'

