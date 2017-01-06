REFERENCE = mircea.fa
MYSCRIPTS = /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline
NUCMER = /mnt/home/mahmoud4/MUMmer3.23
SPADES = /mnt/home/mahmoud4/SPAdes-3.9.0-Linux/bin
MEGAHIT=/mnt/home/mahmoud4/megahit
TRIM = /opt/software/Trimmomatic/0.32
TOOLKIT =/opt/software/FASTX/0.0.14--GCC-4.4.5/bin
SANDBOX = /opt/software/khmer/2.0--GCC-4.8.2
SCRIPTS = /opt/software/khmer/2.0--GCC-4.8.2/scripts
mc = 1000 2000 3000
newref = /mnt/home/ctb/2015-metagenome-assembly/new-refs/new-refs.fa 
#-----------------------------------------------------------All quality-------------------------------------------------------------------------------------
quality: SRR606249-1.fastq.gz   SRR606249-2.fastq.gz \
	SRR606249.se.qc.fq.gz 
#-------------------------------------------------SPAdes Quality----------------------------------------------------------------------------------------
spades-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.spades.d/scaffolds.fasta \
	spades-quality-assembly.fa 

#-------------------------------------------------IDBA Quality----------------------------------------------------------------------------------------
idba-quality: SRR606249.pe.qc.fq.gz \
	SRR606249.pe.fa \
	SRR606249.idba.d.qc/scaffold.fa \
	idba-quality-assembly.fa 
#------------------------------------------------Megahit Quality-------------------------------------------------------------------------------------------- 
megahit-quality: SRR606249.pe.qc.fq.gz \
	megahit.qc.pe/final.contigs.fa \
	megahit-quality-assembly.fa  
#-------------------------------------------------Run Analysis----------------------------------------------------------------------------------------------
analysis: idba-quality-assembly.fa spades-quality-assembly.fa megahit-quality-assembly.fa \
	megahit-quality-assembly500.fa \
	mqc500.coords \
	assemblies.stats.QC.AMBIGUOUS.99 \
	assemblies.stats.QC.AMBIGUOUS.95 \
	stats 

#calculate reads coverage 
readcoverage: SRR606249.pe.qc.fq.gz \
	qc-ref.sam \
	unmapped-qc-to-ref \
	SRR606249.qc.coverage
#count the reads that map to the unaligned contigs and not to the reference 
countunmapped: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa \
	iq-unmapped.count \
	sq-unmapped.count \
	mq-unmapped.count
#for the unaligned contigs, find their coverage 
unalignedcoverage: SRR606249.pe.qc.fq.gz assemblies.stats.QC.AMBIGUOUS.99 \
	iqc.AM99-mapped-reads \
	iqc.AM99.unmapped.sam \
	iqc.unmapped.out \
	sqc.AM99-mapped-reads \
	sqc.AM99.unmapped.sam \
	sqc.unmapped.out \
	mqc.AM99-mapped-reads \
	mqc.AM99.unmapped.sam \
	mqc.unmapped.out 
mincontig-analysis: megahit-quality-assembly.fa \
	megahit-quality-assembly3000.fa \
	mqc3000.coords \
	assemblies.stats.QC.AMBIGUOUS3000.99
 
#run-analysis.sh includes in addition to the above: common-uncovered-coverage.out and mqc500.dist	 
#-----------------------------------------------------------QUALITY STARTS-------------------------------------------------------------------------------
SRR606249.se.qc.fq.gz:   SRR606249-1.fastq.gz   SRR606249-2.fastq.gz
	java -jar ${TRIM}/trimmomatic-0.32.jar PE  SRR606249-1.fastq.gz   SRR606249-2.fastq.gz  s1_pe s1_se s2_pe s2_se ILLUMINACLIP:${TRIM}/adapters/TruSeq2-PE.fa:2:40:15 \
 	LEADING:2 TRAILING:2 SLIDINGWINDOW:4:2 MINLEN:25 
	${SCRIPTS}/interleave-reads.py s1_pe s2_pe | gzip -9c > SRR606249.pe.qc.fq.gz 
	cat s1_se s2_se | gzip -9c > SRR606249.se.qc.fq.gz

#-------------------------------------------------------------SPADES QUALITY---------------------------------------------------------------------------------
SRR606249.spades.d/scaffolds.fasta: SRR606249.pe.qc.fq.gz SRR606249.se.qc.fq.gz 
	/usr/bin/time -a -o sqc.txt  ${SPADES}/spades.py --meta --pe1-12 SRR606249.pe.qc.fq.gz --pe1-s SRR606249.se.qc.fq.gz -o SRR606249.spades.d

spades-quality-assembly.fa: SRR606249.spades.d/scaffolds.fasta  
	python ${MYSCRIPTS}/multi-rename.py assembly SRR606249.spades.d/scaffolds.fasta  > spades-quality-assembly.fa

#-----------------------------------------------------------------IDBA QUALITY-------------------------------------------------------------------------------
SRR606249.pe.fa: SRR606249.pe.qc.fq.gz 
	fastq-to-fasta.py -n SRR606249.pe.qc.fq.gz >SRR606249.pe.fa 
SRR606249.idba.d.qc/scaffold.fa: SRR606249.pe.fa
	/usr/bin/time -a -o iqc.txt idba_ud --pre_correction -r SRR606249.pe.fa -o SRR606249.idba.d.qc 

idba-quality-assembly.fa: SRR606249.idba.d.qc/scaffold.fa
	python ${MYSCRIPTS}/multi-rename.py assembly SRR606249.idba.d.qc/scaffold.fa > idba-quality-assembly.fa
