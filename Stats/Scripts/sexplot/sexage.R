########   SEXPLOT  ###########
library(ggplot2)



sexdata <- data.frame(
  Sex = c("Male", "Female"),
  value = c(10,5)
)


plot1 <- ggplot(sexdata, aes(x="", y=value, fill=Sex))+
  geom_bar(width = 1, stat = "identity") + 
  coord_polar("y", start=0) + 
  scale_fill_manual(values=c("#42b6f4", "#f7a0c9")) + 
  labs(title = "Sex Distribution of Study Participents",x = "value", y = "Gender") + 
  theme(plot.title = element_text(hjust=0.5, size = 15), legend.title = element_text(size = 15))


plot1


age = data.frame(Age= c("21-22", "22-23","23-24", "24-25", "25-26"), agevalue = c(4,5,1,2,1))

ggplot(age, aes(x = Age, y = agevalue ,fill = Age )) + 
  geom_bar(width = 0.85, stat="identity") + coord_polar(theta = "x")+
  geom_text( vjust = 0, aes(label = agevalue), size = 5) 
  
