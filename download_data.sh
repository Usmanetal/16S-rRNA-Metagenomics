#!/bin/bash

conda create -n 16s -c bioconda -c conda-forge -c defaults \
fastqc \
multiqc \
fastp \
porechop \
kraken2 \
krona

fastp -q 9 -l 1000 -b 2000 -G -A \
  -i trimmed/bulk_bottom.trimmed.fastq.gz \
  -o filtered_reads/bulk_bottom.filt.fastq.gz

fastp -q 9 -l 1000 -b 2000 -G -A \
  -i trimmed/rhizosphere_bottom.trimmed.fastq.gz \
  -o filtered_reads/rhizosphere_bottom.filt.fastq.gz

fastp -q 9 -l 1000 -b 2000 -G -A \
  -i trimmed/bulk_top.trimmed.fastq.gz \
  -o filtered_reads/bulk_top.filt.fastq.gz

fastp -q 9 -l 1000 -b 2000 -G -A




for f in bulk_bottom bulk_top rhizosphere_bottom rhizosphere_top; 
do wget https://zenodo.org/record/4274812/files/${f}.fastq.gz; done