#---------------------------------------------------------------Megahit Quality------------------------------------------------------------------------------
megahit.qc.pe/final.contigs.fa: SRR606249.pe.qc.fq.gz  
	#rm -r megahit.qc.pe
	/usr/bin/time  -a  -o megqc.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only --presets meta-large --12 SRR606249.pe.qc.fq.gz -r SRR606249.se.qc.fq.gz -o megahit.qc.pe 

megahit-quality-assembly.fa: megahit.qc.pe/final.contigs.fa 
	python ${MYSCRIPTS}/multi-rename.py assembly megahit.qc.pe/final.contigs.fa > megahit-quality-assembly.fa	 
#----------------------------------------------------------------DIGINORM STARTS-----------------------------------------------------------------------------
SRR606249.ignore.long: SRR606249.pe.qc.fq.gz
	extract-long-sequences.py -l 20 SRR606249.pe.qc.fq.gz -o SRR606249.ignore.long

SRR606249.ignore.long.pe: 
	extract-paired-reads.py SRR606249.ignore.long
	mv SRR606249.pe.qc.fq.gz SRR606249.old
	gzip -c SRR606249.ignore.long.pe > SRR606249.pe.qc.fq.gz

normC20k20.kh:SRR606249.pe.qc.fq.gz
	normalize-by-median.py -p -k 20 -C 20 -N 4 -x 1e9 --savegraph normC20k20.kh SRR606249.pe.qc.fq.gz
	normalize-by-median.py -C 20 --loadgraph normC20k20.kh --savegraph normC20k20.kh SRR606249.se.qc.fq.gz

SRR606249.pe.qc.fq.gz.keep.abundfilt: normC20k20.kh
	filter-abund.py -V normC20k20.kh *.keep 

SRR606249.pe.qc.fq.gz.keep.abundfilt.pe:  
	extract-paired-reads.py SRR606249.pe.qc.fq.gz.keep.abundfilt 

SRR606249.pe.qc.fq.gz.keep.abundfilt.se.keep:
	normalize-by-median.py -C 5 -k 20 -N 4 -x 1e9 --savegraph normC5k20.kh -p SRR606249.pe.qc.fq.gz.keep.abundfilt.pe 
	normalize-by-median.py -C 5 --savegraph normC5k20.kh --loadgraph normC5k20.kh SRR606249.pe.qc.fq.gz.keep.abundfilt.se \
	SRR606249.se.qc.fq.gz.keep.abundfilt

SRR606249.se.kak.qc.fq.gz:
	cat  SRR606249.pe.qc.fq.gz.keep.abundfilt.pe >  SRR606249.pe.kak.qc.fq.gz
	cat  SRR606249.pe.qc.fq.gz.keep.abundfilt.se  SRR606249.se.qc.fq.gz.keep.abundfilt >  SRR606249.se.kak.qc.fq.gz 
#---------------------------------------------------------------SPADES DIGINORM------------------------------------------------------------------------------
spades-diginorm-1:*.pe.kak.qc.fq.gz
	.spades-dig.sh \
	touch spades-diginorm-1

spades-diginorm-2: SRR606249.pe.kak.qc.fq.gz SRR606249.se.kak.qc.fq.gz
	/usr/bin/time -a -o sdig.txt ${SPADES}/spades.py --meta --pe1-12 SRR606249.pe.kak.qc.fq.gz -o SRR606249.pe.kak.qc.spades.d
	/usr/bin/time -a -o sdig.txt ${SPADES}/spades.py --meta --pe1-12 SRR606249.se.kak.qc.fq.gz -o SRR606249.se.kak.qc.spades.d
	
finalize-spades-diginorm:  SRR606249.spades.d/contigs.fasta 
	python ${SANDBOX}/sandbox/calc-best-assembly.py SRR606249.*e.kak.qc.spades.d/contigs.fasta -o spades-diginorm-best.fa
	python ${MYSCRIPTS}/multi-rename.py assembly spades-diginorm-best.fa > spades-diginorm-assembly.fa
#------------------------------------------------------------------IDBA DIGINORM-----------------------------------------------------------------------------
idba-diginorm-1: *.pe.kak.qc.fq.gz  
	.idba-dig.sh \
	touch idba-diginorm-1

idba-diginorm-2: SRR606249.pe.kak.fa 
	/usr/bin/time -a -o idig.txt idba_ud --pre_correction -r SRR606249.pe.kak.fa  -o SRR606249.idba.d.digi
	#/opt/software/IDBAUD/1.1.0--GCC-4.4.5/binidba  --pre_correction -r SRR606249.pe.kak.fa  -o SRR606249.idba.d.digi

finalize-idba-diginorm: SRR606249.idba.d.digi/scaffold.fa	
	python ${SANDBOX}/sandbox/calc-best-assembly.py SRR606249.idba.d.digi/scaffold.fa -o idba-diginorm-best.fa
	python ${MYSCRIPTS}/multi-rename.py assembly idba-diginorm-best.fa > idba-diginorm-assembly.fa
#-------------------------------------------------------------Megahit DIGINORM------------------------------------------------------------------------------
megahit-digi-1:
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.pe.kak.qc.fq.gz -o megahit.digi.pe
	/usr/bin/time  -a  -o megdigi.txt python ${MEGAHIT}/megahit -l 101 -m 1e+10 --cpu-only -r SRR606249.se.kak.qc.fq.gz -o megahit.digi.se


