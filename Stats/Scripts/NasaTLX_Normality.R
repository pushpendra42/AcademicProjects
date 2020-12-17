
cuttinglm=lm(cutscore$Score~factor(cutscore$Session)+cutscore$PersCut+factor(cutscore$Session)+factor(cutscore$Scorer)+cutscore$Age+factor(cutscore$Sex))
summary(cuttinglm)
boxplot(cuttinglm)


sutscore=read.csv("D:/CourseWork/Statstical/Project/sutdata.csv")
sutlm=lm(sutscore$Score~factor(sutscore$Session)+sutscore$PersSut+factor(sutscore$Session)+factor(sutscore$Scorer)+sutscore$Age+factor(sutscore$Sex))
summary(sutlm)


cutnasa=read.xlsx("D:/CourseWork/Statstical/Project/cutting_nasa.xlsx")

mentaldemand=cutnasa[cutnasa$Response=="Mental Demand",]
mentaldemand$Subject=NULL
mentaldemand$Response=NULL
kruskal.test(mentaldemand)

phys=cutnasa[cutnasa$Response=="Physical Demand",]
phys$Subject=NULL
phys$Response=NULL
kruskal.test(phys)

tempral=cutnasa[cutnasa$Response=="Temporal Demand",]
tempral$Subject=NULL
tempral$Response=NULL
kruskal.test(tempral)

perf=cutnasa[cutnasa$Response=="Performance",]
perf$Subject=NULL
perf$Response=NULL
kruskal.test(perf)

effort=cutnasa[cutnasa$Response=="Effort",]
effort$Subject=NULL
effort$Response=NULL
kruskal.test(effort)

frus=cutnasa[cutnasa$Response=="Frustration",]
frus$Subject=NULL
frus$Response=NULL
kruskal.test(frus)


sutnasa=read.xlsx("D:/CourseWork/Statstical/Project/suturing_nasa.xlsx")

mentaldemandsut=sutnasa[sutnasa$Response=="Mental Demand",]
mentaldemandsut$Subject=NULL
mentaldemandsut$Response=NULL
kruskal.test(mentaldemandsut)

physsut=sutnasa[sutnasa$Response=="Physical Demand",]
physsut$Subject=NULL
physsut$Response=NULL
kruskal.test(physsut)

tempralsut=sutnasa[sutnasa$Response=="Temporal Demand",]
tempralsut$Subject=NULL
tempralsut$Response=NULL
kruskal.test(tempralsut)

perfsut=sutnasa[sutnasa$Response=="Performance",]
perfsut$Subject=NULL
perfsut$Response=NULL
kruskal.test(perfsut)

effortsut=sutnasa[sutnasa$Response=="Effort",]
effortsut$Subject=NULL
effortsut$Response=NULL
kruskal.test(effortsut)

frussut=sutnasa[sutnasa$Response=="Frustration",]
frussut$Subject=NULL
frussut$Response=NULL
kruskal.test(frussut)

