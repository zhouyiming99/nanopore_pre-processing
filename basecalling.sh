#!/bin/bash

guppy=/data1/zhouyiming/software/Guppy
wt_fast5=/data1/zhouyiming/qian_3/WHXWZB-2023080124A/raw_data/Nanopore/C-1/20230818-NPL231150-P4-PAQ95445/PAQ95445/fast5_pass
wt_basecalled_fast5=/data1/zhouyiming/qian_3/WHXWZB-2023080124A/raw_data/Nanopore/C-1/20230818-NPL231150-P4-PAQ95445/PAQ95445/fastq_pass

#basecalling:
$guppy/ont-guppy-cpu/bin/guppy_basecaller -i $wt_fast5 -s $wt_basecalled_fast5 -c $guppy/ont-guppy-cpu/data/rna_r9.4.1_70bps_hac.cfg --fast5_out -r --cpu_threads_per_caller 30

#merge fastq files:
cat $wt_basecalled_fast5/pass/*fastq > C-1.fastq

#filter basecalling failed reads:
cd $wt_basecalled_fast5
mkdir workspace_fail
awk '{if($10=="FALSE"){print $1}}' sequencing_summary.txt > fail_fast5.txt
cat fail_fast5.txt | while read id;do mv workspace/$id workspace_fail;done