protocol-partition-below: normC5k20.kh *.kak.*.fq.gz
	python ${SANDBOX}/sandbox/filter-below-abund.py normC5k20.kh *.kak.*.fq.gz 


protocol-partition-rename-1: SRR606249.pe.kak.qc.fq.gz.below SRR606249.se.kak.qc.fq.gz.below
	mv SRR606249.pe.kak.qc.fq.gz.below  SRR606249.pe.kak.qc.fq.gz.below.fq &&  mv SRR606249.se.kak.qc.fq.gz.below SRR606249.se.kak.qc.fq.gz.below.fq 

protocol-partition-run: normC5k20.kh SRR606249.pe.kak.qc.fq.gz.below.fq  SRR606249.se.kak.qc.fq.gz.below.fq 
	do-partition.py -k 32 -x 1e9 --threads 4 kak *.kak.qc.fq.gz.below.fq


protocol-partition-extract: *.part  
	extract-partitions.py -X 100000 kak *.part


protocol-partition-rename-2:  
	./seperate.sh \
	touch protocol-partition-rename-2

protocol-partition-compress: 
	gzip *.pe.fq  *.se.fq

#------------------------------------------------------------------Spades Partition--------------------------------------------------------------------------
spades-partition-1: kak*.pe.fq.gz
	.spades-part.sh \
	touch spades-partition-1

spades-partition-2: *.pe.fq
	.spades-part-run.sh \
	touch spades-partition-2

spades-partition-3: kak.group*.pe.fq.gz
	.spades-part-finalize.sh \
	touch spades-partition-3

finalize-spades-partition: 
	python ${MYSCRIPTS}/multi-rename.py assembly spades-partition-best.group*.fa > spades-partition-assembly.fa
#-----------------------------------------------------------------IDBA Partition-----------------------------------------------------------------------------
idba-partition-1: kak*.pe.fq.gz
	.idba-part.sh \
	touch idba-partition-1

idba-partition-2: *.pe.fa 
	.idba-part-run.sh \
	touch idba-partition-2

idba-partition-3: kak.group*.pe.fq.gz
	.idba-part-finalize.sh \
	touch idba-partition-3

finalize-idba-partition:
	python ${MYSCRIPTS}/multi-rename.py assembly idba-partition-best.group*.fa > idba-partition-assembly.fa
#-------------------------------------------------------------------Megahit PARTITION------------------------------------------------------------------------
megahit-part-1: 
	.megahit-part.sh \
        touch megahit-part-1

megahit-part-2:
	.megahit-part-finalize.sh \
        touch megahit-part-2
#-------------------------------------------------------------------Analysis--------------------------------------------------------------------------------
megahit-quality-assembly500.fa:  idba-quality-assembly.fa  spades-quality-assembly.fa  megahit-quality-assembly.fa 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py  ${REFERENCE}  idba-quality-assembly.fa 500	
	python ${MYSCRIPTS}/filter_assembly_mincontig.py  ${REFERENCE}  spades-quality-assembly.fa 500 
	python ${MYSCRIPTS}/filter_assembly_mincontig.py  ${REFERENCE}  megahit-quality-assembly.fa 500 

mqc500.coords: megahit-quality-assembly500.fa 
	${NUCMER}/nucmer --coords -p  iqc500  ${REFERENCE}  idba-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p  sqc500  ${REFERENCE}  spades-quality-assembly500.fa
	${NUCMER}/nucmer --coords -p  mqc500  ${REFERENCE}  megahit-quality-assembly500.fa

assemblies.stats.QC.AMBIGUOUS.99: mqc500.coords
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.99 -a True 99 
	
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.99 -b True 99
	
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
         megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.99 -c True 99

assemblies.stats.QC.AMBIGUOUS.95: mqc500.coords
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.95 -a True 95 
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.BESTHIT.95 -b True 95
	python ${MYSCRIPTS}/analyze_assembly.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.NOOVERLAP.95 -c True 95

stats: megahit-quality-assembly500.fa 
	python ${MYSCRIPTS}/compute_stats.py idba-quality-assembly500.fa ${REFERENCE} > idba.stats 
	python ${MYSCRIPTS}/compute_stats.py spades-quality-assembly500.fa ${REFERENCE} > spades.stats
	python ${MYSCRIPTS}/compute_stats.py megahit-quality-assembly500.fa ${REFERENCE} > megahit.stats
	
megahit-quality-assembly3000.fa:  megahit-quality-assembly.fa
	$(foreach i,$(mc),python ${MYSCRIPTS}/filter_assembly_mincontig.py ${REFERENCE} idba-quality-assembly.fa $(i); ) 
	$(foreach i,$(mc),python ${MYSCRIPTS}/filter_assembly_mincontig.py ${REFERENCE} spades-quality-assembly.fa $(i); ) 
	$(foreach i,$(mc),python ${MYSCRIPTS}/filter_assembly_mincontig.py ${REFERENCE} megahit-quality-assembly.fa $(i); ) 

mqc3000.coords: megahit-quality-assembly3000.fa
	$(foreach i,$(mc), ${NUCMER}/nucmer --coords -p iqc$(i) ${REFERENCE}  idba-quality-assembly$(i).fa ; ) 
	$(foreach i,$(mc), ${NUCMER}/nucmer --coords -p sqc$(i) ${REFERENCE}  spades-quality-assembly$(i).fa ;) 
	$(foreach i,$(mc), ${NUCMER}/nucmer --coords -p mqc$(i) ${REFERENCE}  megahit-quality-assembly$(i).fa ; ) 
	
