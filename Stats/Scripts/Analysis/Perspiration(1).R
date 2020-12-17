

cutscore=read.xlsx("D:/CourseWork/Statstical/Project/Cut-score.xlsx")

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
  pathsut=paste("D:/CourseWork/Statstical/Project/Methodist microsurgery with output/subject",counter,"/subject",counter,"/session",sess,"/Subject",counter,"_Suturing",sess,".csv",sep = "")
  #print(path)
  
  isExit=file.exists(path)
  isExitcut=file.exists(pathcut)
  isExitsut=file.exists(pathsut)
  
  if(isExit)
  {
  perform=read.csv(path)
  #subInt=as.integer(counter)
  subInt=z
  
  index1=15*(incre-1)+subInt
  index2=15*(incre)+subInt
  
  persp=mean(perform$Perspiration)
  cutscore[index1,7]=persp
  cutscore[index2,7]=persp
  
  x=paste("Subject",counter,"Session",sess,"value=",persp)
  print(x)
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
    cutscore[index1,8]=perspcut
    cutscore[index2,8]=perspcut
    
    
    x=paste("Subject",counter,"Session",sess,"value=",persp)
    print(x)
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
    cutscore[index1,9]=perspsut
    cutscore[index2,9]=perspsut
    
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

#write.csv(cutscore, "d:/mydata.csv")


cuttinglm=lm(cutscore$Score~factor(cutscore$Session)+cutscore$PersCut+factor(cutscore$Session)+factor(cutscore$Scorer)+cutscore$Age+factor(cutscore$Sex))
summary(cuttinglm)
boxplot(cuttinglm)
ggplot(cuttinglm, aes(x=birth.data$Teenage_Mother, y=birth.data$Mortality))

sutscore=read.csv("C:/Users/hneel/Desktop/SMR-P/PUSH/sutdata.csv")
sutlm=lm(sutscore$Score~factor(sutscore$Session)+sutscore$PersSut+factor(sutscore$Session)+factor(sutscore$Scorer)+sutscore$Age+factor(sutscore$Sex))
summary(sutlm)

xtable(sutlm)

cutnasa=read.csv("D:/CourseWork/Statstical/Project/cutting_nasa.xlsx")



