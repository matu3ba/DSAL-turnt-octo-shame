#!/bin/bash
## ARGUMENT FORMAT
## 1. ./scriptname number algorithm
## 2. ./scriptname number
set -o nounset	#do not allow unitialized variables

time_now=$(date +"%F-%X")	#current date
count="$1"
useralgo=""
if [ $# = 2 ]; then
	useralgo=$2
fi

actualpath=$(pwd)
echo "${actualpath}"
newpath=${actualpath}
mkdir ${time_now}
newpath+="/"
newpath+=${time_now}
echo "${newpath}"
echo "" > debug.txt

exercise="_ex.tex"
solution="_sol.tex"
acess_bit=0

#declaring arrays in bash
declare -a alrithms=(avltree btree bubblesort dijkstra floyd fordfulkerson graham hashDivision hashDivisionLinear hashDivisionQuadratic hashMultiplication hashMultiplicationLinear hashMultiplicationQuadratic heapsort heapsortWithTrees insertionsort knapsack mergesort mergesortWithSplitting prim quicksort rbtree scc selectionsort sharir topologicSort warshall);
declare -a flags=(-d -d -l -l -l -l -l -l -l -l -l -l -l -l -d -l -l -l -l -d -l -d -d -l -l -l -l);

#setting filenames
nameoffile1="exercise"
nameoffile2="solution"

#if [ ${count2} = -1 ]; then
#	random_number=$(shuf -i 1-!alrithms[*] -n 1)	#calculate random exercise
#fi

if [ "$#" != "2" ]; then
	for i in ${!alrithms[*]}
	do
		nameoffile1=${alrithms[${i}]}
		nameoffile1+="_ex.tex"
		nameoffile2=${alrithms[${i}]}
		nameoffile2+="_sol.tex"
		java -jar DSALExercisesStudent.jar -a ${alrithms[${i}]} ${flags[${i}]} ${count} -e ${nameoffile1} -t ${nameoffile2}
		if [ ! -e "${nameoffile1}" ]; then
			echo "${nameoffile1}_argument_error" >> debug.txt
		fi
	done
else
	nameoffile1=${useralgo}
	nameoffile1+="_ex.tex"
	nameoffile2=${useralgo}
	nameoffile2+="_sol.tex"

	for i in ${!alrithms[*]}
	do
		if [ ${alrithms[${i}]} = ${useralgo} ]; then
			java -jar DSALExercisesStudent.jar -a ${alrithms[${i}]} ${flags[${i}]} ${count} -e ${nameoffile1} -t ${nameoffile2}
			if [ ! -e "${nameoffile1}" ]; then
				echo "${nameoffile1}_argument_error" #>> debug.txt
			fi
		fi
	done
fi

for file in *.tex; do pdflatex "$file" >> debug.txt; done

rm -f *.aux
rm -f *.log
#rm -f *.gz
rm -f *.tex
#rm -f debug.txt

mv ${actualpath}/*.pdf ${newpath}