
library(grid)
library("xlsx")
library("ggplot2")
require(lattice)
library(gridExtra)
library(gtable)
library(cowplot)
#install.packages("cowplot")
Sys.setenv(JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home")

JAVA_HOME
Sys.getenv('JAVA_HOME')
Sys.getenv('LD_LIBRARY_PATH')


#Perinasal Perspiration (Stress) Signal Data: 
#$For each session of each subject draw the stress signals, 
#using black for baseline, green for cutting, and red for suturing. 
#Generally speaking, the baseline signal should be at a lower level than the other two. 
#In total, you will draw five figures for each subject or whatever 
#the number of his/her sessions is.
library("ggplot2")

spLegend=ggplot(c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "right") + ylim(0,.015) + xlim(0,1200)

legend <- get_legend(spLegend)
#-------------------------------------------Loading Data Stress Signal Subject1 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session1/Subject01_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session1/Subject01_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session1/Subject01_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
      count=count+1
      temp = temp + s[p]
      p=p+1
    }
    else{
      if(count == 0)
      {
        
      }
      else
      {
        avg=(temp)/count
      }
      baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
      n=n+1
      temp=0
      count=0
      i = i-1
    }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing
  
#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s1c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s1p1=ggplot(s1c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s1c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s1c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s1c1$Baseline, color = "Baseline"))+
  theme_bw()+
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
  
  

  #sp1 + ylim(0,.015) + xlim(0,1200)

  
  

