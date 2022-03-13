reset
set nokey
set terminal pdf
set output file_output1
set xlabel font "Times-Roman,22"
set ylabel font "Times-Roman,24"
set ylabel "Nuisance Function"
set xlabel "Dimensionality"
set yrange [0:1]
set logscale x 2
plot file_input2 u ($1):($2) with points ps 1 lc rgb "dark-gray",\
     file_input1 u ($1):($2) with lines lt 2 lc rgb "black"

reset
set terminal pdf
set output file_output2
set xlabel font "Times-Roman,22"
set ylabel font "Times-Roman,24"
set ylabel "Nuisance Function"
set xlabel "Dimensionality"
set yrange [0:1]
set logscale x 2
set key right bottom
plot file_input2 u ($1):($2) with points ps 1 lc rgb "dark-gray" title "Nuisance Function (sigma/mi)",\
     file_input2 u ($1):($3) with points ps 1 lc rgb "black" title "Nuisance Function (sigma/mi^2)",\
     file_input1 u ($1):($2) with lines lt 2 lc rgb "dark-gray" title "Sigmoide (sigma/mi)",\
     file_input1 u ($1):($3) with lines lt 2 lc rgb "gray" title "Sigmoide (sigma/mi^2)"
     

reset
set terminal pdf
set output file_output3
set xlabel font "Times-Roman,22"
set ylabel font "Times-Roman,24"
set key right bottom
set xlabel "Dimensionality"
set yrange [0:1]
set logscale x 2

plot file_input2 u ($1):($4) with lines lw 2 lc rgb "red" title "distance mean",\
     file_input2 u ($1):($6) with lines lw 1 lc rgb "red" title "distance mean +- std",\
     file_input2 u ($1):($7) with lines lw 1 lc rgb "red" notitle,\
     file_input2 u ($1):($8) with lines lw 1 lc rgb "blue" title "w(x)"
