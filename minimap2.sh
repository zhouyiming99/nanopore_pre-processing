#!/bin/bash

ref=/data2/backup/share_1423_backup/liuqi/ribo/ribotoolkit/db/mRNA/osa_IRGSP_1.txdb.fa
wt_fastq=/data1/zhouyiming/DT4/crtl-1-1/fq/pass.fq

minimap2 -ax splice -uf -k14 -t 20 $ref $wt_fastq > c1.sam
samtools view -@ 8 -bh -F 2324 c1.sam | samtools sort -@ 8 -o c1.bam
samtools index c1.bam
