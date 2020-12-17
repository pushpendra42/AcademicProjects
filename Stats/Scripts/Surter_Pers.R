
library("lubridate")
sutscore=read.csv("D:/CourseWork/Statstical/Project/Sutur-score.csv")

persp<-0
path<-0


#subjects=c("01","02","03","04","05","06","07","08","09","10","11","12","13","19","20","21","22","23","24","25","26")
subjects=c("01","02","03","04","07","08","10","11","12","13","19","21","22","24","26")
rowCounter=1
subLength=length(subjects)
incre=1
z=0

for (sess in 1:5){
  z=0
for (counter in subjects){
  z=z+1
  path=paste("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject",counter,"/subject",counter,"/session",sess,"/Subject",counter,"_Baseline",sess,".csv",sep = "")
  pathsut=paste("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject",counter,"/subject",counter,"/session",sess,"/Subject",counter,"_Suturing",sess,".csv",sep = "")
  #print(path)
  
  isExit=file.exists(path)
  isExitsut=file.exists(pathsut)
  
  if(isExit)
  {
  perform=read.csv(path)
  #subInt=as.integer(counter)
  subInt=z
  
  index1=15*(incre-1)+subInt
  index2=15*(incre)+subInt
  
  persp=mean(perform$Perspiration)
  sutscore[index1,9]=persp
  sutscore[index2,9]=persp
  
  x=paste("Subject",counter,"Session",sess,"value=",persp)
  #print(x)
  }
    else
    {
      print("File doesnot exist")
    }
  
  
  #sut
  
  if(isExitsut)
  {
    performsut=read.csv(pathsut)
    
    #subInt=as.integer(counter)
    subInt=z
    
    index1=15*(incre-1)+subInt
    index2=15*(incre)+subInt
    
    perspsut=mean(performsut$Perspiration)
    sutscore[index1,10]=perspsut
    sutscore[index2,10]=perspsut
    
    x=paste("Subject",counter,"Session",sess,"value=",persp)
    print(x)
  }
  else
  {
    print("File doesnot exist")
  }
  }
  
  rowCounter=rowCounter+1
  incre=incre+2
}

suturtimeseconds = lubridate::period_to_seconds(ms(sutscore$Time))

diffPerSut=sutscore$PersSut-sutscore$PersBase
sutscore$SuturFinal=diffPerSut

diffPerSutWthoutNA=diffPerSut
diffPerSutWthoutNA[is.na(diffPerSutWthoutNA)==1] <- 0

mindiffPerSut=abs(min(diffPerSutWthoutNA))

diffPerSutAdjusted=diffPerSut+mindiffPerSut+0.001

sutscore$SutFinalAdjusted=diffPerSutAdjusted
sutscore$SutFinalLog=log(diffPerSutAdjusted)

suturtimeseconds =lubridate::period_to_seconds(ms(sutscore$Time))
#sutscore$SuturQuality=sutscore$Score/sutscore$Sutur

sutscore$Time1=suturtimeseconds
sutscore$Time1Sqrt=sqrt(suturtimeseconds)

sutscore$Time2= suturtimeseconds/(sutscore$Sutur)
sutscore$Time2Sqrt=sqrt(suturtimeseconds/(sutscore$Sutur))

sutscore$TaskName="Suturing"

write.csv(sutscore, "D:/CourseWork/Statstical/Project/Sutur-score_new.csv",row.names=F)

