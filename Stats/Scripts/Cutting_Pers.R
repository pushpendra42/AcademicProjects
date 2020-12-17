

cutscore=read.csv("D:/CourseWork/Statstical/Project/Cut-score.csv")

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
  pathcut=paste("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject",counter,"/subject",counter,"/session",sess,"/Subject",counter,"_Cutting",sess,".csv",sep = "")
  
  
  isExit=file.exists(path)
  isExitcut=file.exists(pathcut)
  
  if(isExit)
  {
  perform=read.csv(path)
  #subInt=as.integer(counter)
  subInt=z
  
  index1=15*(incre-1)+subInt
  index2=15*(incre)+subInt
  
  persp=mean(perform$Perspiration)
  cutscore[index1,8]=persp
  cutscore[index2,8]=persp
  
  x=paste("Subject",counter,"Session",sess,"value=",persp)
  #print(x)
  }
    else
    {
      print("File doesnot exist")
    }
  
  #cut
  
  if(isExitcut)
  {
  
    performcut=read.csv(pathcut)
  
    #subInt=as.integer(counter)
    subInt=z
    
    index1=15*(incre-1)+subInt
    index2=15*(incre)+subInt
    
    
    perspcut=mean(performcut$Perspiration)
    cutscore[index1,9]=perspcut
    cutscore[index2,9]=perspcut
    
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

diffPerCut=cutscore$PersCut-cutscore$PersBase
diffPerCutWthoutNA=diffPerCut
diffPerCutWthoutNA[is.na(diffPerCutWthoutNA)==1] <- 0

mindiffPerCut=abs(min(diffPerCutWthoutNA))

diffPerCutAdjusted=diffPerCut+mindiffPerCut+0.001
cutscore$CutFinal=diffPerCut
cutscore$CutFinalAdjusted=diffPerCutAdjusted
cutscore$CutFinalLog=log(diffPerCutAdjusted)

cuttimeseconds = lubridate::period_to_seconds(ms(cutscore$Time))
cutscore$Time1=cuttimeseconds
cutscore$Time1sqrt=sqrt(cuttimeseconds)

cutscore$Time2=cuttimeseconds
cutscore$Time2sqrt=sqrt(cuttimeseconds)

cutscore$TaskName="Cutting"

write.csv(cutscore, "D:/CourseWork/Statstical/Project/Cut-score_new.csv",row.names=F)