assemblies.stats.QC.AMBIGUOUS3000.99: mqc3000.coords 
	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
	megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.AMBIGUOUS$(i).99 -a True 99;)
	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
        megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.BESTHIT$(i).99 -b True 99 ;) 
	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
        megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.NOOVERLAP$(i).99 -c True 99 ;)

	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
	megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.AMBIGUOUS$(i).95 -a True 95;)
	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
	megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.BESTHIT$(i).95 -b True 95 ;) 
	$(foreach i, $(mc), python ${MYSCRIPTS}/analyze_assembly.py ${REFERENCE} idba-quality-assembly$(i).fa spades-quality-assembly$(i).fa \
	megahit-quality-assembly$(i).fa iqc$(i).coords  sqc$(i).coords  mqc$(i).coords QC.NOOVERLAP$(i).95 -c True 95 ;)


	
annotate-prokka: ${REFERENCE} megahit-quality-assembly500.fa
	prokka ${REFERENCE} --outdir mprokka --prefix testasm --metagenome

parse-prokka: mprokka/testasm.tbl
	${MYSCRIPTS}/parse-prokka.py mprokka/testasm.tbl prokka.out
	${MYSCRIPTS}/analyze_assembly_prokka.py  ${REFERENCE}  idba-quality-assembly500.fa  spades-quality-assembly500.fa \
	megahit-quality-assembly500.fa  iqc500.coords  sqc500.coords  mqc500.coords QC.AMBIGUOUS.99 -a True 99 prokka.out  	
 


#----------------------------------------------------------------Reads Coverage-----------------------------------------------------------------------------
qc-ref.sam: ${REFERENCE} SRR606249.pe.qc.fq.gz
	bwa index  ${REFERENCE} 
	bwa aln  ${REFERENCE}  SRR606249.pe.qc.fq.gz   >  qc-ref.pe.sai 
	bwa aln  ${REFERENCE}  SRR606249.se.qc.fq.gz   >  qc-ref.se.sai
	bwa samse ${REFERENCE}  qc-ref.pe.sai  SRR606249.pe.qc.fq.gz >  qc-ref.pe.sam 
	bwa samse  ${REFERENCE}  qc-ref.se.sai  SRR606249.se.qc.fq.gz >  qc-ref.se.sam
	samtools faidx  ${REFERENCE} 
	samtools import  ${REFERENCE}.fai  qc-ref.pe.sam  qc-ref.pe.bam 
	samtools import  ${REFERENCE}.fai  qc-ref.se.sam  qc-ref.se.bam 
	samtools merge  qc-ref.bam  qc-ref.pe.bam  qc-ref.se.bam 
	samtools view -h -o  qc-ref.sam  qc-ref.bam

unmapped-qc-to-ref: qc-ref.sam 
	samtools view -h -o  qc-ref.pe.sam  qc-ref.pe.bam
	samtools view -h -c -f 4  qc-ref.pe.bam >> unmapped-qc-to-ref 
	samtools view -h -o  qc-ref.se.sam  qc-ref.se.bam
	samtools view -h -c -f 4  qc-ref.se.bam >> unmapped-qc-to-ref 

SRR606249.qc.coverage: qc-ref.sam
	python ${MYSCRIPTS}/coverage-profile.py  ${REFERENCE}  qc-ref.sam  SRR606249.qc.coverage 

#-------------------------------------------------------------READ INCORPORATION---------------------------------------------
iq-unmapped.count:  SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  idba-quality-assembly500.fa 
	bwa aln  idba-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  iq.pe.sai 
	bwa aln  idba-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  iq.se.sai 
	bwa samse  idba-quality-assembly500.fa  iq.pe.sai  SRR606249.pe.qc.fq.gz >  iq.pe.sam 
	bwa samse  idba-quality-assembly500.fa  iq.se.sai  SRR606249.se.qc.fq.gz >  iq.se.sam
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools faidx  idba-quality-assembly500.fa 
	samtools import  idba-quality-assembly500.fa.fai  iq.pe.sam  iq.pe.bam 
	samtools import  idba-quality-assembly500.fa.fai  iq.se.sam  iq.se.bam 
	samtools view -c -f 4  iq.pe.bam >  iq-unmapped.count
	samtools view -c -f 4  iq.se.bam >>  iq-unmapped.count 

sq-unmapped.count: SRR606249.pe.qc.fq.gz  megahit-quality-assembly500.fa
	bwa index  spades-quality-assembly500.fa 
	bwa aln  spades-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  sq.pe.sai 
	bwa aln  spades-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  sq.se.sai 
	bwa samse  spades-quality-assembly500.fa  sq.pe.sai  SRR606249.pe.qc.fq.gz >  sq.pe.sam 
	bwa samse  spades-quality-assembly500.fa  sq.se.sai  SRR606249.se.qc.fq.gz >  sq.se.sam 
	samtools faidx  spades-quality-assembly500.fa 
	samtools import  spades-quality-assembly500.fa.fai  sq.pe.sam  sq.pe.bam 
	samtools import  spades-quality-assembly500.fa.fai  sq.se.sam  sq.se.bam 
	samtools view -c -f 4  sq.pe.bam >  sq-unmapped.count
	samtools view -c -f 4  sq.se.bam >>  sq-unmapped.count

