#!/bin/bash

echo "The filename is:"
read filename;
echo "....the distance function is:"
read distance_function;
echo "....and the reduction method is:"
read reduction_method;
echo "The number of atributes are (enter a  non-positive number to exit):"
read nAtrib;
while (( $nAtrib > 0 ))
do
	inputfile="Bedo-Perru/plots/${reduction_method}/histograms/${filename}/${filename}_${nAtrib}atributes_${distance_function}.txt"
	outputfile="Bedo-Perru/plots/${reduction_method}/histograms/${filename}/${filename}_${nAtrib}atributes_${distance_function}.pdf"	
	gnuplot -e "file_input='$inputfile'; file_output='$outputfile' " histogram.gnu; 
	read nAtrib;
done




