install.packages("ggpubr")
install.packages("lubridate")

library(openxlsx)
library(lubridate)
library(ggpubr)
library(reshape2)

performancedata=read.csv("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/MicrosurgeryPerformance.csv")

# Normality test

#remove the not required columns
performancedata_new= performancedata[-c(16,17,18),]

#Cutting time 1
cutting1timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.1))
logcutting1timeseconds=sqrt(cutting1timeseconds)

shapiro.test(cutting1timeseconds)
qqnorm(cutting1timeseconds)
ggqqplot(cutting1timeseconds)

shapiro.test(logcutting1timeseconds)
qqnorm(logcutting1timeseconds)
ggqqplot(logcutting1timeseconds)

#Cutting time 2
cutting2timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.2))
logcutting2timeseconds=sqrt(cutting2timeseconds)

shapiro.test(cutting2timeseconds)
qqnorm(cutting2timeseconds)
ggqqplot(cutting2timeseconds)

shapiro.test(logcutting2timeseconds)
qqnorm(logcutting2timeseconds)
ggqqplot(logcutting2timeseconds)

#Cutting time 3
cutting3timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.3))
logcutting3timeseconds=sqrt(cutting3timeseconds)

shapiro.test(cutting3timeseconds)
qqnorm(cutting3timeseconds)
ggqqplot(cutting3timeseconds)

shapiro.test(logcutting3timeseconds)
qqnorm(logcutting3timeseconds)
ggqqplot(logcutting3timeseconds)

#Cutting time 4
cutting4timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.4))
logcutting4timeseconds=sqrt(cutting4timeseconds)

shapiro.test(cutting4timeseconds)
qqnorm(cutting4timeseconds)
ggqqplot(cutting4timeseconds)

shapiro.test(logcutting4timeseconds)
qqnorm(logcutting4timeseconds)
ggqqplot(logcutting4timeseconds)

#Cutting time 5
cutting5timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Cutting.Time.5))
logcutting5timeseconds=sqrt(cutting5timeseconds)

shapiro.test(cutting5timeseconds)
qqnorm(cutting5timeseconds)
ggqqplot(cutting5timeseconds)

shapiro.test(logcutting5timeseconds)
qqnorm(logcutting5timeseconds)
ggqqplot(logcutting5timeseconds)

#Sutur 1
sutur1timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Suturing.Time.1))
logsutur1timeseconds=sqrt(sutur1timeseconds)

shapiro.test(sutur1timeseconds)
qqnorm(sutur1timeseconds)
ggqqplot(sutur1timeseconds)

shapiro.test(logsutur1timeseconds)
qqnorm(logsutur1timeseconds)
ggqqplot(logsutur1timeseconds)

#Sutur 2
sutur2timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Suturing.Time.2))
logsutur2timeseconds=sqrt(sutur2timeseconds)

shapiro.test(sutur2timeseconds)
qqnorm(sutur2timeseconds)
ggqqplot(sutur2timeseconds)

shapiro.test(logsutur2timeseconds)
qqnorm(logsutur2timeseconds)
ggqqplot(logsutur2timeseconds)

#Sutur 3
sutur3timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Suturing.Time.3))
logsutur3timeseconds=sqrt(sutur3timeseconds)

shapiro.test(sutur3timeseconds)
qqnorm(sutur3timeseconds)
ggqqplot(sutur3timeseconds)

shapiro.test(logsutur3timeseconds)
qqnorm(logsutur3timeseconds)
ggqqplot(logsutur3timeseconds)

#Sutur 4
sutur4timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Suturing.Time.4))
logsutur4timeseconds=sqrt(sutur4timeseconds)

shapiro.test(sutur4timeseconds)
qqnorm(sutur4timeseconds)
ggqqplot(sutur4timeseconds)

shapiro.test(logsutur4timeseconds)
qqnorm(logsutur4timeseconds)
ggqqplot(logsutur4timeseconds)

#Sutur 5
sutur5timeseconds = lubridate::period_to_seconds(ms(performancedata_new$Suturing.Time.5))
logsutur5timeseconds=sqrt(sutur5timeseconds,10)

shapiro.test(sutur5timeseconds)
qqnorm(sutur5timeseconds)
ggqqplot(sutur5timeseconds)

shapiro.test(logsutur5timeseconds)
qqnorm(logsutur5timeseconds)
ggqqplot(logsutur5timeseconds)


# T test Paired
cut1score= as.integer(as.character(performancedata_new$Score.Cut1))
cut2score= as.integer(as.character(performancedata_new$Score.Cut2))
t.test(cut1score,cut2score, paired=TRUE)

sut1score=as.integer(as.character(performancedata_new$Score.Sut1))
sut2score=as.integer(as.character(performancedata_new$Score.Sut2))
t.test(sut1score,sut2score, paired=TRUE)

#Linear regression
#Anova
#Dummy avriable

#profile plot


