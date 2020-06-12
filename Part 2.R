#Part 2

#1. downloading the file, gunzip and decompress, and makeblast() function
download.file("ftp://ftp.ensemblgenomes.org/pub/bacteria/release-42/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/cds/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz",
              destfile = "E.coli.fa")
unlink("E.coli.fa") #unlink the file
R.utils::gunzip("E.coli.fa.gz") #decompress the file
makeblastdb("E.coli.fa.gz", dbtype = "nucl", "-parse_seqids") #to blast the data sequence

#2. Downloading sample fasta sequences from github
download.file("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part2_files/sample.fa", 
              destfile = "sample.fa")
#reading file 
sample <- read.fatsa("sample.fa")
myseq <- sample[18]
myseq
 
#3. blast search 
myblastn_tab
res <- myblastn_tab(myseq = sample[18], db = "E.coli.fa")

