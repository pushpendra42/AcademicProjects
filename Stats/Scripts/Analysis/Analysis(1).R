library(openxlsx)
library(lubridate)
library(ggpubr)
library(reshape2)
install.packages("ggpubr")
install.packages("lubridate")

performancedata=read.csv("C:/Users/hneel/Desktop/SMR-P/PUSH/MicrosurgeryPerformance.csv")
#performancedataxlsx=read.xlsx("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformance.xlsx",skipEmptyRows = TRUE)

# Normality test


performancedata_new= performancedata[-c(16,17,18),]

cuttingtimeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.1))
logcuttingtimeseconds=log(cuttingtimeseconds)

shapiro.test(cuttingtimeseconds)
qqnorm(cuttingtimeseconds)
ggqqplot(cuttingtimeseconds)

shapiro.test(logcuttingtimeseconds)
qqnorm(logcuttingtimeseconds)
ggqqplot(logcuttingtimeseconds)


suturtimeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.2))
logsuturtimeseconds=log(suturtimeseconds)

shapiro.test(suturtimeseconds)
qqnorm(suturtimeseconds)
ggqqplot(suturtimeseconds)

shapiro.test(logsuturtimeseconds)
qqnorm(logsuturtimeseconds)
ggqqplot(logsuturtimeseconds)

# T test Paired

cut1score= as.integer(as.character(performancedata_new$Score.Cut1))
cut2score= as.integer(as.character(performancedata_new$Score.Cut2))
t.test(cut1score,cut2score, paired=TRUE)

sut1score=as.integer(as.character(performancedata_new$Score.Sut1))
sut2score=as.integer(as.character(performancedata_new$Score.Sut2))
t.test(sut1score,sut2score, paired=TRUE)

#Linear regression

#Anova
#performancetemp=read.xlsx("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformancetemp.xlsx",skipEmptyRows = TRUE)

performancetemp=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformance.csv")
#sess1cut1=
#sess2cut1=
#sess3cut1=
#sess4cut1=
#sess5cut1=


# Dummy avriable

# Non parametric test

# Work on the performance file



file.exists("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session5/Subject01_Baseline5.csv")
file.exists("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session4/Subject01_Baseline4.csv")


performanceorigin=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformancetemp.csv")
performanceoriginnew=performanceorigin[-c(16,17,18),]
performanceoriginnew$Scores=performanceoriginnew$

melteddata=melt(performanceoriginnew,id=c("Score.Cut1","Score.Cut2"), measure.vars = c("Score.Cut1","Score.Cut2"),value.name = "A")
melteddata=melt(performanceoriginnew,id=c("ID"))

