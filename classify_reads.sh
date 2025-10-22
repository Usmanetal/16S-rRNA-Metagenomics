#!/bin/bash
set -euo pipefail

# Create directory for Kraken2 reports if it doesn't exist
mkdir -p kraken_reports

# Set variables
krakendb="16S_DB"
threads=4
confidence=0.1

# List of sample names (matching fastq files)
samples=(
  "bulk_bottom"
  "rhizosphere_bottom"
  "bulk_top"
  "rhizosphere_top"
)

# Loop over samples and run Kraken2 classification
for sample in "${samples[@]}"; do
  input_file="filtered_reads/${sample}.filt.fastq.gz"
  report_file="kraken_reports/${sample}.report"
  output_file="kraken_reports/${sample}.kraken"

  echo "Processing sample: $sample"
  kraken2 --use-names \
          --db "$krakendb" \
          --threads "$threads" \
          --confidence "$confidence" \
          --report "$report_file" \
          --gzip-compressed "$input_file" > "$output_file"
done

echo "All samples processed successfully!"
