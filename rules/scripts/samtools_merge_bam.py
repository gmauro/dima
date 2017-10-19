from subprocess import run

if len(snakemake.input) > 1:
    cmd = ['samtools', 'merge', snakemake.output[0]]
    for i in snakemake.input:
        cmd.append(i)
    run(cmd)
else:
     run(['cp', snakemake.input[0], snakemake.output[0]])
     run(['touch', '-h', snakemake.output[0]])
