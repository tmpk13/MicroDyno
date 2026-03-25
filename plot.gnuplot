set terminal pngcairo size 1000,800 enhanced font "Sans,11"
set output "bss138-amp.png"

set multiplot layout 2,1 title "BSS138 Common-Source Audio Amplifier — ngspice" font "Sans,13"

# ── Panel 1: AC frequency response ──────────────────────────────────────────
set title "AC Frequency Response (input = 1V)"
set xlabel "Frequency (Hz)"
set ylabel "Gain (dB)"
set logscale x
set xrange [10:200000]
set yrange [-55:5]
set grid xtics ytics lt 0 lw 0.5
set key top right

set arrow from 16000,-55 to 16000,0 nohead lt 2 lc rgb "#cc4444" lw 1.5 dt 2
set label 1 "16kHz RC filter" at 18000,-10 tc rgb "#cc4444" font "Sans,9"
set arrow from 1000,-55 to 1000,0 nohead lt 2 lc rgb "#4444cc" lw 1 dt 3
set label 2 "1kHz" at 1100,-5 tc rgb "#4444cc" font "Sans,9"

plot "ac.dat" using 1:2 with linespoints lw 2 pt 7 ps 0.5 lc rgb "#e07020" title "V(gate) — after RC filter", \
     "ac.dat" using 1:3 with linespoints lw 2 pt 7 ps 0.5 lc rgb "#2060c0" title "V(out) — speaker"

unset arrow
unset label

# ── Panel 2: Transient 1kHz ──────────────────────────────────────────────────
set title "Transient — 1kHz, 100mV input  (5 cycles shown)"
set xlabel "Time (ms)"
set ylabel ""
unset logscale x
set xrange [0:5]
set yrange [-200:1500]
set grid xtics ytics lt 0 lw 0.5
set key top right

# Dual y-axis: gate on left (V), speaker on right (mV)
set y2label "Speaker V(out) (mV)"
set ytics nomirror
set y2tics
set y2range [-10:7.5]

plot "tran.dat" using 1:($2*1000-1055+200) axes x1y1 with lines lw 2 lc rgb "#e07020" title "V(gate) − bias [mV, left]", \
     "tran.dat" using 1:3 axes x1y2 with lines lw 2 lc rgb "#2060c0" title "V(out) speaker [mV, right]"

unset multiplot