mq-unmapped.count: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	bwa index  megahit-quality-assembly500.fa 
	bwa aln  megahit-quality-assembly500.fa  SRR606249.pe.qc.fq.gz   >  mq.pe.sai 	
	bwa aln  megahit-quality-assembly500.fa  SRR606249.se.qc.fq.gz   >  mq.se.sai 
	bwa samse  megahit-quality-assembly500.fa  mq.pe.sai  SRR606249.pe.qc.fq.gz >  mq.pe.sam 
	bwa samse  megahit-quality-assembly500.fa  mq.se.sai  SRR606249.se.qc.fq.gz >  mq.se.sam 
	samtools faidx  megahit-quality-assembly500.fa 
	samtools import  megahit-quality-assembly500.fa.fai  mq.pe.sam  mq.pe.bam 
	samtools import  megahit-quality-assembly500.fa.fai  mq.se.sam  mq.se.bam 
	samtools view -c -f 4  mq.pe.bam >  mq-unmapped.count
	samtools view -c -f 4  mq.se.bam >>  mq-unmapped.count

#--------------------------------------------------------Unaligned Coverage Profile--------------------------------------------------------------------
iqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99
	cat iqc500.QC.AMBIGUOUS.99.unaligned > iqc.AM99.fa   
	bwa index  iqc.AM99.fa
	bwa aln  iqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  iqc.AM99.pe.sai
	bwa aln  iqc.AM99.fa  SRR606249.se.qc.fq.gz  >  iqc.AM99.se.sai
	bwa samse  iqc.AM99.fa  iqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  iqc.AM99.pe.sam
	bwa samse  iqc.AM99.fa  iqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  iqc.AM99.se.sam
	samtools faidx  iqc.AM99.fa
	samtools import  iqc.AM99.fa.fai  iqc.AM99.pe.sam  iqc.AM99.pe.bam 
	samtools import  iqc.AM99.fa.fai  iqc.AM99.se.sam  iqc.AM99.se.bam
	samtools view -h -F 4  iqc.AM99.pe.bam >  iqc.AM99.mapped.pe.bam
	samtools view -h -F 4  iqc.AM99.se.bam >  iqc.AM99.mapped.se.bam
	samtools view -c -F 4  iqc.AM99.pe.bam >  iqc.AM99.aligned.reads
	samtools view -c -F 4  iqc.AM99.se.bam >>  iqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh  iqc.AM99.mapped.pe.bam >  iqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  iqc.AM99.mapped.se.bam >>  iqc.AM99.mappedreads.fa
	bwa index  ${REFERENCE}
	bwa aln ${REFERENCE}  iqc.AM99.mappedreads.fa  > iqc.AM99.sai
	bwa samse ${REFERENCE}  iqc.AM99.sai  iqc.AM99.mappedreads.fa >  iqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  iqc.AM99.sam  iqc.AM99.bam
	samtools view -c -F 4  iqc.AM99.bam >  iqc.AM99-mapped-reads

iqc.AM99.unmapped.sam:  iqc.AM99-mapped-reads
	samtools view -h -f 4  iqc.AM99.bam >  iqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  iqc.AM99.unmapped.bam >  iqc.AM99.unmappedreads.fa 
	bwa index iqc.AM99.fa
	bwa aln iqc.AM99.fa iqc.AM99.unmappedreads.fa  > iqc.AM99.unmapped.sai
	bwa samse  iqc.AM99.fa iqc.AM99.unmapped.sai  iqc.AM99.unmappedreads.fa >  iqc.AM99.unmapped.sam

iqc.unmapped.out: iqc.AM99.unmapped.sam
	python ${MYSCRIPTS}/coverage-profile.py iqc.AM99.fa iqc.AM99.unmapped.sam iqc.unmapped.out     



sqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99 
	cat sqc500.QC.AMBIGUOUS.99.unaligned  > sqc.AM99.fa         
	bwa index  sqc.AM99.fa
	bwa aln  sqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  sqc.AM99.pe.sai
	bwa aln  sqc.AM99.fa  SRR606249.se.qc.fq.gz  >  sqc.AM99.se.sai
	bwa samse  sqc.AM99.fa  sqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  sqc.AM99.pe.sam 
	bwa samse  sqc.AM99.fa  sqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  sqc.AM99.se.sam
	samtools faidx  sqc.AM99.fa
	samtools import  sqc.AM99.fa.fai  sqc.AM99.pe.sam  sqc.AM99.pe.bam 
	samtools import  sqc.AM99.fa.fai  sqc.AM99.se.sam  sqc.AM99.se.bam
	samtools view -h -F 4  sqc.AM99.pe.bam >  sqc.AM99.mapped.pe.bam
	samtools view -h -F 4  sqc.AM99.se.bam >  sqc.AM99.mapped.se.bam
	samtools view -c -F 4  sqc.AM99.pe.bam >  sqc.AM99.aligned.reads   
	samtools view -c -F 4  sqc.AM99.se.bam >>  sqc.AM99.aligned.reads 
	bash ${MYSCRIPTS}/get-mapped.sh  sqc.AM99.mapped.pe.bam >  sqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  sqc.AM99.mapped.se.bam >>  sqc.AM99.mappedreads.fa
	bwa index ${REFERENCE}
	bwa aln ${REFERENCE}  sqc.AM99.mappedreads.fa  > sqc.AM99.sai
	bwa samse ${REFERENCE}  sqc.AM99.sai  sqc.AM99.mappedreads.fa >  sqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  sqc.AM99.sam  sqc.AM99.bam
	samtools view -c -F 4  sqc.AM99.bam >  sqc.AM99-mapped-reads

