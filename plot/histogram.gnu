reset
set nokey

#set term post eps enhanced color
#set terminal postscript eps color lw 1 enhanced "Times-Roman" 30

set terminal pdf
set output file_output
set xlabel font "Times-Roman,22"
set ylabel font "Times-Roman,24"

set xlabel "Normalized Pairwise Distance"
set ylabel "Normalized Frequency"
set yrange [0:1]
set xrange [0:1]
set style data lines
plot    file_input  u ($1):($2) with lines lc rgb "black",\
	file_input  u ($1):($3) with lines ls 2 lc rgb "dark-gray"

	


