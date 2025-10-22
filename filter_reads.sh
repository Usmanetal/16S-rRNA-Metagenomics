#!/bin/bash

# List of sample names (without extensions)
samples=(
  bulk_bottom
  rhizosphere_bottom
  bulk_top
  rhizosphere_top
)

# Make sure output directory exists
mkdir -p filtered_reads

# Optional: create logs directory for reports
mkdir -p logs_filtered

# Loop over each sample
for sample in "${samples[@]}"; do
  fastp -q 9 -l 1000 -b 2000 -G -A \
    -i "trimmed/${sample}.trimmed.fastq.gz" \
    -o "filtered_reads/${sample}.filt.fastq.gz" \
    -h "logs_filtered/${sample}.html" \
    -j "logs_filtered/${sample}.json"
done
