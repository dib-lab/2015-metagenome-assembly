#PBS -A ged
#PBS -l nodes=1:ppn=1
#PBS -l walltime=24:00:00
#PBS -l mem=100GB
#PBS -N analysis-4

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline 

 

module load bwa
module load samtools

make Thermus_thermophilus_HB27

make shewanella.mapped-reads.fa 

make fusobact.mapped-reads.fa

make desulfov.mapped-reads.fa

make enteroco.mapped-reads.fa

make thermus.mapped-reads.fa

make uncovered-genomes-coverage

 
