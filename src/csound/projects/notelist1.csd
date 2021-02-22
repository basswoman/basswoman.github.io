<CsoundSynthesizer>
<CsOptions>
-odac -d
</CsOptions>
<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

gi1 ftgen 1, 0, 513, 5, 1, 512, .00195
gi2 ftgen 2, 0, 513, 10, 0, .2, 0, .4, 0, .6, 0, .8, 0, 1, 0

garvb init 0

          instr 1  ;leads
idur = p3
iamp = p4
kcps = p5
kf   = p6
iS = p7 ;;;;panning 
iF = p8
ienv1 = p9 ;;;;envelope
ienv2 = p10
;irvb = 
klfo lfo 1, 1
kline linseg iS, p3/2, iF, p3/2, iS
kline2 linseg ienv1, p3/2, ienv2, p3/2, ienv1

a1        poscil     kline2, kcps, gi1
a2        poscil     kline2, ((kcps+1)*2)+klfo, gi2
a3        poscil     kline2, kcps/2
a1F  moogladder2 a1, kline2*kf, .1
a2F  moogladder2 a2, kline2*kf, .1
af = a1F + a2F + a3
aF mvchpf af, 160
aL, aR pan2 aF, kline

outs      aL, aR
garvb = garvb + (aL + aR) *.1
          endin
          
          instr 2 ;bass
idur = p3
iamp = p4
kcps = p5
kcps2 = p6          
          
kgate adsr .1, .1, .6, .2
klinef linseg 100, p3, 350
klinep linseg p5, p3*.25, p5, p3*.25, p6, p3*.25, p6, p3*.2, p7, p3*.05, p6
klfo lfo klinef, 6        
          
a1 vco2 p4, klinep 
a2 vco2 p4*.6, (klinep*2)-1
a3 = a1 + a2

aout  moogladder2 a3, 500+klfo, .1

outs aout*kgate, aout*kgate
         endin
         
         
         instr 3 ;drumz
idur = p3
iamp = p4      
kt = p5   
kpan = p6 
     
 a1, a2 diskin2 "notes1.wav", kt, 0, 1, 0
 ain = a1 + a2
aL, aR pan2 ain, p6
 outs aL*p4, aR*p4
 
 endin     
 
			 instr 4 ;harp
idur = p3
iamp = p4
kcps = p5

 a1 pluck p4, p5, p5, 0, 1
 outs a1*iamp, a1*iamp
 garvb = garvb + (a1) *.1
 
 endin
          instr	6 ;reverb
          
;irvbtime= p4
asig reverb garvb, 3.5
outs asig,asig
garvb = 0
endin

</CsInstruments>
<CsScore>
i6 0 100

a0 0 0

;	2  3 4  5  6   7  8  9  10


i1 0  8 1 222 800 0 1  0 .5

i1 7  8 1 222 900 0 1  0 .
i1 7  8 1 233 900 0 1  0 .

i1 14 2 .8 233 800 0 1  0 .
i1 15 2 .8 230 800 1 0  0 .
i1 16 2 .8 227 900 0 1  0 .

i1 17 7 .7 222 1000 0 1  0 .
i1 17 7 .7 111 1000 1 0  0 .

i1 23 6 .7 233 1200 0 1  0 .
i1 23 6 .7 100 1200 1 0  0 .

i1 29 3 .5 100 1400 1 0  0 .
i1 29 3 .4 250 1400 0 1  0 .
i1 30 2 .5 100 1500 1 0  0 .
i1 30 2 .6 250 1500 0 1  0 .

i1 31 2 .4 100 1600 1 0  0 .
i1 31 2 .6 250 1600 0 1  0  .5
i1 32 2 .5 125 1600 0 1  0  .5

i1 32 4 .4 100 1800 1 .5  0  .5
i1 33 4 .5 500 1600 0 .5  0  .
i1 33 4 .6 250 1700 0  1  0  .
i1 33 4 .6 489 1700 0 .5  0  .
;;;;;;;;;;;;;;;;;;;;;;;;
i2 38 16 .4 70 40 80
i2 53 2  .6 270 200 170 
i2 54 16 .4 70 40 80
i2 69 2  .6 270 200 170 
;;;;;;;;;;;;;;;;;;;;;;
i1 41 1  .4 600 1800 1 0  0  .5
i1 41 1  .5 500 1600 0 1  0  .

i1 45 1  .4 600 1800 1 0  0  .5
i1 45 1  .5 700 1600 0 1  0  .

i1 49 1  .4 550 1800 1 0  0  .5
i1 49 1  .5 700 1600 0 1  0  .

i1 57 1  .4 600 1800 1 0  0  .5
i1 57 1  .5 700 2000 0 1  0  .

i1 61 1  .4 550 1800 1 0  0  .5
i1 61 1  .5 700 2200 0 1  0  .

i1 65 1  .4 600 2000 1 0  0  .5
i1 65 1  .5 500 2200 0 1  0  .
;;;;;;;;;;;;;;;;;
i3 37 1 .3 -2 .5
i3 38 32 .3 1 .5
i3 42 1 .2 .3  1
i3 50 4 .2  .5 0
i3 58 4 .2  .5 1
i3 65 16 .6  .5 .5

i4 70   .5 .3 450 
i4 70.1 .5 .3 470 
i4 70.2 .5 .3 500 
i4 70.3 .5 .3 550 

i4 73   .5 .4 450 
i4 73.5   .5 .4 470 
i4 74.25   .5 .4 550 
i4 75.5   .5 . 530 
i4 75.75   .5 . 500
i4 76   .5 .4 490  

i4 80   .9 .2 550 
i4 80.1 .8 .2 570 
i4 80.2 .7 .2 600 
i4 80.3 .6 .2 650 

</CsScore>
</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>255</r>
  <g>255</g>
  <b>255</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
