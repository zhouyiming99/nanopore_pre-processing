# Nanopore Sequencing Pre-processing and Alignment

This repository contains shell scripts for handling Nanopore long-read sequencing data, including basecalling, data organization, and sequence alignment.

## Scripts Overview

### 1. `basecalling.sh`
This script performs basecalling and initial data cleaning:
- **Basecalling**: Uses `guppy_basecaller` (CPU version) with the RNA R9.4.1 hac configuration.
- **Fastq Merging**: Consolidates all passed FASTQ files into a single file (`C-1.fastq`).
- **Data Filtering**: Identifies failed reads from `sequencing_summary.txt` and moves the corresponding FAST5 files to a separate directory (`workspace_fail`).

### 2. `minimap2.sh`
This script handles the alignment of processed reads to a reference transcriptome:
- **Alignment**: Uses `minimap2` with splice-aware settings (`-ax splice`) optimized for Nanopore data.
- **Post-processing**: Uses `samtools` to convert SAM files to BAM format, filter reads, and perform coordinate sorting and indexing.

## Prerequisites

Ensure the following tools are installed and accessible in your environment:
- **Guppy Basecaller** (Oxford Nanopore Technologies)
- **Minimap2**
- **Samtools**

## Usage

1. **Configure Paths:**
   Open the `.sh` scripts and update the directory paths (e.g., `guppy`, `wt_fast5`, `ref`) to match your local server environment.

2. **Make scripts executable:**
   ```bash
   chmod +x basecalling.sh minimap2.sh
   ```

3. **Run the scripts:**
   ```bash
   # For Basecalling
   ./basecalling.sh

   # For Alignment
   ./minimap2.sh
   ```

## Configuration Details
- **Basecalling Model**: `rna_r9.4.1_70bps_hac.cfg`
- **Minimap2 Parameters**: `-ax splice -uf -k14` (optimized for direct RNA or cDNA kits)
- **Samtools Filtering**: `-F 2324` (excludes unmapped, secondary, and supplementary alignments)
