#!/bin/bash

AUTHOR="imandric1"



################################################################
##########          The main template script          ##########
################################################################



# STEPS OF THE SCRIPT
# 1) prepare input if necessary
# 2) run the tool
# 3) transform output if necessary
# 4) compress output
# 5) send the output to the designated directory
# 6) remove temporary files


# THE COMMAND LINE INTERFACE OF THE WRAPPER SCRIPT
# $tool $input1 $input2 $tmpdir $outdir $kmers $others
# |      mandatory part               | | extra part |
# <-----------------------------------> <------------>




if [ $# -lt 5 ]
then
echo "********************************************************************"
echo "Script was written for project : Best practices for conducting benchmarking in the most comprehensive and reproducible way"
echo "This script was written by Igor Mandric"
echo "********************************************************************"

echo ""
echo "1 <input1> - _1.fastq"
echo "2 <input2> - _2.fastq"
echo "3 <tmpdir> - dir to save the output"
echo "4 <kmer>   - kmer length"
echo "5 <path>   -  where tool is intalled. In case it is globally installed use "\"\"
echo "--------------------------------------"
exit 1
fi






# mandatory part
input1=$1
input2=$2
tmpdir=$3

# extra part (tool specific)
kmer=$4
path=$5
toolName="pollux"
toolPath="$path/$toolName"




filename1=$(echo ${input1} | awk -F "_1" '{print $1}')
filename=$(basename $filename1)




# STEP 0 - create output directory if it does not exist

mkdir $tmpdir


# -----------------------------------------------------



# STEP 1 - prepare input if necessary (ATTENTION: TOOL SPECIFIC PART!)


# -----------------------------------





# STEP 2 - run the tool (ATTENTION: TOOL SPECIFIC PART!)

now="$(date)"
wdir=${tmpdir}/$toolName-$( date +%Y-%m-%d-%H-%M-%S )
mkdir $wdir
logfile=$wdir/report_${filename}.log
echo "START" > $logfile


printf "%s --- RUNNING %s\n" "$now" $toolName >> $logfile



#run the command (in a temporary directory)
res1=$(date +%s.%N)

echo "$toolPath -i $input1 $input2 -p -o $wdir -k $kmer >> $logfile 2>&1 " >>$logfile

$toolPath -i $input1 $input2 -p -o $wdir -k $kmer >> $logfile 2>&1 
res2=$(date +%s.%N)
dt=$(echo "$res2 - $res1" | bc)
dd=$(echo "$dt/86400" | bc)
dt2=$(echo "$dt-86400*$dd" | bc)
dh=$(echo "$dt2/3600" | bc)
dt3=$(echo "$dt2-3600*$dh" | bc)
dm=$(echo "$dt3/60" | bc)
ds=$(echo "$dt3-60*$dm" | bc)
now="$(date)"
printf "%s --- TOTAL RUNTIME: %d:%02d:%02d:%02.4f\n" "$now" $dd $dh $dm $ds >> $logfile

now="$(date)"
printf "%s --- FINISHED RUNNING %s %s\n" "$now" $toolName >> $logfile

# ---------------------




# STEP 3 - transform output if necessary (ATTENTION: TOOL SPECIFIC PART!)

# if you need to transform fasta to fastq - here is the command:
#     awk '{if(NR%4==1) {printf(">%s\n",substr($0,2));} else if(NR%4==2) print;}' file.fastq > file.fasta

now="$(date)"
printf "%s --- TRANSFORMING OUTPUT\n" "$now" >> $logfile




cat $wdir/${filename}_1.fastq.corrected $wdir/${filename}_2.fastq.corrected | gzip - > $wdir/${toolName}_${filename}.corrected.fastq.gz
rm $wdir/${filename}_1.fastq.corrected
rm $wdir/${filename}_2.fastq.corrected

now="$(date)"
printf "%s --- TRANSFORMING OUTPUT DONE\n" "$now" >> $logfile





printf "DONE" >> $logfile



