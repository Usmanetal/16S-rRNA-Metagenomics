#!/bin/bash

# ----------------------------
# Script: run_porechop.sh
# Purpose: Trim adapter sequences from nanopore reads using Porechop
# ----------------------------

# Set number of threads
THREADS=4

# Input and output directories
INPUT_DIR="data"
OUTPUT_DIR="trimmed"
LOG_DIR="logs"

# Create necessary directories
mkdir -p "$OUTPUT_DIR"
mkdir -p "$LOG_DIR"

# List of sample base names (without extensions)
samples=(
  bulk_bottom
  rhizosphere_bottom
  bulk_top
  rhizosphere_top
)

# Loop through samples
for sample in "${samples[@]}"; do
  input_file="${INPUT_DIR}/${sample}.fastq.gz"
  output_file="${OUTPUT_DIR}/${sample}.trimmed.fastq.gz"
  log_file="${LOG_DIR}/${sample}_porechop.log"

  echo "🔄 Processing: $sample"
  
  # Check if input file exists
  if [[ ! -f "$input_file" ]]; then
    echo "❌ Error: Input file not found: $input_file"
    continue
  fi

  # Skip if output already exists (optional safeguard)
  if [[ -f "$output_file" ]]; then
    echo "⚠️  Skipping $sample (already processed)"
    continue
  fi

  # Run porechop
  porechop -t "$THREADS" \
    -i "$input_file" \
    -o "$output_file" \
    --format fastq.gz \
    > "$log_file" 2>&1

  # Check exit status
  if [[ $? -eq 0 ]]; then
    echo "✅ Finished: $sample"
  else
    echo "❌ Failed: $sample — check $log_file for details"
  fi

done

echo "🎉 All done."