sqc.AM99.unmapped.sam:   sqc.AM99-mapped-reads
	samtools view -h -f 4  sqc.AM99.bam >  sqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  sqc.AM99.unmapped.bam >  sqc.AM99.unmappedreads.fa 	
	bwa index sqc.AM99.fa
	bwa aln sqc.AM99.fa sqc.AM99.unmappedreads.fa  > sqc.AM99.unmapped.sai
	bwa samse sqc.AM99.fa sqc.AM99.unmapped.sai  sqc.AM99.unmappedreads.fa >  sqc.AM99.unmapped.sam

sqc.unmapped.out: sqc.AM99.unmapped.sam 
	python ${MYSCRIPTS}/coverage-profile.py sqc.AM99.fa sqc.AM99.unmapped.sam sqc.unmapped.out      


mqc.AM99-mapped-reads: ${REFERENCE} assemblies.stats.QC.AMBIGUOUS.99 
	cat mqc500.QC.AMBIGUOUS.99.unaligned  >mqc.AM99.fa 
	bwa index  mqc.AM99.fa
	bwa aln  mqc.AM99.fa  SRR606249.pe.qc.fq.gz  >  mqc.AM99.pe.sai
	bwa aln  mqc.AM99.fa  SRR606249.se.qc.fq.gz  >  mqc.AM99.se.sai
	bwa samse  mqc.AM99.fa  mqc.AM99.pe.sai  SRR606249.pe.qc.fq.gz  >  mqc.AM99.pe.sam
	bwa samse  mqc.AM99.fa  mqc.AM99.se.sai  SRR606249.se.qc.fq.gz  >  mqc.AM99.se.sam
	samtools faidx  mqc.AM99.fa
	samtools import  mqc.AM99.fa.fai  mqc.AM99.pe.sam  mqc.AM99.pe.bam
	samtools import  mqc.AM99.fa.fai  mqc.AM99.se.sam  mqc.AM99.se.bam
	samtools view -h -F 4  mqc.AM99.pe.bam >  mqc.AM99.mapped.pe.bam
	samtools view -h -F 4  mqc.AM99.se.bam >  mqc.AM99.mapped.se.bam
	samtools view -c -F 4  mqc.AM99.pe.bam >  mqc.AM99.aligned.reads
	samtools view -c -F 4  mqc.AM99.se.bam >>  mqc.AM99.aligned.reads
	bash ${MYSCRIPTS}/get-mapped.sh  mqc.AM99.mapped.pe.bam >  mqc.AM99.mappedreads.fa
	bash ${MYSCRIPTS}/get-mapped.sh  mqc.AM99.mapped.se.bam >>  mqc.AM99.mappedreads.fa
	bwa index ${REFERENCE}
	bwa aln ${REFERENCE}  mqc.AM99.mappedreads.fa  > mqc.AM99.sai
	bwa samse ${REFERENCE}  mqc.AM99.sai  mqc.AM99.mappedreads.fa >  mqc.AM99.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai  mqc.AM99.sam  mqc.AM99.bam
	samtools view -c -F 4  mqc.AM99.bam >  mqc.AM99-mapped-reads

mqc.AM99.unmapped.sam:   mqc.AM99-mapped-reads
	samtools view -h -f 4  mqc.AM99.bam >  mqc.AM99.unmapped.bam 
	bash ${MYSCRIPTS}/get-unmapped.sh  mqc.AM99.unmapped.bam >  mqc.AM99.unmappedreads.fa 
	bwa index mqc.AM99.fa
	bwa aln mqc.AM99.fa mqc.AM99.unmappedreads.fa  > mqc.AM99.unmapped.sai
	bwa samse mqc.AM99.fa mqc.AM99.unmapped.sai  mqc.AM99.unmappedreads.fa >  mqc.AM99.unmapped.sam

mqc.unmapped.out: mqc.AM99.unmapped.sam
	python ${MYSCRIPTS}/coverage-profile.py mqc.AM99.fa mqc.AM99.unmapped.sam mqc.unmapped.out   

#awk '$1 >=5 {sum += $2} END {print sum}' backup/all.unmapped.coverage
#awk '{sum += $2} END {print sum}' backup/all.unmapped.coverage 

#-----------------------------------------------------Common Uncovered Coverage-----------------------------------------------------------------------------
common-uncovered-coverage.out: qc-ref.sam  assemblies.stats.QC.AMBIGUOUS.99
	python ${MYSCRIPTS}/common-uncovered-coverage.py ${REFERENCE} qc-ref.sam QC.AMBIGUOUS.99.uncovered.bases common-uncovered-coverage.out 

#------------------------------------------------------------Kmer Abundance---------------------------------------------------------------------------------
mqc500.dist: SRR606249.pe.qc.fq.gz megahit-quality-assembly500.fa
	gunzip -c SRR606249.pe.qc.fq.gz > SRR606249.pe.qc.fastq 
	gunzip -c SRR606249.se.qc.fq.gz > SRR606249.se.qc.fastq  
	python ${SCRIPTS}/load-into-counting.py -x 2e9 -N 4 -k 20 qc.counts.kh SRR606249.pe.qc.fastq SRR606249.se.qc.fastq 
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh ${REFERENCE} SRR606249.qc.dist -s
	cat SRR606249.pe.qc.fastq SRR606249.se.qc.fastq  > SRR606249-qc.fastq 
	python ${SCRIPTS}/abundance-dist.py qc.counts.kh SRR606249-qc.fastq qc.dist -s
	cat idba-quality-assembly500.fa spades-quality-assembly500.fa megahit-quality-assembly500.fa > qc-assembly500.fa 
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh qc-assembly500.fa qc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh idba-quality-assembly500.fa  iqc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh spades-quality-assembly500.fa  sqc500.dist -s
	python ${SCRIPTS}/abundance-dist.py -s qc.counts.kh megahit-quality-assembly500.fa mqc500.dist -s

