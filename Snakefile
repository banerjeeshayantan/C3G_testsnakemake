samples = ["brain", "liver"]

rule all:
    input:
        expand("result_gtf/{sample}.gtf",sample=samples),
        "merged_gtf/merge.gtf",
        expand("{sample}/",sample=samples),




rule stringtie:
    input:
        ref = "data/Mus_musculus.GRCm38.94.gtf",
        bam = "data/samples/{sample}.bam"
    output:
        "result_gtf/{sample}.gtf"
    threads: 8
    shell:
        "stringtie -L -G {input.ref} {input.bam} -o {output}"       



rule stringtie_merge:
    input:
        ref = "data/Mus_musculus.GRCm38.94.gtf",
        assembly = "data/assembly.txt"
    output:
        "merged_gtf/merge.gtf"
    threads: 8
    shell:
        "stringtie --merge -o {output} -G {input.ref} {input.assembly}"

rule ballgown_input_prep:
    input:
        merged_gtf = "merged_gtf/merge.gtf",
        bam = "data/samples/{sample}.bam"
    output:"{sample}/"
    threads: 8
    shell:
        "stringtie -G {input.merged_gtf} {input.bam} -b {output}"
        




