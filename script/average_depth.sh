samtools depth  *bamfile*  |  awk '{sum+=$3} END { print "Average = ",sum/NR}'