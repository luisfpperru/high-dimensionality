reset
set nokey
set term post eps enhanced color
set out 'Bedo-Perru/latex modificado/figs/histo_canvas_Euclidian_16384atributes.pdf'

set terminal postscript eps color lw 1 enhanced "Times-Roman" 30

set xlabel "Normalized Pairwise Distance"
set ylabel "Normalized Frequency"
set yrange [0:1]
set xrange [0:1]
set style data lines
plot    'results/canvas/data/Euclidian/histo_128buckets_from_canvas_16384atributes_Euclidian.txt'  u ($1):($2) with lines lc rgb "black",\
	'results/canvas/data/Euclidian/histo_128buckets_from_canvas_16384atributes_Euclidian.txt'  u ($1):($4) with lines ls 2 lc rgb "dark-gray"

