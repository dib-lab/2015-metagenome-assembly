#PBS -A ged 
#PBS -l nodes=1:ppn=1
#PBS -l walltime=160:00:00
#PBS -l mem=250GB
#PBS -N megahit-partition

cd /mnt/home/mahmoud4/megahit/
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0000.pe.fq.gz -o partition/meghit-partition-pe.0
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0001.pe.fq.gz -o partition/meghit-partition-pe.1
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0002.pe.fq.gz -o partition/meghit-partition-pe.2
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0003.pe.fq.gz -o partition/meghit-partition-pe.3
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0004.pe.fq.gz -o partition/meghit-partition-pe.4
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0005.pe.fq.gz -o partition/meghit-partition-pe.5
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0006.pe.fq.gz -o partition/meghit-partition-pe.6
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0007.pe.fq.gz -o partition/meghit-partition-pe.7
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0008.pe.fq.gz -o partition/meghit-partition-pe.8
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0009.pe.fq.gz -o partition/meghit-partition-pe.9
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0010.pe.fq.gz -o partition/meghit-partition-pe.10
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0011.pe.fq.gz -o partition/meghit-partition-pe.11
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0012.pe.fq.gz -o partition/meghit-partition-pe.12
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0013.pe.fq.gz -o partition/meghit-partition-pe.13
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0014.pe.fq.gz -o partition/meghit-partition-pe.14
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0015.pe.fq.gz -o partition/meghit-partition-pe.15
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0016.pe.fq.gz -o partition/meghit-partition-pe.16
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0017.pe.fq.gz -o partition/meghit-partition-pe.17
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0018.pe.fq.gz -o partition/meghit-partition-pe.18
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0019.pe.fq.gz -o partition/meghit-partition-pe.19
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0020.pe.fq.gz -o partition/meghit-partition-pe.20
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0021.pe.fq.gz -o partition/meghit-partition-pe.21
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0022.pe.fq.gz -o partition/meghit-partition-pe.22
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0023.pe.fq.gz -o partition/meghit-partition-pe.23
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0024.pe.fq.gz -o partition/meghit-partition-pe.24
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0025.pe.fq.gz -o partition/meghit-partition-pe.25
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0026.pe.fq.gz -o partition/meghit-partition-pe.26
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0027.pe.fq.gz -o partition/meghit-partition-pe.27
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0028.pe.fq.gz -o partition/meghit-partition-pe.28
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0000.se.fq.gz -o partition/meghit-partition-se.0
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0001.se.fq.gz -o partition/meghit-partition-se.1
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0002.se.fq.gz -o partition/meghit-partition-se.2
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0003.se.fq.gz -o partition/meghit-partition-se.3
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0004.se.fq.gz -o partition/meghit-partition-se.4
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0005.se.fq.gz -o partition/meghit-partition-se.5
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0006.se.fq.gz -o partition/meghit-partition-se.6
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0007.se.fq.gz -o partition/meghit-partition-se.7
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0008.se.fq.gz -o partition/meghit-partition-se.8
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0009.se.fq.gz -o partition/meghit-partition-se.9
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0010.se.fq.gz -o partition/meghit-partition-se.10
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0011.se.fq.gz -o partition/meghit-partition-se.11
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0012.se.fq.gz -o partition/meghit-partition-se.12
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0013.se.fq.gz -o partition/meghit-partition-se.13
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0014.se.fq.gz -o partition/meghit-partition-se.14
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0015.se.fq.gz -o partition/meghit-partition-se.15
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0016.se.fq.gz -o partition/meghit-partition-se.16
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0017.se.fq.gz -o partition/meghit-partition-se.17
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0018.se.fq.gz -o partition/meghit-partition-se.18
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0019.se.fq.gz -o partition/meghit-partition-se.19
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0020.se.fq.gz -o partition/meghit-partition-se.20
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0021.se.fq.gz -o partition/meghit-partition-se.21
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0022.se.fq.gz -o partition/meghit-partition-se.22
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0023.se.fq.gz -o partition/meghit-partition-se.23
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0024.se.fq.gz -o partition/meghit-partition-se.24
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0025.se.fq.gz -o partition/meghit-partition-se.25
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0026.se.fq.gz -o partition/meghit-partition-se.26
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0027.se.fq.gz -o partition/meghit-partition-se.27
/usr/bin/time  -a  -o megpart.txt python  megahit -l 101 -m 1e+10 --cpu-only -r partition/kak.group0028.se.fq.gz -o partition/meghit-partition-se.28
