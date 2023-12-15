mkdir -p CDS  # Create the 'CDS' directory if it doesn't exist
all_fasta="virii.fasta"
limit=2000
count=0

# Concatenate up to 150 FASTA files into a single file
# for i in $(cat id); do
#   echo ${i}
#   efetch -db nuccore -id ${i} -format fasta >> ${all_fasta}
#   ((count++))

#   if [ $count -eq $limit ]; then
#     break
#   fi
# done

# # Run prodigal on the combined FASTA file
prodigal -i ${all_fasta} -o CDS/all_gene.coords.gbk -a CDS/all_protein.translations.fa

# diamond makedb  --in diamond_database/database.fa -d diamond_database/database.dmnd

# # self database
# # diamond makedb --in CDS/all_protein.translations.fa -d diamond_database/self_database.dmnd

# # diamond blastp --sensitive -q CDS/all_protein.translations.fa -o diamond_database/results.tab
# diamond blastp --sensitive -d diamond_database/database.dmnd -q CDS/all_protein.translations.fa -o diamond_database/results.tsv



