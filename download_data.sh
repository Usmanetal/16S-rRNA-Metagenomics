#!/bin/bash





for f in bulk_bottom bulk_top rhizosphere_bottom rhizosphere_top; 
do wget https://zenodo.org/record/4274812/files/${f}.fastq.gz; done

