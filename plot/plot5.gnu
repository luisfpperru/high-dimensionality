reset
set nokey
set term post eps enhanced color
set out output_data1
set terminal postscript eps color lw 1 enhanced "Times-Roman" 30


set ylabel "Nuisance Function"
set xlabel "Dimensionality"
set yrange [0:1]
set style data lines
plot input_data1 u ($1):($10) with lines ls 2 lc rgb "black",\
     input_data2 u ($1):($10) with points ps 1 lc rgb "dark-gray"

reset
set nokey
set term post eps enhanced color
set out output_data2
set terminal postscript eps color lw 1 enhanced "Times-Roman" 30


set ylabel "Contrast Area"
set xlabel "Dimensionality"
#set yrange [0:1]
set style data lines
plot input_data2 u ($1):($9) with points ps 1 lc rgb "dark-gray"

reset
set nokey
set term post eps enhanced color
set out output_data3
set terminal postscript eps color lw 1 enhanced "Times-Roman" 30


set ylabel "Ratio"
set xlabel "Dimensionality"
set yrange [0:1]
set style data lines
plot input_data2 u ($1):($4) with points ps 1 lc rgb "dark-gray"


