
Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk-9.0.1/")

library(openxlsx)
library(doBy)

#Use CSV, xlsx not having some issue.
perform=read.xlsx("D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/MicrosurgeryPerformance.xlsx")
perform_temp=perform[c(1:15),]

# q1.a
hist(perform_temp$Age,ylim = c(0,8),breaks=15,ylab = "Age Frequency",xlab="Age",main = "Age Histogram")


# Q1.b
m=sum(perform_temp$Sex==1)
f=sum(perform_temp$Sex==2)
newData=c(m,f)
maxheight=max(newData) + 1
barplot(newData,names.arg = c("Male","Female") ,ylim = c(0,maxheight),col=c("red","green"),legend=c("Male","Female"),ylab = "Gender Frequency",xlab = "Gender Type",main = "Gender - Distribution")

#Q2 
tia<-read.table(file="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/tai_scores.txt")
hist(tia$V2 ,ylim = c(0,4),breaks=40,ylab = "Frequency",xlab="TIA Scores",axes=F,main = "TIA Histogram",col="blue")
axis(2)
axis(side=1, at=seq(20,50, 1), labels=seq(20,50, 1))