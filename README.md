# myrepos
Bioinformatics and Molecular Biotechnology Techniques

Read-me file for Assessment 3















By: Durga Bhvani (Student id:21942477)
Bhavesh Batra (Student Id: 220205366)
Vamakshi Sharma (Student id: 220033173)

Part 1. 
1.	Read in the file, making the gene accession numbers the row names. Show a table of values for the first six genes.
•	The process was done by giving the following commands:
a.	lets consider 'x' as the whole data and read the file
b.	x <- read.table("gene_expression.tsv")
str(x)
c.	the gene numbers are considered as factors which have to converted to integers

d.	# making the gene accession numbers the rownames and converting the strings of gene numbers
e.	x <- read.table("gene_expression.tsv", header = TRUE, stringsAsFactors = FALSE, row.names = 1)
f.	str(x) #the factors are now integers
g.	head(x) #to check the first few lines whether the code works

h.	#table of first six genes
i.	x[1:6,]

2.	Make a new column which is the mean of the other columns. Show a table of values for the first six genes. 
	The process was done by giving the following commands:
a.	MEAN <- rowMeans(x) #gives the mean of the two columns and name it as MEAN
b.	Gene_Expression <- cbind(x, MEAN) #add the MEAN column to data and the name the whole as Gene_Expression
c.	head(Gene_Expression) #to check the few lines whether the code works


3.	List the 10 genes with the highest mean expression
	Input: Gene_Expression[order(-Gene_Expression$MEAN),][1:10, ]
	Output: 
	              		  MEAN
1.	ENSG00000115414 	259102.0
2.	ENSG00000210082 	154602.0
3.	ENSG00000075624 	125372.5
4.	ENSG00000198886 	95769.5
5.	ENSG00000137801	 84852.0
6.	ENSG00000198804 	82303.0
7.	ENSG00000198786 	79079.5
8.	ENSG00000196924 	77319.0
9.	ENSG00000198712 	76608.0
10.	ENSG00000108821 	70234.5


4.	Determine the number of genes with a mean <10.
	Input: subset(Gene_Expression, MEAN<10)
	Output: 333 genes



5.	Make a histogram plot of the mean values in png format and paste it into your report.
	Input: 	png(filename = "myplots.png")
hist(MEAN)
dev.off()
 


6.	Import this csv file into an R object. What are the column names?
	Input: 
Growth_data <- read.csv("growth_data.csv", header = TRUE, stringsAsFactors = FALSE) #reading the file and converting the strings
colnames(Growth_data)

7.	Calculate the mean and standard deviation of tree circumference at the start and end of the study at both sites.
	Input: subset(Growth_data, Site == "northeast") #subsetting the northeast site

mean(Growth_data$Circumf_2004_cm) 
mean(Growth_data$Circumf_2019_cm) 
sd(Growth_data$Circumf_2004_cm) 
sd(Growth_data$Circumf_2019_cm)

subset(Growth_data, Site == "southwest") 
mean(Growth_data$Circumf_2004_cm)
mean(Growth_data$Circumf_2019_cm)

sd(Growth_data$Circumf_2004_cm) 
sd(Growth_data$Circumf_2019_cm) 

8.	Make a box plot of tree circumference at the start and end of the study at both sites.
	Input:
NorthEast <- subset(Growth_data, Site == "northeast") 
head(NorthEast) 
SouthWest <- subset(Growth_data, Site == "southwest") 
head(SouthWest) 
boxplot(NorthEast$Circumf_2004_cm, NorthEast$Circumf_2019_cm, SouthWest$Circumf_2004_cm, SouthWest$Circumf_2019_cm,
names = c("NE2004", "NE2019", "SW2004", "SW2019"), ylab ="Tree Circumference (cm)", main = "Growth of Tree Circumference at two Plantation sites")

9.	Calculate the mean growth over the past 10 years at each site.
	Input: 
NorthEast$Growth <- NorthEast$Circumf_2019_cm - NorthEast$Circumf_2009_cm 
head(NorthEast) 
SouthWest$Growth <- SouthWest$Circumf_2019_cm - SouthWest$Circumf_2009_cm
head(SouthWest)
	Output: 
       Site	 TreeID 	Circumf_2004_cm 	Circumf_2009_cm	Circumf_2014_cm   Circumf_2019_cm
51 southwest   A001             5.3            	13.5           	34.6         88.7
52 southwest   A002             5.2            	10.1            	19.8     	   38.8
53 southwest   A004             6.2           	15.9            	40.6         103.9
54 southwest   A006             5.1            	11.5            	25.9         58.3
55 southwest   A009             3.6             9.1             	23.4         59.8
56 southwest   A010             6.6            	14.9            	33.6         75.5


10.	Use the t.test and wilcox.test functions to estimate the p-value that the 10 year growth is different at the two sites.
	Input: 
t.test(SouthWest$Growth, NorthEast$Growth) 
wilcox.test(SouthWest$Growth, NorthEast$Growth) 


Part 2:

1. Download the whole set of E. coli gene DNA sequences and use gunzip to decompress. Use the
makeblast() function to create a blast database. How many sequences are present in the E.coli set?
 download.file("ftp://ftp.ensemblgenomes.org/pub/bacteria/release-42/fasta/bacteria_0_collection/escherichia_coli_str_k_12_substr_mg1655/cds/Escherichia_coli_str_k_12_substr_mg1655.ASM584v2.cds.all.fa.gz",
              destfile = "E.coli.fa")
unlink("E.coli.fa")
R.utils::gunzip("E.coli.fa.gz")
makeblastdb ("E.coli.fa.gz", dbtype = "nucl", "-parse_seqids")

2. Download the sample fasta sequences and read them in as above. For your allocated sequence,
determine the length (in bp) and the proportion of GC bases.
 download.file("https://raw.githubusercontent.com/markziemann/SLE712_files/master/bioinfo_asst3_part2_files/sample.fa", 
              destfile = "sample.fa")
#reading file 
sample <- read.fatsa("sample.fa")
myseq <- sample[18]
myseq

3. You will be provided with R functions to create BLAST databases and perform blast searches. Use
blast to identify what E. coli gene your sequence matches best. Show a table of the top 3 hits including
percent identity, E-value and bit scores.
 myblastn_tab
res <- myblastn_tab(myseq = sample[18], db = "E.coli.fa")

