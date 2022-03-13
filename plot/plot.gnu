reset
set nokey
set term post eps enhanced color
set out output_data

set terminal postscript eps color lw 1 enhanced "Times-Roman" 30

set xlabel "Normalized Pairwise Distance"
set ylabel "Normalized Frequency"
set yrange [0:1]
set xrange [0:1]
set style data lines
plot    input_data u ($1):($2) with lines lc rgb "black",\
	input_data u ($1):($4) with lines ls 2 lc rgb "dark-gray"