#-----------------------------------------------------------More into Common Uncovered Top Genomes-----------------------------------------------------------
Thermus_thermophilus_HB27: mircea.fa 
	python extract-common-uncovered-genomes.py  

shewanella.mapped-reads.fa: Thermus_thermophilus_HB27 
	mv Shewanella_baltica_OS223, shewanella
	bwa index  shewanella
	bwa aln  shewanella SRR606249.pe.qc.fq.gz   >   shewanella-ref.pe.sai
	bwa aln  shewanella SRR606249.se.qc.fq.gz   >   shewanella-ref.se.sai
	bwa samse  shewanella  shewanella-ref.pe.sai  SRR606249.pe.qc.fq.gz > shewanella-ref.pe.sam
	bwa samse  shewanella  shewanella-ref.se.sai  SRR606249.se.qc.fq.gz > shewanella-ref.se.sam
	samtools faidx  shewanella
	samtools import shewanella.fai shewanella-ref.pe.sam  shewanella-ref.pe.bam
	samtools import shewanella.fai shewanella-ref.se.sam  shewanella-ref.se.bam
	samtools view -h -F 4  shewanella-ref.pe.bam >  shewanella.mapped.pe.bam
	samtools view -h -F 4  shewanella-ref.se.bam >  shewanella.mapped.se.bam
	bash  ${MYSCRIPTS}/get-mapped.sh  shewanella.mapped.pe.bam > shewanella.mapped-reads.fa
	bash  ${MYSCRIPTS}/get-mapped.sh  shewanella.mapped.se.bam >> shewanella.mapped-reads.fa

fusobact.mapped-reads.fa: Thermus_thermophilus_HB27	
	mv Fusobacterium_nucleatum_subsp._nucleatum_ATCC_25586 fusobact
	bwa index fusobact
	bwa aln  fusobact SRR606249.pe.qc.fq.gz   >  fusobact-ref.pe.sai
	bwa aln  fusobact SRR606249.se.qc.fq.gz   >  fusobact-ref.se.sai
	bwa samse  fusobact  fusobact-ref.pe.sai  SRR606249.pe.qc.fq.gz > fusobact-ref.pe.sam
	bwa samse  fusobact  fusobact-ref.se.sai  SRR606249.se.qc.fq.gz > fusobact-ref.se.sam
	samtools faidx  fusobact
	samtools import fusobact.fai fusobact-ref.pe.sam  fusobact-ref.pe.bam
	samtools import fusobact.fai fusobact-ref.se.sam  fusobact-ref.se.bam
	samtools view -h -F 4  fusobact-ref.pe.bam > fusobact.mapped.pe.bam
	samtools view -h -F 4  fusobact-ref.se.bam > fusobact.mapped.se.bam
	bash  ${MYSCRIPTS}/get-mapped.sh  fusobact.mapped.pe.bam > fusobact.mapped-reads.fa
	bash  ${MYSCRIPTS}/get-mapped.sh  fusobact.mapped.se.bam >> fusobact.mapped-reads.fa
	

desulfov.mapped-reads.fa: Thermus_thermophilus_HB27  
	mv Desulfovibrio_vulgaris_DP4 desulfov
	bwa index desulfov
	bwa aln  desulfov SRR606249.pe.qc.fq.gz   >  desulfov-ref.pe.sai
	bwa aln  desulfov SRR606249.se.qc.fq.gz   >  desulfov-ref.se.sai
	bwa samse  desulfov  desulfov-ref.pe.sai  SRR606249.pe.qc.fq.gz > desulfov-ref.pe.sam
	bwa samse  desulfov  desulfov-ref.se.sai  SRR606249.se.qc.fq.gz > desulfov-ref.se.sam
	samtools faidx  desulfov
	samtools import desulfov.fai desulfov-ref.pe.sam  desulfov-ref.pe.bam
	samtools import desulfov.fai desulfov-ref.se.sam  desulfov-ref.se.bam
	samtools view -h -F 4  desulfov-ref.pe.bam > desulfov.mapped.pe.bam
	samtools view -h -F 4  desulfov-ref.se.bam > desulfov.mapped.se.bam
	bash  ${MYSCRIPTS}/get-mapped.sh  desulfov.mapped.pe.bam > desulfov.mapped-reads.fa
	bash  ${MYSCRIPTS}/get-mapped.sh  desulfov.mapped.se.bam >> desulfov.mapped-reads.fa	


enteroco.mapped-reads.fa: Thermus_thermophilus_HB27 
	mv Enterococcus_faecalis_V583 enteroco
	bwa index enteroco
	bwa aln  enteroco SRR606249.pe.qc.fq.gz   >  enteroco-ref.pe.sai
	bwa aln  enteroco SRR606249.se.qc.fq.gz   >  enteroco-ref.se.sai
	bwa samse  enteroco  enteroco-ref.pe.sai  SRR606249.pe.qc.fq.gz > enteroco-ref.pe.sam
	bwa samse  enteroco  enteroco-ref.se.sai  SRR606249.se.qc.fq.gz > enteroco-ref.se.sam
	samtools faidx  enteroco
	samtools import enteroco.fai enteroco-ref.pe.sam  enteroco-ref.pe.bam
	samtools import enteroco.fai enteroco-ref.se.sam  enteroco-ref.se.bam
	samtools view -h -F 4  enteroco-ref.pe.bam > enteroco.mapped.pe.bam
	samtools view -h -F 4  enteroco-ref.se.bam > enteroco.mapped.se.bam
	bash  ${MYSCRIPTS}/get-mapped.sh  enteroco.mapped.pe.bam > enteroco.mapped-reads.fa
	bash  ${MYSCRIPTS}/get-mapped.sh  enteroco.mapped.se.bam >> enteroco.mapped-reads.fa

