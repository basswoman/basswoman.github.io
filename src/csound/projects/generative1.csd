<CsoundSynthesizer>
<CsOptions>

</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

gi1 ftgen 1, 0, 513, 5, 1, 512, .00195
gi2 ftgen 2, 0, 513, 10, 0, .2, 0, .4, 0, .6, 0, .8, 0, 1, 0
gi3 ftgen 2, 0, 514, 10, 0, .2, 0, .4, 0, .3

garvb init 0

            instr 1 ;;;noise
            
seed 0
krand rnd31 1, -0.5
krandamp random 0, 10 
krandfilt random 0, 300 

klfoamp lfo  krandfilt, krandamp/10
klfofreq lfo krandamp/10, krandamp/100
kfilt lfo klfoamp, klfofreq

;klfopan lfo .2, krandamp/50, 2
a1 noise krandamp/10, krand
a2 moogladder2 a1, 400+kfilt, .01
klfo oscil .1, .1 

a11, a22 pan2 a2, .5+klfo
outs a11, a22

            endin
    
            instr 2 ;;triggers creepy chords in instr 3
            
seed 0
kct lfo .25, .1
kct2 lfo .25, .1
kclock lfo .5+kct, .1+kct2, 3
ktirg trigger kclock, .5, 0

krand random 3, 6  ;random duration

    schedkwhen ktirg, 0, 0, 3, 0, krand
    
        endin

            instr 3  ; creepy chords
            
seed 0
irand1 random 20, 50 ; rand low voice
print irand1
irand2 random 101, 600 ; rand 1 voice
irand3 random 101, 600 ; rand 2 voice
iamp = .02
kf   = irand2*8

klfo lfo 1, .5
kline2 adsr 1, .5, .5, 1
a1        poscil     kline2, irand2+klfo, gi1
a2        poscil     kline2, irand3+klfo, gi2
a3        poscil     kline2, irand1, gi3
a1F  moogladder2 a1, kline2*kf+(klfo*2), .1
a2F  moogladder2 a2, kline2*kf*.9, .1
a3F mvchpf a3, 20

aL1, aR1 pan2 a3F, .5
aL2, aR2 pan2 a1F, 0
aL3, aR3 pan2 a2F, 1
aL = aL1 + aL2 + aL3
aR = aR1 + aR2 + aR3
outs      aL*iamp, aR*iamp
garvb = garvb + (aL + aR) * iamp
        
          endin
    
          instr 6 ;reverb
          
asig reverb garvb, 7.5
outs asig,asig
garvb = 0
endin

            instr 4 ;;; triggers bells in instr 5
            
kran randh .1, 1, 10
ktrig       metro .1+kran

if (ktrig = 1) then
event "i", 5, 0, 5
endif
            endin

            instr 5 ;;;bells
            
seed 0          
krand randh 200, .2, 10
krp randh 1, .2, 10
a1 fmbell .5, 900+krand, krp+2, 1, .05, 6
al, ar pan2 a1, krp
iamp = .1
ad delayr 1
adm     deltap  krp 
         
delayw  al + ar + (adm * .01)

outs (al+ad+adm)*iamp, (ar+ad+adm)*iamp

endin

</CsInstruments>
<CsScore>
i1 0 63000
i2 6 63000
i6 0 63000
i4 20 63000
</CsScore>
</CsoundSynthesizer>
