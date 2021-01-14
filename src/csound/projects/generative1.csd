<CsoundSynthesizer>
<CsOptions>


</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1


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

</CsInstruments>
<CsScore>
i1 0 63000
</CsScore>
</CsoundSynthesizer>
