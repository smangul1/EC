# Introduction

This project includes simulated and 'golden standard' datasets, software and scripts that we used to benchmark  error correction tools in our study  : Comprehensive benchmarking of error correction methods for next generation sequencing via unique molecular identifiers.


# Golden standard data 

We have used simulated and experimentally obtained ‘golden standard’ data from human and Human Immunodeficiency Virus (HIV) virus. We used datasets threee experimentally obtained datasets (T1, T2, T3) and three simulated datasets (S1, S2, S3) to becnmark error corretions algorithms. 

### T1: reads derived from human genomic DNA data

#### T1a : genome in a bottle data

We use genome in a bottle data (GIAB, http://jimb.stanford.edu/giab/). The data was derived from 

composed of high-quality variant calls


The raw data is here

ftp://ftp-trace.ncbi.nih.gov/giab/ftp/data/NA12878/NIST_NA12878_HG001_HiSeq_300x/


Some discussion here
https://www.biostars.org/p/239598/

Paragraph from the paper 

These data and other data sets for NA12878 are available at the Genome in a Bottle ftp site at NCBI (ftp://ftp-trace.ncbi.nih.gov/giab/ftp/data/NA12878) and are described on a spreadsheet at http://genomeinabottle.org/blog-entry/existing-and-future-na12878-datasets. In addition, the results of this work (high-confidence variant calls and BED files describing confident regions) are available at ftp://ftp-trace.ncbi.nih.gov/giab/ftp/data/NA12878/variant_calls/NIST along with a README.NIST describing the files and how to use them. T


We downloaded raw paired-end reads from http://www.ebi.ac.uk/ena/data/view/PRJNA162355. 
Ground true (high-quality variant calls) was downloaded from ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.3.2/GRCh38/

#### T1b : 100G WGS 
We use higly covered positions of WXS to define higly confident calls and use those to estimate error rate in corresponding samples obtained by WGS. 

We downloaded the 30x downsampled NA12878 BAM file from https://github.com/genome-in-a-bottle/giab_data_indexes/blob/master/NA12878/alignment.index.NA12878_HiSeq_downsampled30X_GRCh37_10262015

This Python script was used to split the BAM file into two files randomly: one containing 90% of the reads and one containing 10%
https://gist.github.com/brianhill11/7aeeeb6d94edfb868e5595aac04a0dd6

#### S1a

We use combination of real data and the clonality model to generate cancer data. We have use a normal WGS sample and split the reads into 2 population. For example 90%/10%, 95%/5%
In each of the population we introduce in-silico variants by using https://github.com/adamewing/bamsurgeon with -s option preventing the conflict with the real variants from the data. 

The variants for each of the populations were randomly generated at 1SNP per 1000 bases. We do this 5 times. 



## Reads derived from human genomic DNA data (T2,S2)

We have also used publically available TCR-Seq data with attached 12bp UMIs from 10 chronic HIV patients (SRP045430). 

Data obtaine from : Best, Katharine, et al. "Dynamic perturbations of the T-cell receptor repertoire in chronic HIV infection and following antiretroviral therapy." Frontiers in immunology 6 (2016): 644.


## Reads derived from human genomic DNA data (in-house) (T3,S3)

We used the UMI-based high-fidelity sequencing protocol (also known as safe-SeqS) to eliminate errors from the sequencing data. Full description of high-fidelity sequencing protocol is provided in Mangul, Serghei, et al. "Accurate viral population assembly from ultra-deep sequencing data." Bioinformatics 30.12 (2014): i329-i337.

We have used in-house sequencing data derived from 3.4 kb region of Human Immunodeficiency Virus (HIV) spanning the Gag/Pol genes.  The data consist of 107 millions 2x100bp reads with attached 13bp UMIs.  Applying high-fidelity protocol resulted in 3.1 million reads used to evaluate error correction algorithms (Golden Dataset 1: GD1). 


### Information about the error correction tools included in the benchmarking study.


For each of the tools we provide schell script with instlation commands. Instalation scripts are available at 


Table S1. Information about the error correction tools included in the benchmarking study.

| Name | Version | Underlying algorithm | Data structure | Types of reads accepted (single-end(SE) or pairen-end(PE)) | Organism | Journal | Published year | Programming language | In the publication compared to | Tools webpage | Software Dependencies |  Default k-mer size |  Read trimming |
| --- | --- | --- | --- | --- | --- | --- |  --- |  ---| ---|  --- |  ---| ---| ---|
| BLESS | 1.02 | k -mer spectrum | Bloom filter and hash table   | SE and PE | Human, E. Coli, Staphylococcus aureus | Oxford Bioinformatics | 2014 | C++ | SGA, QuorUM, Lighter, BFC, DecGPU, ECHO, HiTEC, Musket, Quake, Reptile | https://sourceforge.net/p/bless-ec/wiki/Home/ |  MPICH 3.1.3, OpenMPI 1.8.4, Boost library, google spareshash, klib, KMC, murmurhash3, zlib, pigz | N/A | YES |
| Fiona | 0.2.8 | k -mer spectrum | partial suffix array |  SE  |  human, drosophila, bacteria, C. elegans | Bioinformatics | 2014 | C++ | Allpaths-LG,Coral,H-Shrec,ECHO,HiTEC,Quake  | https://github.com/seqan/seqan/tree/master/apps/fiona  | N/A | N/A | YES |
| Pollux | 1.0.2 | k -mer spectrum | Hash table,  | SE, PE | human, bacteria | BMC Bioinformatics | 2015 | C | Quake, SGA, BLESS, Musket, RACER | https://github.com/emarinier/pollux | 64 bit Unix-based OS,  | 31k | YES |
| BFC | 1.0 | k -mer spectrum | Bloom filter and hash table | SE, PE (interleaved) | Human,C. Elegans | _Bioinformatics_ | 2015 | C | BLESS-v0p23 (Heo etal., 2014), Bloocoo-1.0.4 (Drezen etal., 2014), fermi2-r175 (Li, 2012), Lighter-20150123 (Song etal., 2014), Musket-1.1 (Liu etal., 2013) and SGA-0.9.13 (Simpson and Durbin, 2012) | https://github.com/lh3/bfc | N/A | Depends on input genome size | NO |
| Lighter | 1.1.1 | k -mer spectrum | Bloom filter | SE and PE | Human, E. Coli, C. elegan | _Genome Biology_ | 2014 | C++ | Quake v0.3, Musket v1.1, Bless v0p17, Soapec v2.0.1 | https://github.com/mourisl/Lighter | N/A | N/A | NO |
| Musket | 1.1 | k-mer spectrum | Bloom filter and hash table | SE and PE | Human, E. Coli, C. elegans | _Oxford Bioinformatics_ |  2012 | C++ | SGA, Quake | http://musket.sourceforge.net/homepage.htm | N/A | N/A | NO |
| Racer | 1.0.1 | k-mer spectrum | Hash table | SE and PE | Human, bacteria, virus, C. elegans, Drosophila | _Bioinformatics_ | 2013 | C++ | Coral, HITEC, Quake, Reptile, SHREC | http://www.csd.uwo.ca/~ilie/RACER/ | OpenMP | N/A | NO |
| Reptile | 1.1 | k-mer spectrum | Hamming graph | Doesn't say | Human, Acinetobacter sp., E. Coli | _Bioinformatics_ | 2010 | C++ | SHREC | http://aluru-sun.ece.iastate.edu/doku.php?id=reptile | Perl, GNU make, C++ compiler | 24 | NO |
| Quake | 0.3 | k-mer spectrum | Bit array index | SE or PE | Human, E. Coli  | _Genome Biology_ | 2010 | C++, R | SOAPdenovo,EULER, SHREC | http://www.cbcb.umd.edu/software/quake | N/A | 15 | YES |
| SOAPdenovo2 Corrector | 2.03 | k-mer spectrum | Hash table | SE, PE | Human, PhiX174, Drosophilla, Saccharomyces cerevisiae | _GigaScience_ | 2012 | C/C++ | SOAPdevnovo1, ALLPATHS-LG | http://soap.genomics.org.cn/about.html | GCC 4.4.5 or later | N/A |
| ECHO | 1.12 | MSA* | Hash table | SE | Human,  | Genome Research | 2012 | Python | SA, SHREC | http://uc-echo.sourceforge.net/ | GCC 4.1 or later, Python 2.6, numpy, scipy | 1/6 (length of read) | YES |
| Coral | 1.4.1 | MSA* | Hash table | SE, PE (interleaved) | No Organism | _Bioinformatics_ | 2011 | C | COMPASS 3.0, HHalign 1.5.1.1 and PSI-BLAST | https://www.cs.helsinki.fi/u/lmsalmel/coral/ | N/A | N/A | YES |
| RECKONER | 1.1 | k-mer spectrum | Hash table | Doesn't say | S. cerevisiae, C. elegans, M. acuminata | _Bioinformatics_ | 2017 | C++ | Ace 1.01, BFC-ht v1, BLESS 0.24, Blue 1.1.2, Karect 1.0, Lighter 1.0.4, Musket 1.1, Pollux 1.00, RACER 1.0.1, Trowel 0.1.4.3 | https://github.com/refresh-bio/RECKONER | KMC3, KMC tools | N/A | NO |
| SGA | 0.10.15 | FM-index search | FM-index | SE and PE | C. elegans, E. coli, Human | Genome Research | 2012 | C++ | Velvet, ABySS, SOAPdenovo, Quake, HiTEC | https://github.com/jts/sga | Google sparse hash library, bamtools, zlib, jemalloc (optional), pysam, ruffus | 31 | NO 
| ShoRAH | 1.1.0 | clustering| not specified   | SE | RNA viruses | BMC Bioinformatics | 2011 | C++, Python, Perl | no comparison | https://github.com/cbg-ethz/shorah |  Biopython, NumPy, Perl, zlib, pkg-config, GNU scientific library| N/A | YES |
| KEC | 1.0 | k -mer spectrum | Hash table   | SE | RNA viruses | BMC Bioinformatics | 2012 | Java | ShoRAH | http://alan.cs.gsu.edu/NGS/?q=content/pyrosequencing-error-correction-algorithm |  FAMS; ClustalW2 or Muscle (optional) | 25 | NO |

* MSA - multiple sequence alignment
* Command for checking whether a tool trims reads:
```
cd /u/home/n/ngcrawfo/scratch/ERROR_CORRECTION/simulated_reads_ec/results
for tool in `ls`; do echo -n "${tool} "; f=`ls ${tool}/IGH/splitted/sim_rl_100_cov_128/ | head -1`; n=`cat ${tool}/IGH/splitted/sim_rl_100_cov_128/${f} | awk 'NR % 4 == 2 {print length($0)}' | sort | uniq | wc -l`; if [[ $n -eq 1 ]]; then echo "NO"; else echo "YES"; fi; done
```


# How to run error correction tools

## Bless
#### To install:
```make```
#### To run:
``` module load openmpi; module load gcc/4.9.3 ```
```./bless -read1 <forward fastq> -read2 <reverse fastq> -load prefix -prefix <new prefix> -kmerlength <k-mer length>```


## Fiona
### To install:
```make```
### To run:
```fiona [OPTIONS] -g GENOME_LENGTH INPUT_FILE OUTPUT_FILE```

## ECHO
### To install:
```make```
### To run:
```python ErrorCorrection.py -o output/sample_data.fastq sample_data.txt```

## Pollux
### To install:
```make```
### To run
```./pollux -p -i <fastq_reads_1> <fastq_reads_2> -o ouput```

## BFC
### To install:
```make```
### To run:
```./bfc -s <approximate genome size> -k <k-mer length> <fastq file> > <output file>```


## Lighter
### To install:
```make```
### To run:
```./lighter -r <fastq file> -K <k-mer length> <genome size>```


## Musket
### To install:
```make```
### To run:
```./musket -k <k-mer length> <estimated total number of k-mers for this k-mer size> -o <output file name> <fastq file>```

## RACER
### To install:
```make```

### To run:
Use run_racer.sh (update the RACER_DIR, DATA_DIR, and GENOME_SIZE variables appropriately).

## Reptile
### To install:
```make```
in src, utils/reptile_merger, and utils/seq-analy.

### To run:
Use run_reptile.sh (update the REPTILE_DIR and DATA_DIR variables appropriately).

## Quake
### To install:
```
# Edit the Makefile to include the location of where the boost library is installed
sed -i "s#-I/opt/local/var/macports/software/boost/1.46.1_0/opt/local/include#-I/usr/include/boost#" Quake/src/Makefile
make
```
### To run:
```
cat <fastq file> | Quake/bin/count-kmers -k <kmer-length> > counts.txt
Quake/bin/cov_model --int counts.txt
Quake/bin/correct -r <fastq file> -k <k-mer length> -m counts.txt -a cutoff.txt
```

## SOAPdenovo Corrector
### To install:
```make```
### To run:
```
# If k-mer size <= 17:
./KmerFreq_AR -k <k-mer length> -p <output prefix> <list of read files>
./Corrector_AR -k <k-mer length> <prefix.freq.cz> <prefix.freq.cz.len> <list of read files>

# If k-mer size > 17:
./KmerFreq_HA -k <k-mer length> -p <output prefix> -L <maximum read length> -l <list of read files>
./Corrector_HA -k <k-mer length> <prefix.freq.cz> <list of read files>
```

## Coral
### To install:
```make```
### To run:
```./coral [-f, -fq or -fs for input file format] <input file> -o <output file>```

## RECKONER
### To install:
```make```
### To run:
```reckoner -memory <8G> -prefix <output directory> -kmerlength <K> <list of fastq files>```

## SGA
### To install:
```
./autogen.sh
./configure && make && make install
```
### To run:
```
sga preprocess <input fastq> > <output fastq>.preprocessed.fastq
sga index -a ropebwt <output fastq>.preprocessed.fastq
sga correct -k <K> -o <output fastq>.out.fastq <output fastq>.preprocessed.fastq
```

# Preparing golden true datasets

### T3

Before error correction I deleted barcode part from each original read (13 bp in the beginning of the read ). The length became 87bp.


# Virus-specific tools

We run 2 virus-specific tools able to correct errors in the reads generated from viral population and reconstruct local haplotypes

We run KEC and Shorah

## KEC
As input I mixed forward and reverse reads together. KEC can not work with paired end reads. 
KEC changed original reads names and collapsed some reads. 

## Shorah
Shohar is alligment based tool. We maped the read sonto the viral reference genome prior to running tool



# kmer size selection

Error correction tools require k-mer size as a parameter. We use the following formula to caclulate the k-mer size using the length of the genome : l= log4 200*G, where G is the genome size 

### T1 and S1
k=19
genome size=3 000 000 000

# T2 

k=18 genome size=405000 log4(405*1000)X2=18

### S2
k=18
genome size=405000
log4(405*1000)X2=18

### T3
k=15
genome size=3400

 Since we have relatively long read lengths of 88bp
and relatively high average read coverage levels of up to 100x, we chose a larger
k-mer size of 15. 
