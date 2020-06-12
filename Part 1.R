#Part1. the file "gene_expression.tsv" contains RNA-seq count data for two samples of interest.
#"gene_expression.tsv"(file to be downloaded)

#the file is downloaded as follows
download.file("https://raw.githubusercontent.com/dbboddu/SLE712_files/master/bioinfo_asst3_part1_files/gene_expression.tsv",
              destfile = "gene_expression.tsv")

#1.lets consider 'x' as the whole data and read the file
x <- read.table("gene_expression.tsv")
str(x)
#the gene numbers are considered as factors which have to converted to integers

# making the gene accession numbers the rownames and converting the strings of gene numbers
x <- read.table("gene_expression.tsv", header = TRUE, stringsAsFactors = FALSE, row.names = 1)
str(x) #the factors are now integers
head(x) #to check the first few lines whether the code works

#table of first six genes
x[1:6,]


#2. making a new column which is mean of other columns
MEAN <- rowMeans(x) #gives the mean of the two columns and name it as MEAN
Gene_Expression <- cbind(x, MEAN) #add the MEAN column to data and the name the whole as Gene_Expression
head(Gene_Expression) #to check the few lines whether the code works

#3. listing the 10 genes with highest mean expression
Gene_Expression[order(-Gene_Expression$MEAN),][1:10, ] #sorting the mean in descending order and lsiting the first 10 values

#4. Determining the genes with mean < 10
subset(Gene_Expression, MEAN<10) #subset the values to find the mean values whihc are < 10

#5. making the histogram of mean values in png format
png(filename = "myplots.png")
hist(MEAN)
dev.off()




#Part.2 The file “growth_data.csv” contains measurements for tree circumference growing at two sites, control site andtreatment site which were planted 20 years ago
#"growth_data.csv" (file to be downloaded)

#6. importing the csv file into R and listing column names
download.file("https://raw.githubusercontent.com/dbboddu/SLE712_files/master/bioinfo_asst3_part1_files/growth_data.csv",
              destfile = "growth_data.csv") #downloading the file 

Growth_data <- read.csv("growth_data.csv", header = TRUE, stringsAsFactors = FALSE) #reading the file and converting the strings
colnames(Growth_data) #lsiting the column names

#7. mean and standard deviation of tree circumference at the start and end of the study atboth sites
subset(Growth_data, Site == "northeast") #subsetting the northeast site

mean(Growth_data$Circumf_2004_cm) #mean of tree circumference at the start
mean(Growth_data$Circumf_2019_cm) #mean of the tree circumference at the end 

sd(Growth_data$Circumf_2004_cm) #standard deviation of the tree circumference at the start
sd(Growth_data$Circumf_2019_cm) #standard deviation of the tree circumference at the end


subset(Growth_data, Site == "southwest") #subsetting the southwest side

mean(Growth_data$Circumf_2004_cm) #mean of the tree circumference at the start
mean(Growth_data$Circumf_2019_cm) #mean of the tree circumference at the end

sd(Growth_data$Circumf_2004_cm) #standard deviation of the tree circumference at the start
sd(Growth_data$Circumf_2019_cm) #standard deviation of the tree circumference at the end

#8. making a boxplot of the tree circumference at the start and end of the study at both sides
NorthEast <- subset(Growth_data, Site == "northeast") #subsetting the northeast side 
head(NorthEast) #checking the first few lines whether the code works 

SouthWest <- subset(Growth_data, Site == "southwest") #subsetting the southwest side
head(SouthWest) #checking the first few lines whether the code works 

boxplot(NorthEast$Circumf_2004_cm, NorthEast$Circumf_2019_cm, SouthWest$Circumf_2004_cm, SouthWest$Circumf_2019_cm,
        names = c("NE2004", "NE2019", "SW2004", "SW2019"), ylab ="Tree Circumference (cm)", main = "Growth of Tree Circumference at two Plantation sites")
#boxplot at the start and end of both the sites

#9. Mean growth over past 10 years at both sites
NorthEast$Growth <- NorthEast$Circumf_2019_cm - NorthEast$Circumf_2009_cm #growth over past 10 years
head(NorthEast) #checking the first few lines whether the code works

SouthWest$Growth <- SouthWest$Circumf_2019_cm - SouthWest$Circumf_2009_cm #growth over past 10 years
head(SouthWest)#checking the first few lines whether the code works

#10. t.test and wilcox.test to estimate the p-value that the 10 year growth is different atthe two sites
t.test(SouthWest$Growth, NorthEast$Growth) #t.test to estimate p-value of 10 year growth

wilcox.test(SouthWest$Growth, NorthEast$Growth) #wilcox.test to estimate p-value of 10 year growth

