# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

from snakemake.utils import min_version

min_version("4.1.0")

onstart:
    shell("mail -s 'Workflow started' email_address < {log}")

onsuccess:
    shell("mail -s 'Workflow finished, no error' email_address < {log}")

onerror:
    shell("mail -s 'an error occurred' email_address < {log}")


UNIT_TO_SAMPLE = {
    unit: sample for sample, units in config["samples"].items()
    for unit in units}

# Output file format; possible values: cram, bam
OUTPUT_FORMAT = 'cram'

rule all:
    input: expand("reads/merged_samples/{sample}.{output_format}", \
                  sample=config["samples"], \
                  output_format=OUTPUT_FORMAT)

include_prefix="rules"

include:
    include_prefix + "/functions.py"
include:
    include_prefix + "/bwa_mem.rules"	
include:
    include_prefix + "/samtools.rules"

