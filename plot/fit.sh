#!/bin/bash

echo "The filename is:"
read filename;
echo "....the distance function is:"
read distance_function;
echo "....and the reduction method is:"
read reduction_method;

inputfile1="Bedo-Perru/plots/${reduction_method}/fits/${filename}/model_${filename}_${distance_function}.txt"
inputfile2="Bedo-Perru/plots/${reduction_method}/fits/${filename}/measures_${filename}_${distance_function}.txt"
outputfile1="Bedo-Perru/plots/${reduction_method}/fits/${filename}/${filename}_${distance_function}.pdf"
outputfile2="Bedo-Perru/plots/${reduction_method}/fits/${filename}/all_model_${filename}_${distance_function}.pdf"
outputfile3="Bedo-Perru/plots/${reduction_method}/fits/${filename}/behavior_${filename}_${distance_function}.pdf"
outputfile4="Bedo-Perru/plots/${reduction_method}/derivadas/${filename}/diff_${filename}_${distance_function}.pdf"
		
gnuplot -e "file_input1='$inputfile1';file_input2='$inputfile2'; file_output1='$outputfile1';file_output2='$outputfile2';file_output3='$outputfile3';file_output4='$outputfile4' " fit.gnu; 