thermus.mapped-reads.fa: Thermus_thermophilus_HB27 
	mv Thermus_thermophilus_HB27 thermus
	
	bwa index thermus
	bwa aln  thermus SRR606249.pe.qc.fq.gz   >  thermus-ref.pe.sai
	bwa aln  thermus SRR606249.se.qc.fq.gz   >  thermus-ref.se.sai
	bwa samse  thermus  thermus-ref.pe.sai  SRR606249.pe.qc.fq.gz > thermus-ref.pe.sam
	bwa samse  thermus  thermus-ref.se.sai  SRR606249.se.qc.fq.gz > thermus-ref.se.sam
	samtools faidx  thermus
	samtools import thermus.fai thermus-ref.pe.sam  thermus-ref.pe.bam
	samtools import thermus.fai thermus-ref.se.sam  thermus-ref.se.bam
	samtools view -h -F 4  thermus-ref.pe.bam > thermus.mapped.pe.bam
	samtools view -h -F 4  thermus-ref.se.bam > thermus.mapped.se.bam
	bash  ${MYSCRIPTS}/get-mapped.sh  thermus.mapped.pe.bam > thermus.mapped-reads.fa
	bash  ${MYSCRIPTS}/get-mapped.sh  thermus.mapped.se.bam >> thermus.mapped-reads.fa

uncovered-genomes-coverage: shewanella.mapped-reads.fa fusobact.mapped-reads.fa \
	desulfov.mapped-reads.fa enteroco.mapped-reads.fa  thermus.mapped-reads.fa 


	samtools merge  shewanella-qc.bam  shewanella-ref.pe.bam shewanella-ref.se.bam
	samtools view -h -o  shewanella-qc.sam  shewanella-qc.bam 
	python ${MYSCRIPTS}/coverage-profile.py  shewanella  shewanella-qc.sam shewanella.coverage 

	samtools merge  fusobact-qc.bam  fusobact-ref.pe.bam fusobact-ref.se.bam
	samtools view -h -o  fusobact-qc.sam  fusobact-qc.bam 
	python ${MYSCRIPTS}/coverage-profile.py  fusobact  fusobact-qc.sam fusobact.coverage

	samtools merge desulfov-qc.bam  desulfov-ref.pe.bam desulfov-ref.se.bam
	samtools view -h -o desulfov-qc.sam  desulfov-qc.bam 
	python ${MYSCRIPTS}/coverage-profile.py  desulfov  desulfov-qc.sam desulfov.coverage

	 
	samtools merge enteroco-qc.bam  enteroco-ref.pe.bam enteroco-ref.se.bam
	samtools view -h -o enteroco-qc.sam  enteroco-qc.bam
	python ${MYSCRIPTS}/coverage-profile.py enteroco  enteroco-qc.sam enteroco.coverage
	 

	samtools merge thermus-qc.bam  thermus-ref.pe.bam thermus-ref.se.bam
	samtools view -h -o  thermus-qc.sam  thermus-qc.bam 
	python ${MYSCRIPTS}/coverage-profile.py thermus thermus-qc.sam thermus.coverage 

#-------------------------------------------------Unaligning unaligned Contigs to the new Reference ---------------------------------------------------------
newref-stats: assemblies.stats.QC.AMBIGUOUS.99
 
	${NUCMER}/nucmer --coords -p  unaligned-iqc ${newref}  iqc500.QC.AMBIGUOUS.99.unaligned
	${NUCMER}/nucmer --coords -p  unaligned-sqc ${newref}  sqc500.QC.AMBIGUOUS.99.unaligned 
	${NUCMER}/nucmer --coords -p  unaligned-mqc ${newref}  mqc500.QC.AMBIGUOUS.99.unaligned

	python ${MYSCRIPTS}/analyze_assembly.py  ${newref}  iqc500.QC.AMBIGUOUS.99.unaligned sqc500.QC.AMBIGUOUS.99.unaligned \
	mqc500.QC.AMBIGUOUS.99.unaligned unaligned-iqc.coords unaligned-sqc.coords unaligned-mqc.coords UNALIGNED-AMBIGOUS.99 -a True 99

#------------------------------------------------------------Finding Chimeric Reads-------------------------------------------------------------------------- 
#This is an ignored part 
chimeric:  ${REFERENCE} SRR606249.pe.qc.fq.gz
	bwa index ${REFERENCE} 
	bwa mem -M -t 16 ${REFERENCE} SRR606249.se.qc.fq.gz  > SRR606249-se.sam
	bwa mem -M -t 16 ${REFERENCE} SRR606249.pe.qc.fq.gz  > SRR606249-pe.sam
	samtools faidx ${REFERENCE}
	samtools import ${REFERENCE}.fai SRR606249-pe.sam SRR606249-pe.bam
	samtools import ${REFERENCE}.fai SRR606249-se.sam SRR606249-se.bam
	samtools view SRR606249-pe.bam | grep 'SA:'  > SRR606249-pe.chimeric
	samtools view SRR606249-se.bam | grep 'SA:'  > SRR606249-se.chimeric
	bash ${MYSCRIPTS}/count-chimeric.sh 

#---------------------------------------------------------------Cleaning ------------------------------------------------------------------------------------	
