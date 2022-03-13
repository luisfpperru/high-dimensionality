#!/bin/bash

filename[1]=cities #5507 2
distancefunction[1]=Euclidian
filename[2]=2d #100000 2
distancefunction[2]=Manhattan
filename[3]=3d #434874 3
distancefunction[3]=Euclidian
filename[4]=bike2 #17379 7
distancefunction[4]=Canberra
filename[5]=aloi #110250 13
distancefunction[5]=Manhattan
filename[6]=canvas #3879 16
distancefunction[6]=Euclidian
filename[7]=nasa #40150 20
distancefunction[7]=Bray-Curtis
filename[8]=waveform2 #5000 21
distancefunction[8]=Fractional-0.5
filename[9]=corel #66616 32
distancefunction[9]=Euclidian
filename[10]=waveform #5000 40
distancefunction[10]=Fractional-0.5
filename[11]=sensorless #58509 48
distancefunction[11]=Manhattan
filename[12]=pid #130064 50
distancefunction[12]=Fractional-0.5
filename[13]=popularity #39644 59
distancefunction[13]=Fractional-0.5
filename[14]=colors #112682 112
distancefunction[14]=Manhattan
filename[15]=har #10299 561
distancefunction[15]=Fractional-0.5
filename[16]=faces #1016 761
distancefunction[16]=Fractional-0.5
filename[17]=amazon #1500 2048
distancefunction[17]=Euclidian
filename[18]=prove # 6118 51
distancefunction[18]=Euclidian
filename[19]=prediction # 515345 90
distancefunction[19]=Euclidian
filename[20]=qsar # 1055 41
distancefunction[20]=Euclidian

for i in {17,16,13,7,6,1}
do 
		#outputfile="results/${filename[i]}/figures/${distancefunction[i]}/ratio_from_${filename[i]}_${distancefunction[i]}.eps"
		outputfile="Bedo-Perru/latex modificado/figs/nuisance_function/ratio_from_${filename[i]}_${distancefunction[i]}.pdf"
		#outputfile2="Bedo-Perru/latex modificado/figs/ratio2/ratio2_from_${filename[i]}_${distancefunction[i]}.pdf"
		#outputfile3="Bedo-Perru/latex modificado/figs/ratio3/ratio3_from_${filename[i]}_${distancefunction[i]}.pdf"
		outputfile4="Bedo-Perru/latex modificado/figs/nuisance_function/nuisance_function_from_${filename[i]}_${distancefunction[i]}.pdf"
		outputfile5="Bedo-Perru/latex modificado/figs/nuisance_function/area_from_${filename[i]}_${distancefunction[i]}.pdf"
		inputfile1="results/${filename[i]}/data/${distancefunction[i]}/ratio_3dofs_from_${filename[i]}_${distancefunction[i]}.txt"
		inputfile2="results/${filename[i]}/data/${distancefunction[i]}/ratio_exp_3dofs_from_${filename[i]}_${distancefunction[i]}.txt"
		#gnuplot -e "input_data1='$inputfile1'; input_data2='$inputfile2'; output_data='$outputfile'" plot2.gnu 
		#gnuplot -e "input_data1='$inputfile1'; input_data2='$inputfile2'; output_data='$outputfile2'" plot3.gnu 
		#gnuplot -e "input_data1='$inputfile1'; input_data2='$inputfile2'; output_data='$outputfile3'" plot4.gnu 
		gnuplot -e "input_data1='$inputfile1'; input_data2='$inputfile2'; output_data1='$outputfile4'; output_data2='$outputfile5';output_data3='$outputfile'" plot5.gnu 
	#for j in{1..1}
	#	outputfile2="results/${filename[i]}/figures/${distancefunction[i]}/histo_${filename[i]}_${distancefunction[i]}_${nAtrib[j]}atributes.eps"	
	#	inputfile3="results/${filename[i]}/data/${distancefunction[i]}/histo_128buckets_from_${filename[i]}_${nAtrib[j]}atributes_${distancefunction[i]}.txt"
	#done
done


