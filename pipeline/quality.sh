#PBS -A ged
#PBS -l nodes=1:ppn=4
#PBS -l walltime=160:00:00
#PBS -l mem=100GB
#PBS -N PodarQC

cd /mnt/research/ged/sherine/2015-metagenome-assembly/pipeline/ 

module swap GNU GNU/4.8.2
module load khmer

 
module load Trimmomatic
make quality







