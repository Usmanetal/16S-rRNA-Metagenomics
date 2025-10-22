#!/bin/bash
set -euo pipefail

# This will download and install the NCBI taxonomy data Krona uses to resolve 
# taxonomic names. It only needs to be done once (unless the taxonomy changes or gets corrupted).
# /home/usman/miniconda3/envs/16s/opt/krona/updateTaxonomy.sh

# Create output directory for Krona plots
mkdir -p krona_charts

# Loop over all Kraken2 .report output files
for kraken_file in kraken_reports/*.report; do
    sample_name=$(basename "$kraken_file" .report)
    krona_output="krona_charts/${sample_name}_krona.html"

    echo "Generating Krona chart for $sample_name..."

    # Convert Kraken2 output to Krona-compatible format and generate HTML
    cut -f2,3 "$kraken_file" | ktImportTaxonomy -n "$sample_name" -o "$krona_output" -

    echo "Krona chart created: $krona_output"
done

echo "✅ All Krona charts generated in 'krona_charts/'"