#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject1 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session2/Subject01_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session2/Subject01_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session2/Subject01_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s1c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s1p2=ggplot(s1c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s1c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s1c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s1c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject1 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session3/Subject01_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session3/Subject01_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session3/Subject01_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s1c3=c
#c3$Subject=1
#c3$Session=3
#-----------------------------------------plotting line signals------------------------------------------------
s1p3=ggplot(s1c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s1c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s1c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s1c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

write.csv(c3,"/Users/bharatverma/Downloads/COSC_Statistical/Project/plot.csv")


#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject1 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session4/Subject01_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session4/Subject01_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session4/Subject01_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s1c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s1p4=ggplot(s1c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s1c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s1c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s1c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject1 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session5/Subject01_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session5/Subject01_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject01/session5/Subject01_Suturing5.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s1c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s1p5=ggplot(s1c5, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s1c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s1c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s1c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
  



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

title = textGrob("Perinasal Perspiration[°C^2]: Subject01", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p <-grid.arrange( s1p1, s1p2, s1p3, s1p4, s1p5, ncol=5, left = leftPP, top = title, bottom = bottomS,right= legend)







#************************************************************************************************************************






#-------------------------------------------Loading Data Stress Signal Subject2 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session1/Subject02_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session1/Subject02_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session1/Subject02_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s2c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s2p1=ggplot(s2c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s2c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s2c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s2c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())




#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject2 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session2/Subject02_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session2/Subject02_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session2/Subject02_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s2c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s2p2=ggplot(s2c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s2c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s2c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s2c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject2 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session3/Subject02_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session3/Subject02_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session3/Subject02_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s2c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s2p3=ggplot(s2c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s2c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s2c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s2c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject2 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session4/Subject02_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session4/Subject02_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session4/Subject02_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s2c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s2p4=ggplot(s2c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s2c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s2c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s2c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject2 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session5/Subject02_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session5/Subject02_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject02/session5/Subject02_Suturing5.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s2c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s2p5=ggplot(s2c5, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s2c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s2c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s2c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(legend.title=element_blank())+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
title = textGrob("Perinasal Perspiration[°C^2]: Subject02", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
p = grid.arrange( s1p1, s1p2, s1p3, s1p4, s1p5,s2p1, s2p2, s2p3, s2p4, s2p5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#************************************************************************************************************************






#-------------------------------------------Loading Data Stress Signal Subject3 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session1/Subject03_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session1/Subject03_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session1/Subject03_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s3c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s3p1=ggplot(s3c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s3c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s3c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s3c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject3 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session2/Subject03_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session2/Subject03_Cutting2.csv")
#subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session2/Subject03_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)
#--------Merging Cutting and Baseline-------------
diff<-setdiff(row.names(b),row.names(a))
diff

for (p in diff) {
  a[p,]=NA
}

b$Baseline=a$Perspiration
b
#--------Merging Suturing and Cutting Table-----------

#c
#--------Merging Sutring and Baseline Table-----------

#c
#tail(c, 20)
s3c2=b
#-----------------------------------------plotting line signals------------------------------------------------
s3p2=ggplot(s3c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s3c2$Perspiration, color = "Cutting")) + 
  geom_line(aes(y = s3c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject3 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session3/Subject03_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session3/Subject03_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session3/Subject03_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s3c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s3p3=ggplot(s3c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s3c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s3c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s3c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject3 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session4/Subject03_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session4/Subject03_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session4/Subject03_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s3c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s3p4=ggplot(s3c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s3c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s3c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s3c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject3 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session5/Subject03_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session5/Subject03_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject03/session5/Subject03_Suturing5.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s3c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s3p5=ggplot(s3c5, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s3c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s3c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s3c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

title = textGrob("Perinasal Perspiration[°C^2]: Subject03", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#********************************************************************************************
#********************************************************************************************
#********************************************************************************************


#-------------------------------------------Loading Data Stress Signal Subject4 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session1/Subject04_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session1/Subject04_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session1/Subject04_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s4c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s4p1=ggplot(s4c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s4c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s4c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s4c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject4 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session2/Subject04_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session2/Subject04_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session2/Subject04_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s4c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s4p2=ggplot(s4c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s4c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s4c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s4c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject4 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session3/Subject04_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session3/Subject04_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session3/Subject04_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s4c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s4p3=ggplot(s4c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s4c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s4c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s4c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject4 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session4/Subject04_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session4/Subject04_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session4/Subject04_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s4c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s4p4=ggplot(s4c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s4c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s4c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s4c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject4 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session5/Subject04_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session5/Subject04_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject04/session5/Subject04_Suturing5.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s4c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s4p5=ggplot(s4c5, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s4c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s4c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s4c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------


title = textGrob("Perinasal Perspiration[°C^2]: Subject04", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)
#********************************************************************************************
#********************************************************************************************
#********************************************************************************************


#-------------------------------------------Loading Data Stress Signal Subject5 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session1/Subject05_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session1/Subject05_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session1/Subject05_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s5c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s5p1=ggplot(s5c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s5c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s5c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s5c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject5 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session2/Subject05_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session2/Subject05_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session2/Subject05_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s5c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s5p2=ggplot(s5c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s5c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s5c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s5c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject5 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session3/Subject05_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session3/Subject05_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject05/session3/Subject05_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s5c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s5p3=ggplot(s5c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s5c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s5c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s5c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
cBlanck = c3
cBlanck$Perspiration=0
cBlanck$Cutting=0
cBlanck$Baseline=0
sBlanck=ggplot(cBlanck, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = cBlanck$Cutting, color = "Cutting")) + 
  geom_line(aes(y = cBlanck$Perspiration, color = "Suturing"))+
  geom_line(aes(y = cBlanck$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#-----------------------------------------------------------------------

title = textGrob("Perinasal Perspiration[°C^2]: Subject05", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, nrow=3, left = leftPP, top = title, bottom = bottomS,right= legend)

#********************************************************************************************
#********************************************************************************************
#********************************************************************************************


#-------------------------------------------Loading Data Stress Signal Subject6 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject06/session1/Subject06_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject06/session1/Subject06_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject06/session1/Subject06_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s6c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s6p1=ggplot(s6c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s6c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s6c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s6c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject6")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
  
  
  

title = textGrob("Perinasal Perspiration[°C^2]: Subject06", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1,nrow=1, left = leftPP, top = title, bottom = bottomS,right= legend)


#********************************************************************************************
#********************************************************************************************
#********************************************************************************************


#-------------------------------------------Loading Data Stress Signal Subject7 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session1/Subject07_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session1/Subject07_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session1/Subject07_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s7c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s7p1=ggplot(s7c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s7c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s7c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s7c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject7")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject7 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session2/Subject07_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session2/Subject07_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session2/Subject07_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s7c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s7p2=ggplot(s7c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s7c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s7c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s7c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject7 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session3/Subject07_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session3/Subject07_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session3/Subject07_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s7c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s7p3=ggplot(s7c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s7c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s7c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s7c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject7 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session4/Subject07_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session4/Subject07_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session4/Subject07_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s7c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s7p4=ggplot(s7c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s7c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s7c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s7c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject7 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session5/Subject07_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session5/Subject07_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject07/session5/Subject07_Suturing5.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s7c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s7p5=ggplot(s7c5, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s7c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s7c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s7c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
title = textGrob("Perinasal Perspiration[°C^2]: Subject07", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)
#********************************************************************************************
#********************************************************************************************
#********************************************************************************************


#-------------------------------------------Loading Data Stress Signal Subject8 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session1/Subject08_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session1/Subject08_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session1/Subject08_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s8c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s8p1=ggplot(s8c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s8c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s8c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s8c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject8")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject8 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session2/Subject08_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session2/Subject08_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session2/Subject08_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s8c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s8p2=ggplot(s8c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s8c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s8c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s8c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject8 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session3/Subject08_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session3/Subject08_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session3/Subject08_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s8c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s8p3=ggplot(s8c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s8c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s8c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s8c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject8 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session4/Subject08_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session4/Subject08_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session4/Subject08_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s8c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s8p4=ggplot(s8c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s8c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s8c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s8c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject8 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session5/Subject08_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session5/Subject08_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject08/session5/Subject08_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s8c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s8p5=ggplot(s8c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s8c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s8c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s8c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
  




#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------




title = textGrob("Perinasal Perspiration[°C^2]: Subject08", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#-------------------------------------------Loading Data Stress Signal Subject09 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session1/Subject09_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session1/Subject09_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session1/Subject09_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s9c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s9p1=ggplot(s9c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s9c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s9c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s9c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject9")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject09 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session2/Subject09_Baseline2.csv")
#subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session2/Subject09_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject09/session2/Subject09_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s9c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s9p2=ggplot(s9c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s9c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s9c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s9c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())

--------------------------------------------------------------------------------------
  
title = textGrob("Perinasal Perspiration[°C^2]: Subject09", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2,nrow=2, left = leftPP, top = title, bottom = bottomS,right= legend)


#-------------------------------------------Loading Data Stress Signal Subject10 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session1/Subject10_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session1/Subject10_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session1/Subject10_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s10c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s10p1=ggplot(s10c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s10c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s10c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s10c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Subject10")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)




#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject10 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session2/Subject10_Baseline2.csv")
#subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session2/Subject10_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session2/Subject10_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s10c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s10p2=ggplot(s10c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  #geom_line(aes(y = c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s10c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s10c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject10 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session3/Subject10_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session3/Subject10_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session3/Subject10_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s10c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s10p3=ggplot(s10c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s10c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s10c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s10c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject10 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session4/Subject10_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session4/Subject10_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session4/Subject10_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s10c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s10p4=ggplot(s10c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s10c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s10c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s10c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject10 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session5/baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session5/cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject10/session5/suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s10c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s10p5=ggplot(s10c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s10c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s10c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s10c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------


title = textGrob("Perinasal Perspiration[°C^2]: Subject10", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#-------------------------------------------Loading Data Stress Signal Subject11 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session1/Subject11_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session1/Subject11_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session1/Subject1_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s11c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s11p1=ggplot(s11c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s11c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s11c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s11c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject11 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session2/Subject11_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session2/Subject11_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session2/Subject11_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s11c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s11p2=ggplot(s11c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s11c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s11c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s11c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject11 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session3/Subject11_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session3/Subject11_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session3/Subject11_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s11c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s11p3=ggplot(s11c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s11c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s11c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s11c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject11 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session4/Subject11_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session4/Subject11_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session4/Subject11_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s11c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s11p4=ggplot(s11c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s11c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s11c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s11c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject11 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session5/Subject11_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session5/Subject11_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject11/session5/Subject11_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s11c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s11p5=ggplot(s11c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s11c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s11c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s11c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)




#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------




#title = textGrob("Perinasal Perspiration[°C^2]: Subject11", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
#leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
#rightSession = textGrob("Session", vjust = 1)
#bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#-------------------------------------------Loading Data Stress Signal Subject12 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session1/Subject12_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session1/Subject12_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session1/Subject12_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s12c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s12p1=ggplot(s12c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s12c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s12c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s12c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject12 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session2/Subject12_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session2/Subject12_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session2/Subject12_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s12c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s12p2=ggplot(s12c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s12c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s12c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s12c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject12 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session3/Subject12_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session3/Subject12_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session3/Subject12_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(b),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

b$Baseline=a$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
a=suturing
#b
diff<-setdiff(row.names(b),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

b$Suturing=a$Perspiration
#c
#tail(c, 20)
s12c3=b
#s12c3 = rename(s12c3, Cutting = Perspiration )
#-----------------------------------------plotting line signals------------------------------------------------
s12p3=ggplot(s12c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s12c3$Perspiration, color = "Cutting")) + 
  geom_line(aes(y = s12c3$Suturing, color = "Suturing"))+
  geom_line(aes(y = s12c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject12 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session4/Subject12_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session4/Subject12_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session4/Subject12_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s12c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s12p4=ggplot(s12c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s12c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s12c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s12c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject12 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session5/Subject12_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session5/Subject12_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject12/session5/Subject12_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s12c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s12p5=ggplot(s12c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s12c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s12c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s12c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)




#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------







#-------------------------------------------Loading Data Stress Signal Subject13 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session1/Subject13_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session1/Subject13_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session1/Subject13_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s13c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s13p1=ggplot(s13c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s13c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s13c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s13c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject13 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session2/Subject13_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session2/Subject13_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session2/Subject13_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s13c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s13p2=ggplot(s13c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s13c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s13c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s13c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject13 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session3/Subject13_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session3/Subject13_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session3/Subject13_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)

#--------Merging Cutting and Baseline Table-----------
diff<-setdiff(row.names(b),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

b$Baseline=a$Perspiration
#c
#--------Merging Cutting and Suturing Table-----------
a=suturing
#b
diff<-setdiff(row.names(b),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

b$Suturing=a$Perspiration
#c
#tail(c, 20)
s13c3=b
head(s13c3)
#-----------------------------------------plotting line signals------------------------------------------------
s13p3=ggplot(s13c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s13c3$Perspiration, color = "Cutting")) + 
  geom_line(aes(y = s13c3$Suturing, color = "Suturing"))+
  geom_line(aes(y = s13c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject13 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session4/Subject13_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session4/Subject13_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session4/Subject13_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s13c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s13p4=ggplot(s13c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s13c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s13c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s13c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject13 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session5/Subject13_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session5/Subject13_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/subject13/session5/Subject13_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s13c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s13p5=ggplot(s13c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s13c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s13c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s13c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)


#-------------------------------------------Loading Data Stress Signal Subject19 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session1/Subject19_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session1/Subject19_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session1/Subject19_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s19c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s19p1=ggplot(s19c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s19c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s19c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s19c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject19 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session2/Subject19_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session2/Subject19_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session2/Subject19_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s19c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s19p2=ggplot(s19c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s19c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s19c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s19c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject19 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session3/Subject19_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session3/Subject19_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session3/Subject19_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s19c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s19p3=ggplot(s19c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s19c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s19c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s19c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject19 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session4/Subject19_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session4/Subject19_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session4/Subject19_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s19c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s19p4=ggplot(s19c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s19c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s19c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s19c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject19 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session5/Subject19_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session5/Subject19_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject19/session5/Subject19_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s19c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s19p5=ggplot(s19c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s19c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s19c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s19c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)


#p = grid.arrange( s19p1, s19p2, s19p3, s19p4, s19p5, ncol=5, left = leftPP, top = title, bottom = bottomS,right= legend)


#-------------------------------------------Loading Data Stress Signal Subject20 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject20/session1/Subject20_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject20/session1/Subject20_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject20/session1/Subject20_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s20c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s20p1=ggplot(s20c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s20c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s20c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s20c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)

#-------------------------------------------Loading Data Stress Signal Subject21 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session1/Subject21_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session1/Subject21_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session1/Subject21_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s21c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s21c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s21c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s21c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s21c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject21 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session2/Subject21_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session2/Subject21_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session2/Subject21_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s21c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p2=ggplot(s21c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s21c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s21c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s21c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject21 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session3/Subject21_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session3/Subject21_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session3/Subject21_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s21c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p3=ggplot(s21c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s21c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s21c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s21c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject21 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session4/Subject21_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session4/Subject21_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session4/Subject21_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s21c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p4=ggplot(s21c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s21c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s21c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s21c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject21 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session5/Subject21_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session5/Subject21_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject21/session5/Subject21_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s21c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p5=ggplot(s21c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s21c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s21c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s21c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)


#-------------------------------------------Loading Data Stress Signal Subject22 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session1/Subject22_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session1/Subject22_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session1/Subject22_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s22c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s22c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s22c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s22c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s22c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject22 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session2/Subject22_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session2/Subject22_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session2/Subject22_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s22c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p2=ggplot(s22c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s22c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s22c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s22c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject22 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session3/Subject22_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session3/Subject22_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session3/Subject22_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s22c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p3=ggplot(s22c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s22c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s22c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s22c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject22 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session4/Subject22_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session4/Subject22_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session4/Subject22_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s22c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p4=ggplot(s22c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s22c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s22c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s22c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject22 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session5/Subject22_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session5/Subject22_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject22/session5/Subject22_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s22c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p5=ggplot(s22c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s22c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s22c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s22c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)

#-------------------------------------------Loading Data Stress Signal Subject24 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session1/Subject24_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session1/Subject24_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session1/Subject24_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s24c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s24c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s24c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s24c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s24c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject24 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session2/Subject24_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session2/Subject24_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session2/Subject24_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s24c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p2=ggplot(s24c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s24c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s24c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s24c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject24 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session3/Subject24_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session3/Subject24_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session3/Subject24_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s24c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p3=ggplot(s24c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s24c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s24c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s24c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject24 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session4/Subject24_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session4/Subject24_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session4/Subject24_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s24c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p4=ggplot(s24c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s24c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s24c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s24c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject24 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session5/Subject24_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session5/Subject24_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject24/session5/Subject24_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s24c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s24p5=ggplot(s24c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s24c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s24c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s24c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)

#-------------------------------------------Loading Data Stress Signal Subject26 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session1/Subject26_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session1/Subject26_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session1/Subject26_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s26c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s26c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s26c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s26c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s26c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject26 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session2/Subject26_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session2/Subject26_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session2/Subject26_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s26c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p2=ggplot(s26c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s26c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s26c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s26c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject26 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session3/Subject26_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session3/Subject26_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session3/Subject26_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s26c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p3=ggplot(s26c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s26c3$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s26c3$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s26c3$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------

#-------------------------------------------Loading Data Stress Signal Subject26 Session4 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session4/Subject26_Baseline4.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session4/Subject26_Cutting4.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session4/Subject26_Suturing4.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s26c4=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p4=ggplot(s26c4, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s26c4$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s26c4$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s26c4$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session4")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject26 Session5 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session5/Subject26_Baseline5.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session5/Subject26_Cutting5.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject26/session5/Subject26_Suturing5.csv")
#class(subject_suturing)
#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s26c5=c
#-----------------------------------------plotting line signals------------------------------------------------
s26p5=ggplot(s26c5, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = s26c5$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s26c5$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s26c5$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session5")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)

#-------------------------------------------Loading Data Stress Signal Subject25 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session1/Subject25_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session1/Subject25_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session1/Subject25_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s25c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s25c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s25c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s25c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s25c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject25 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session2/Subject25_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session2/Subject25_Cutting2.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject25/session2/Subject25_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s25c2=c
#-----------------------------------------plotting line signals------------------------------------------------
s25p2=ggplot(s25c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s25c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s25c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s25c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#-------------------------------------------Loading Data Stress Signal Subject23 Session1 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session1/Subject23_Baseline1.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session1/Subject23_Cutting1.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session1/Subject23_Suturing1.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Cutting Table-----------
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Baseline=b$Perspiration
#c
#tail(c, 20)
s23c1=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p1=ggplot(s23c1, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s23c1$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s23c1$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s23c1$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session1")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp1 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject23 Session2 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session2/Subject23_Baseline2.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session2/Subject23_Cutting2.csv")
#subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session2/Subject23_Suturing2.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting


#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
#c=suturing
nrow(a)
nrow(b)
#nrow(c)


#--------Merging Baseline and Cutting Table-----------
diff<-setdiff(row.names(a),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

a$Cutting=b$Perspiration
#c
#--------Merging Sutring and Baseline Table-----------
#c
#tail(c, 20)
library(plyr) 
a$Suturing = NA


s23c2=a
#-----------------------------------------plotting line signals------------------------------------------------
s21p2=ggplot(s23c2, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s23c2$Cutting, color = "Cutting")) + 
  geom_line(aes(y = s23c2$Perspiration, color = "Suturing"))+
  geom_line(aes(y = s23c2$Baseline, color = "Baseline"))+
  theme_bw() +
  ggtitle("Session2")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)



#sp2 + ylim(0,.015) + xlim(0,1200)




#------------------------------------------------------------------
#-------------------------------------------Loading Data Stress Signal Subject23 Session3 -------------------------------------------------
subject_baseline<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session3/Subject23_Baseline3.csv")
subject_cutting<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session3/Subject23_Cutting3.csv")
subject_suturing<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/osfstorage-archive/Methodist microsurgery with output/Subject23/session3/Subject23_Suturing3.csv")

#tail(subject1_baseline)
#tophead = head(subject_baseline)



#baseline[nrow(baseline) + 1, ] <- c(" 1, 50)

#data cleaning for baseline
baseline <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)

count=0
temp=0
n=1
p=1
s = c(subject_baseline$Perspiration)
rowlength = nrow(subject_baseline)
i = 1
while(i < rowlength)
{
  t = subject_baseline$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    baseline<-rbind(baseline,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}

#baseline

#data cleaning for cutting---------------------------------------

cutting <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_cutting$Perspiration)
rowlength = nrow(subject_cutting)
i = 1
while(i < rowlength)
{
  t = subject_cutting$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    cutting<-rbind(cutting,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#cutting

#data cleaning for suturing
suturing <- data.frame( "Time" = integer(), "Perspiration" = double(), stringsAsFactors=FALSE)
count=0
temp=0
n=1
p=1
s = c(subject_suturing$Perspiration)
rowlength = nrow(subject_suturing)
i = 1
while(i < rowlength)
{
  t = subject_suturing$Time[i]
  if(t < n){
    count=count+1
    temp = temp + s[p]
    p=p+1
  }
  else{
    if(count == 0)
    {
      
    }
    else
    {
      avg=(temp)/count
    }
    suturing<-rbind(suturing,data.frame("Time" = n,"Perspiration" = avg))
    n=n+1
    temp=0
    count=0
    i = i-1
  }
  i = i+1
}
#suturing

#-------------------------------------------merging table-------------------------------------------------- 
a=baseline
b=cutting
c=suturing
nrow(a)
nrow(b)
nrow(c)


#--------Merging Suturing and Baseline Table-----------
diff<-setdiff(row.names(c),row.names(a))
#diff

for (p in diff) {
  a[p,]=NA
}

c$Baseline=a$Perspiration
#c
#--------Merging Sutring and Cutting Table-----------
#b=baseline
#b
diff<-setdiff(row.names(c),row.names(b))
#diff

for (p in diff) {
  b[p,]=NA
}

c$Cutting=b$Perspiration
#c
#tail(c, 20)

#c
#tail(c, 20)
s23c3=c
#-----------------------------------------plotting line signals------------------------------------------------
s21p3=ggplot(s23c3, aes(x=Time)) + 
  xlab("")+
  ylab("")+
  geom_line(aes(y = s23c3$Cutting, color = "Cutting"), size=.2) + 
  geom_line(aes(y = s23c3$Perspiration, color = "Suturing"),size=.2)+
  geom_line(aes(y = s23c3$Baseline, color = "Baseline"),size=.2)+
  theme_bw() +
  ggtitle("Session3")+theme(plot.title = element_text(hjust = 0))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "none") + ylim(0,.015) + xlim(0,1200)

s21p3


#sp3 + ylim(0,.015) + xlim(0,1200)
#---------------------------------------------------------




title = textGrob("Perinasal Perspiration[°C^2]", vjust = 1, gp = gpar(fontface = "bold", cex = 1))
leftPP = textGrob("PP[°C^2]", rot = 90, vjust = 1)
rightSession = textGrob("Session", vjust = 1)
bottomS = textGrob("Time(s)", vjust = 0)
#p = grid.arrange( sp1, sp2, sp3, sp4, sp5, nrow=5, left = leftPP, top = title, bottom = bottomS,right= legend)



p = grid.arrange( s1p1, s1p2, s1p3, s1p4, s1p5,s2p1, s2p2, s2p3, s2p4, s2p5, ncol=5,s3p1, s3p2, s3p3, s3p4, s3p5,s4p1, s4p2, s4p3, s4p4, s4p5,s5p1, s5p2, s5p3,sBlanck,sBlanck,s6p1,sBlanck,sBlanck,sBlanck,sBlanck,s7p1, s7p2, s7p3, s7p4, s7p5,s8p1, s8p2, s8p3, s8p4, s8p5,s9p1, s9p2, sBlanck, sBlanck, sBlanck,s10p1, s10p2, s10p3, s10p4, s10p5,left = leftPP, top = title, bottom = bottomS,right= legend)

s1c1$subject = "Subject 1"
s1c2$subject = "Subject 1"
s1c3$subject = "Subject 1"
s1c4$subject = "Subject 1"
s1c5$subject = "Subject 1"


s1c1$session = "Session 1"
s1c2$session = "Session 2"
s1c3$session = "Session 3"
s1c4$session = "Session 4"
s1c5$session = "Session 5"

s2c1$subject = "Subject 2"
s2c2$subject = "Subject 2"
s2c3$subject = "Subject 2"
s2c4$subject = "Subject 2"
s2c5$subject = "Subject 2"


s2c1$session = "Session 1"
s2c2$session = "Session 2"
s2c3$session = "Session 3"
s2c4$session = "Session 4"
s2c5$session = "Session 5"

s3c2$Suturing = NA
s3c2 <- rename(s3c2,c('Perspiration'='Cutting'))
s3c1$subject = "Subject 3"
s3c2$subject = "Subject 3"
s3c3$subject = "Subject 3"
s3c4$subject = "Subject 3"
s3c5$subject = "Subject 3"


s3c1$session = "Session 1"
s3c2$session = "Session 2"
s3c3$session = "Session 3"
s3c4$session = "Session 4"
s3c5$session = "Session 5"

s4c1$subject = "Subject 4"
s4c2$subject = "Subject 4"
s4c3$subject = "Subject 4"
s4c4$subject = "Subject 4"
s4c5$subject = "Subject 4"


s4c1$session = "Session 1"
s4c2$session = "Session 2"
s4c3$session = "Session 3"
s4c4$session = "Session 4"
s4c5$session = "Session 5"


s5c1$subject = "Subject 5"
s5c2$subject = "Subject 5"
s5c3$subject = "Subject 5"

s5c1$session = "Session 1"
s5c2$session = "Session 2"
s5c3$session = "Session 3"

s6c1$subject = "Subject 6"

s6c1$session = "Session 1"

s7c1$subject = "Subject 7"
s7c2$subject = "Subject 7"
s7c3$subject = "Subject 7"
s7c4$subject = "Subject 7"
s7c5$subject = "Subject 7"


s7c1$session = "Session 1"
s7c2$session = "Session 2"
s7c3$session = "Session 3"
s7c4$session = "Session 4"
s7c5$session = "Session 5"

s8c1$subject = "Subject 8"
s8c2$subject = "Subject 8"
s8c3$subject = "Subject 8"
s8c4$subject = "Subject 8"
s8c5$subject = "Subject 8"


s8c1$session = "Session 1"
s8c2$session = "Session 2"
s8c3$session = "Session 3"
s8c4$session = "Session 4"
s8c5$session = "Session 5"


s9c1$subject = "Subject 9"
s9c2$subject = "Subject 9"

s9c1$session = "Session 1"
s9c2$session = "Session 2"

s10c1$subject = "Subject 10"
s10c2$subject = "Subject 10"
s10c3$subject = "Subject 10"
s10c4$subject = "Subject 10"
s10c5$subject = "Subject 10"


s10c1$session = "Session 1"
s10c2$session = "Session 2"
s10c3$session = "Session 3"
s10c4$session = "Session 4"
s10c5$session = "Session 5"

s11c1$subject = "Subject 11"
s11c2$subject = "Subject 11"
s11c3$subject = "Subject 11"
s11c4$subject = "Subject 11"
s11c5$subject = "Subject 11"


s11c1$session = "Session 1"
s11c2$session = "Session 2"
s11c3$session = "Session 3"
s11c4$session = "Session 4"
s11c5$session = "Session 5"

s12c1$subject = "Subject 12"
s12c2$subject = "Subject 12"
s12c3$subject = "Subject 12"
s12c4$subject = "Subject 12"
s12c5$subject = "Subject 12"


s12c1$session = "Session 1"
s12c2$session = "Session 2"
s12c3$session = "Session 3"
s12c4$session = "Session 4"
s12c5$session = "Session 5"

s13c1$subject = "Subject 13"
s13c2$subject = "Subject 13"
s13c3$subject = "Subject 13"
s13c4$subject = "Subject 13"
s13c5$subject = "Subject 13"


s13c1$session = "Session 1"
s13c2$session = "Session 2"
s13c3$session = "Session 3"
s13c4$session = "Session 4"
s13c5$session = "Session 5"

s19c1$subject = "Subject 19"
s19c2$subject = "Subject 19"
s19c3$subject = "Subject 19"
s19c4$subject = "Subject 19"
s19c5$subject = "Subject 19"


s19c1$session = "Session 1"
s19c2$session = "Session 2"
s19c3$session = "Session 3"
s19c4$session = "Session 4"
s19c5$session = "Session 5"

s20c1$subject = "Subject 20"

s20c1$session = "Session 1"

s21c1$subject = "Subject 21"
s21c2$subject = "Subject 21"
s21c3$subject = "Subject 21"
s21c4$subject = "Subject 21"
s21c5$subject = "Subject 21"


s21c1$session = "Session 1"
s21c2$session = "Session 2"
s21c3$session = "Session 3"
s21c4$session = "Session 4"
s21c5$session = "Session 5"

s22c1$subject = "Subject 22"
s22c2$subject = "Subject 22"
s22c3$subject = "Subject 22"
s22c4$subject = "Subject 22"
s22c5$subject = "Subject 22"


s22c1$session = "Session 1"
s22c2$session = "Session 2"
s22c3$session = "Session 3"
s22c4$session = "Session 4"
s22c5$session = "Session 5"

s23c1$subject = "Subject 23"
s23c2$subject = "Subject 23"
s23c3$subject = "Subject 23"



s23c1$session = "Session 1"
s23c2$session = "Session 2"
s23c3$session = "Session 3"

s24c1$subject = "Subject 24"
s24c2$subject = "Subject 24"
s24c3$subject = "Subject 24"
s24c4$subject = "Subject 24"
s24c5$subject = "Subject 24"


s24c1$session = "Session 1"
s24c2$session = "Session 2"
s24c3$session = "Session 3"
s24c4$session = "Session 4"
s24c5$session = "Session 5"

s25c1$subject = "Subject 25"
s25c2$subject = "Subject 25"

s25c1$session = "Session 1"
s25c2$session = "Session 2"

s26c1$subject = "Subject 26"
s26c2$subject = "Subject 26"
s26c3$subject = "Subject 26"
s26c4$subject = "Subject 26"
s26c5$subject = "Subject 26"


s26c1$session = "Session 1"
s26c2$session = "Session 2"
s26c3$session = "Session 3"
s26c4$session = "Session 4"
s26c5$session = "Session 5"


#s3c2$Cutting=NA




s1c1 <- rename(s1c1,c('Perspiration'='Suturing'))
s1c2 <- rename(s1c2,c('Perspiration'='Suturing'))
s1c3 <- rename(s1c3,c('Perspiration'='Suturing'))
s1c4 <- rename(s1c4,c('Perspiration'='Suturing'))
s1c5 <- rename(s1c5,c('Perspiration'='Suturing'))

s2c1 <- rename(s2c1,c('Perspiration'='Suturing'))
s2c2 <- rename(s2c2,c('Perspiration'='Suturing'))
s2c3 <- rename(s2c3,c('Perspiration'='Suturing'))
s2c4 <- rename(s2c4,c('Perspiration'='Suturing'))
s2c5 <- rename(s2c5,c('Perspiration'='Suturing'))

s3c1 <- rename(s3c1,c('Perspiration'='Suturing'))
s3c2 <- rename(s3c2,c('Perspiration'='Suturing'))
s3c3 <- rename(s3c3,c('Perspiration'='Suturing'))
s3c4 <- rename(s3c4,c('Perspiration'='Suturing'))
s3c5 <- rename(s3c5,c('Perspiration'='Suturing'))

s4c1 <- rename(s4c1,c('Perspiration'='Suturing'))
s4c2 <- rename(s4c2,c('Perspiration'='Suturing'))
s4c3 <- rename(s4c3,c('Perspiration'='Suturing'))
s4c4 <- rename(s4c4,c('Perspiration'='Suturing'))
s4c5 <- rename(s4c5,c('Perspiration'='Suturing'))

s5c1 <- rename(s5c1,c('Perspiration'='Suturing'))
s5c2 <- rename(s5c2,c('Perspiration'='Suturing'))
s5c3 <- rename(s5c3,c('Perspiration'='Suturing'))

s6c1 <- rename(s6c1,c('Perspiration'='Suturing'))

s7c1 <- rename(s7c1,c('Perspiration'='Suturing'))
s7c2 <- rename(s7c2,c('Perspiration'='Suturing'))
s7c3 <- rename(s7c3,c('Perspiration'='Suturing'))
s7c4 <- rename(s7c4,c('Perspiration'='Suturing'))
s7c5 <- rename(s7c5,c('Perspiration'='Suturing'))

s8c1 <- rename(s8c1,c('Perspiration'='Suturing'))
s8c2 <- rename(s8c2,c('Perspiration'='Suturing'))
s8c3 <- rename(s8c3,c('Perspiration'='Suturing'))
s8c4 <- rename(s8c4,c('Perspiration'='Suturing'))
s8c5 <- rename(s8c5,c('Perspiration'='Suturing'))

s9c1 <- rename(s9c1,c('Perspiration'='Suturing'))
s9c2 <- rename(s9c2,c('Perspiration'='Suturing'))

s10c1 <- rename(s10c1,c('Perspiration'='Suturing'))
s10c2 <- rename(s10c2,c('Perspiration'='Suturing'))
s10c3 <- rename(s10c3,c('Perspiration'='Suturing'))
s10c4 <- rename(s10c4,c('Perspiration'='Suturing'))
s10c5 <- rename(s10c5,c('Perspiration'='Suturing'))

s11c1 <- rename(s11c1,Suturing = Perspiration)
s11c2 <- rename(s11c2,Suturing = Perspiration)
s11c3 <- rename(s11c3,Suturing = Perspiration)
s11c4 <- rename(s11c4,Suturing = Perspiration)
s11c5 <- rename(s11c5,Suturing = Perspiration)

s12c1 <- rename(s12c1,Suturing = Perspiration)
s12c2 <- rename(s12c2,Suturing = Perspiration)
s12c3 <- rename(s12c3,Cutting = Perspiration)
s12c4 <- rename(s12c4,Suturing = Perspiration)
s12c5 <- rename(s12c5,Suturing = Perspiration)

s13c1 <- rename(s13c1,Suturing = Perspiration)
s13c2 <- rename(s13c2,Suturing = Perspiration)
s13c3 <- rename(s13c3,Cutting = Perspiration)
s13c4 <- rename(s13c4,Suturing = Perspiration)
s13c5 <- rename(s13c5,Suturing = Perspiration)

s19c1 <- rename(s19c1,Suturing = Perspiration)
s19c2 <- rename(s19c2,Suturing = Perspiration)
s19c3 <- rename(s19c3,Suturing = Perspiration)
s19c4 <- rename(s19c4,Suturing = Perspiration)
s19c5 <- rename(s19c5,Suturing = Perspiration)

s20c1 <- rename(s20c1,Suturing = Perspiration)

s21c1 <- rename(s21c1,Suturing = Perspiration)
s21c2 <- rename(s21c2,Suturing = Perspiration)
s21c3 <- rename(s21c3,Suturing = Perspiration)
s21c4 <- rename(s21c4,Suturing = Perspiration)
s21c5 <- rename(s21c5,Suturing = Perspiration)

s22c1 <- rename(s22c1,Suturing = Perspiration)
s22c2 <- rename(s22c2,Suturing = Perspiration)
s22c3 <- rename(s22c3,Suturing = Perspiration)
s22c4 <- rename(s22c4,Suturing = Perspiration)
s22c5 <- rename(s22c5,Suturing = Perspiration)

s23c1 <- rename(s23c1,Suturing = Perspiration)
s23c2 <- rename(s23c2,Baseline = Suturing)
s23c3 <- rename(s23c3,Suturing = Perspiration)

s24c1 <- rename(s24c1,Suturing = Perspiration)
s24c2 <- rename(s24c2,Suturing = Perspiration)
s24c3 <- rename(s24c3,Suturing = Perspiration)
s24c4 <- rename(s24c4,Suturing = Perspiration)
s24c5 <- rename(s24c5,Suturing = Perspiration)

s25c1 <- rename(s25c1,Suturing = Perspiration)
s25c2 <- rename(s25c2,Suturing = Perspiration)

s26c1 <- rename(s26c1,Suturing = Perspiration)
s26c2 <- rename(s26c2,Suturing = Perspiration)
s26c3 <- rename(s26c3,Suturing = Perspiration)
s26c4 <- rename(s26c4,Suturing = Perspiration)
s26c5 <- rename(s26c5,Suturing = Perspiration)
#fTable <- NULL
library(dplyr)
library(plyr) 
fTable <- filter(fTable, subject != "Subject 13")
test <- filter(fTable, subject == "Subject 12")

fTable<-rbind(fTable,s1c)
fTable<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/Question4.csv")
fTable2<-rbind(fTable2,s26c5)

write.csv(fTable2, file = "/Users/bharatverma/Downloads/COSC_Statistical/project/test.csv")
tail(fTable)
head(fTable)

fTable$subject = factor(fTable$subject, levels=c("Subject 1","Subject 2","Subject 3","Subject 4","Subject 5","Subject 6","Subject 7","Subject 8","Subject 9","Subject 10","Subject 11","Subject 12","Subject 13","Subject 19","Subject 20","Subject 21","Subject 22","Subject 23","Subject 24","Subject 25","Subject 26"))
finalTable <- NULL
finalTable <- subset(fTable, subject=="Subject 1" | subject=="Subject 2" | subject=="Subject 3" | subject=="Subject 4" | subject=="Subject 5" | subject=="Subject 6" | subject=="Subject 7" | subject=="Subject 8" | subject=="Subject 9" | subject=="Subject 10" | subject=="Subject 11")
newdata <- subset(fTable,  subject=="Subject 12" | subject=="Subject 13" | subject=="Subject 19" | subject=="Subject 20" | subject=="Subject 21" | subject=="Subject 22" | subject=="Subject 23" | subject=="Subject 24" | subject=="Subject 25" | subject=="Subject 26")



finalTable[1]<-NULL
finalTable<-rbind(finalTable,newdata)
tail(finalTable)

write.csv(finalTable, file = "/Users/bharatverma/Downloads/COSC_Statistical/project/Question4Final.csv")
fTable<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/project/Question4Final.csv")

f7$subject = factor(f7$subject, levels=c("Subject 1","Subject 2","Subject 3","Subject 4","Subject 5","Subject 6","Subject 7"))
f14$subject = factor(f14$subject, levels=c("Subject 8","Subject 9","Subject 10","Subject 11","Subject 12","Subject 13","Subject 19"))
f21$subject = factor(f21$subject, levels=c("Subject 20","Subject 21","Subject 22","Subject 23","Subject 24","Subject 25","Subject 26"))

f7<-NULL
f14<-NULL
f21<-NULL

f7
f14
f21
f21=rbind(f21,s26c5)

newdata<-f21
sp=ggplot(newdata, aes(x=Time)) + 
  xlab("")+ 
  ylab("")+
  geom_line(aes(y = newdata$Cutting, color = "Cutting"),size=.2) + 
  geom_line(aes(y = newdata$Suturing, color = "Suturing"),size=.2)+
  geom_line(aes(y = newdata$Baseline, color = "Baseline"),size=.2)+
  theme_bw() +
  ggtitle("Perinasal Perspiration [°C^2]")+theme(plot.title = element_text(hjust = 0.5))+
  scale_color_manual(values=c("black", "green","red"))+
  theme(legend.position = "bottom") + ylim(0,.015) + xlim(0,1200)+
  facet_grid(subject ~ session)+
  labs(x = "Time [s]", y = "PP [°C^2]")+
  theme(plot.title = element_text(hjust=0.5, size = (20)),
        legend.title = element_text(size = 18),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 10),
        strip.text = element_text(size=10))+
  theme(legend.title=element_blank())

sp

 
  
sp  

theme(plot.title = element_text(hjust=0.5, size = (20)),
        legend.title = element_text(size = 20),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 20),
        axis.text = element_text(size = 15))




ggplot(aovcut, aes(x=Session, y=Score,color = Response))+
  geom_boxplot() +
  facet_wrap(~Response)+
  labs(title = "Boxplots of NASA-TLX Cutting Responses for All Session", 
       x = "Session", 
       y = "Score", size = 20) +
  theme(plot.title = element_text(hjust=0.5, size = (20)),
        legend.title = element_text(size = 18),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 18),
        strip.text = element_text(size=15)) + 
  guides(col = guide_legend(ncol = 6, byrow = TRUE))

SuturingSubSummary <- ddply(fTable, c("session"), summarise,
                                                        N    = length(Suturing),
                                                        mean = mean(Suturing,na.rm=TRUE),
                                                        sd   = sd(Suturing,na.rm=TRUE),
                                                        se   = sd / sqrt(N),
                                                        mn   = min(Suturing,na.rm=TRUE),
                                                        mx   = max(Suturing,na.rm=TRUE))




CuttingSubSummary <- ddply(fTable, c("session"), summarise,
                            N    = length(Cutting),
                            mean = mean(Cutting,na.rm=TRUE),
                            sd   = sd(Cutting,na.rm=TRUE),
                            se   = sd / sqrt(N),
                            mn   = min(Cutting,na.rm=TRUE),
                            mx   = max(Cutting,na.rm=TRUE))


SuturingSummary <- ddply(fTable, c("session","subject"), summarise,
                         mean = mean(Suturing,na.rm=TRUE))

CuttingSummary <- ddply(fTable, c("session","subject"), summarise,
                      mean = mean(Cutting,na.rm=TRUE))
                          

BaselineSummary <- ddply(fTable, c("session","subject"), summarise,
                      mean = mean(Baseline,na.rm=TRUE))



ggplot(SuturingSummary, aes(x=session, y=mean,color = session))+
  geom_boxplot() +
  labs(title = "Boxplots of Suturing Perspiration for All Session", 
       x = "Session", 
       y = "Perspiration", size = 15) +
  theme(plot.title = element_text(hjust=0.5, size = (15)),
        legend.title = element_text(size = 18),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 18),
        strip.text = element_text(size=15))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+ylim(0,.015) 

 
ggplot(CuttingSummary, aes(x=session, y=mean,color = session))+
  geom_boxplot() +
  labs(title = "Boxplots of Cutting Perspiration for All Session", 
       x = "Session", 
       y = "Perspiration", size = 15) +
  theme(plot.title = element_text(hjust=0.5, size = (15)),
        legend.title = element_text(size = 18),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 18),
        strip.text = element_text(size=15))+
    theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+ylim(0,.015) +
  theme(panel.border = element_rect(linetype = "dashed", fill = NA,colour = "black"))

ggplot(BaselineSummary, aes(x=session, y=mean,color = session))+
  geom_boxplot() +
  labs(title = "Boxplots of Baseline Perspiration for All Session", 
       x = "Session", 
       y = "Perspiration", size = 15) +
  theme(plot.title = element_text(hjust=0.5, size = (15)),
        legend.title = element_text(size = 18),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 18),
        strip.text = element_text(size=15))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+ylim(0,.015) 
  
BaselineSummary$PP = "Baseline"
CuttingSummary$PP = "Cutting"
SuturingSummary$PP = "Suturing"

ppPlot = NULL
ppPlot <-rbind(ppPlot,SuturingSummary)


ggplot(ppPlot, aes(x=session, y=mean,color = session))+
  geom_boxplot() +
  facet_wrap(~PP)+
  labs(title = "Boxplots of Baseline, Cutting, Suturing Perinasal Perspiration[°C^2] for All Session", 
       x = "Session", 
       y = "Perinasal Perspiration[°C^2]", size = 10) +
  theme(plot.title = element_text(hjust=0.5, size = (10)),
        legend.title = element_text(size = 10),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.text = element_text(size = 10), 
        axis.title = element_text(size = 10),
        axis.text = element_text(size = 10),
        strip.text = element_text(size=10))+
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+ylim(0,.015) 
  
bppAnova<-aov(data = BaselineSummary, mean ~ session)
summary(bppAnova)

cppAnova<-aov(data = CuttingSummary, mean ~ session)
summary(cppAnova)

sppAnova<-aov(data = SuturingSummary, mean ~ session)
summary(sppAnova)

write.csv(ppPlot, file = "/Users/bharatverma/Downloads/COSC_Statistical/project/summary.csv")

write.csv(SuturingSummary, file = "/Users/bharatverma/Downloads/COSC_Statistical/project/summarySuturing.csv")



bp<-ggplot(ppPlot, aes(x=session, y=mean,color = session))+
  geom_boxplot() +
  facet_wrap(~PP)+
  labs(title = "Boxplots of Baseline, Cutting, Suturing Perinasal Perspiration [°C^2] for All Session", 
       x = "", 
       y = "Perinasal Perspiration [°C^2]", size = 10) +
theme(plot.title = element_text(hjust=0.5, size = (15)),
        legend.title = element_blank(),
        legend.position="bottom",
        legend.direction="horizontal", 
        legend.title.align = 'center',
        legend.justification = "center",
        legend.text = element_text(size = 15), 
        axis.title = element_text(size = 15),
        axis.text = element_text(size = 10),
        strip.text = element_text(size=10)) + 
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())+ylim(0,.015)+
  geom_vline(xintercept=c(5.6))
  
  
  
  geom_vline(xintercept = -0.586, colour="#990000", linetype="dashed")


  theme(panel.border = element_rect(linetype = "dashed", fill = NA,colour = "black"))
  
  
bp

reposition_legend(bp, 'center')


library(lemon)
install.packages("lemon")

shapiro.test(BaselineSummary$mean)
shapiro.test(CuttingSummary$mean)
shapiro.test(SuturingSummary$mean)

BaselinepValue <- ddply(BaselineSummary, c("session"), summarise,
                            p    = shapiro.test(mean))

psession <- filter(SuturingSummary, session == "Session 1")
shapiro.test(psession$mean)

bppAnova<-aov(data = BaselineSummary, mean ~ session)
summary(bppAnova)


install.packages("xtable")

library(xtable)

pvalue<-read.csv("/Users/bharatverma/Downloads/COSC_Statistical/project/p-value-new.csv")

xtable(pvalue)

bs1 <- filter(BaselineSummary, session == "Session 1")
bs11<-bs1[c("mean")]

cs1 <- filter(CuttingSummary, session == "Session 1")
cs11<-cs1[c("mean")]

cuts1 <- cs11$mean-bs11$mean
shapiro.test(cuts1)
psession <- filter(SuturingSummary, session == "Session 1")

cutF<-read.csv("/Users/bharatverma/Downloads/Cut-score_new.csv")[ ,c('Session', 'CutFinal')]
SutF<-read.csv("/Users/bharatverma/Downloads/Sutur-score_new.csv")[ ,c('Session', 'SuturFinal')]

cs1 <- filter(SutF, Session == "5")
shapiro.test(cs1$SuturFinal)

