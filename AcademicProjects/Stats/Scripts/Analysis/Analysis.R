library(openxlsx)
library(lubridate)
library(ggpubr)
library(reshape2)
library(pander)

install.packages("ggpubr")
install.packages("lubridate")
install.packages("pander")


performancedata=read.csv("C:/Users/hneel/Desktop/SMR-P/PUSH/MicrosurgeryPerformance.csv")
#performancedataxlsx=read.xlsx("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformance.xlsx",skipEmptyRows = TRUE)

# Normality test


performancedata_new= performancedata[-c(16,17,18),]

cuttingtimeseconds1 = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.1))
cuttingtimeseconds2 = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.2))
cuttingtimeseconds3 = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.3))
cuttingtimeseconds4 = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.4))
cuttingtimeseconds5 = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.5))

logcuttingtimeseconds=log(cuttingtimeseconds)
shapiro.test(cuttingtimeseconds)

qqnorm(cuttingtimeseconds1)

#Quantile plots

qq1 = ggqqplot(cuttingtimeseconds1, title = "Session 1")
qq2 = ggqqplot(cuttingtimeseconds2,title = "Session 2")
qq3 = ggqqplot(cuttingtimeseconds3,title = "Session 3")
qq4 = ggqqplot(cuttingtimeseconds4,title = "Session 4")
qq5 = ggqqplot(cuttingtimeseconds5,title = "Session 5")

#QQplot cannot add sub axis lable
qqtotal = ggarrange(qq1,qq2,qq3,qq4,qq5 + rremove("x.text"), ncol = 5, nrow = 1, label.x = c("Session 1", "Session 2", "Session 3", "Session 4","Session 5"), common.legend = TRUE)
annotate_figure(qqtotal,top = text_grob("Quantile Plot of Cutting Time in Sessions"))


shapiro.test(logcuttingtimeseconds)
qqnorm(logcuttingtimeseconds)
ggqqplot(logcuttingtimeseconds)

#QQ plot another way
wdata = data.frame(
  Sessqq = factor(rep(c("Session 1", "Session 2","Session 3", "Session 4", "Session 5"), each=15)),
  timeqq = c(cuttingtimeseconds1,cuttingtimeseconds2,cuttingtimeseconds3,cuttingtimeseconds4,cuttingtimeseconds5))
ggqqplot(wdata, x = "timeqq",
         color = "Sessqq", palette = c("red", "blue", "green", "black", "purple"))



suturtimeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.2))
logsuturtimeseconds=log(suturtimeseconds)

shapiro.test(suturtimeseconds)
qqnorm(suturtimeseconds)
ggqqplot(suturtimeseconds)

shapiro.test(logsuturtimeseconds)
qqnorm(logsuturtimeseconds)
ggqqplot(logsuturtimeseconds)

# T test Paired

cut1score= as.integer(as.character(performancedata_new$Score.Cut1.4))
cut2score= as.integer(as.character(performancedata_new$Score.Cut2.4))
t.test(cut1score,cut2score, paired=TRUE)



sut1score=as.integer(as.character(performancedata_new$Score.Sut1.4))
sut2score=as.integer(as.character(performancedata_new$Score.Sut2.4))
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

performanceorigin=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformance.csv")


subject1session1baseline=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session1/Subject01_Baseline1.csv")
performanceorigin[1]$Baselinesession1<-mean(subject1session1baseline$Perspiration)
subject1session2baseline=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session2/Subject01_Baseline2.csv")
subject1baselinemean$session2=mean(subject1session2baseline$Perspiration)
subject1session3baseline=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session3/Subject01_Baseline3.csv")
subject1baselinemean$session3=mean(subject1session3baseline$Perspiration)
#subject1session4baseline=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session4/Subject01_Baseline4.csv")
#subject1baselinemean$session4=mean(subject1session4baseline$Perspiration)
subject1session5baseline=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session5/Subject01_Baseline5.csv")
subject1baselinemean$session5=mean(subject1session5baseline$Perspiration)

file.exists("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session5/Subject01_Baseline5.csv")
file.exists("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject01/subject01/session4/Subject01_Baseline4.csv")


performanceorigin=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformancetemp.csv")
performanceoriginnew=performanceorigin[-c(16,17,18),]

melt(d[,c("Type","I.alt","idx06","idx07","idx08")], id=c("Type","I.alt"))

melteddata=melt(performanceoriginnew,id=c("Score.Cut1","Score.Cut2"))





