WNS_100 <- Imp_100MHz$WNS
LUT_100 <- Imp_100MHz$LUT
FF_100 <- Imp_100MHz$FF

WNS_200 <- Imp_200MHz$WNS
LUT_200 <- Imp_200MHz$LUT
FF_200 <- Imp_200MHz$FF

# library
library(ggplot2)
library(RColorBrewer)
library(plotrix)

#FIRS 100MHz

# create a dataset
Arquitectura = c(rep(c("Imp. 1a","Imp. 1b","Imp. 1c","Imp. 1d","Imp. 2a","Imp. 2b","Imp. 2c","Imp. 2d"),2))
Celda=c(rep("LUTs",8),rep("FFs & Latchs",8))
Cantidad =c(LUT_100,FF_100)
Cantidad_num <- as.numeric(Cantidad)
data=data.frame(Celda,Arquitectura,Cantidad_num,x=1:8,WNS_100)
data_frec= data.frame(x=1:8,WNS_100)

# Grouped
ggplot(data) + geom_bar(aes(fill=Celda, y=Cantidad_num, x=Arquitectura),position="dodge", stat="identity") + scale_fill_manual(values=brewer.pal(n = 8, name = "Paired")) +  
  geom_line(aes(x,(100*WNS_100+100)),size = 1) + #+ scale_x_continuous(breaks=1:8, labels=Arquitectura[0:8]) 
  scale_y_continuous(sec.axis = sec_axis(~./100-1, name = "WNS [ns]")) +  ylab("Cantidad") + xlab("Implementación")

#FIRS 200MHz

# create a dataset
Arquitectura = c(rep(c("Imp. 1a","Imp. 1b","Imp. 1c","Imp. 1d","Imp. 1e","Imp. 2a","Imp. 2b","Imp. 2c","Imp. 2d"),2))
Celda=c(rep("LUTs",9),rep("FFs & Latchs",9))
Cantidad =c(LUT_200,FF_200)
Cantidad_num <- as.numeric(Cantidad)
data=data.frame(Celda,Arquitectura,Cantidad_num,x=1:9,WNS_200)
data_frec= data.frame(x=1:9,WNS_200)

# Grouped
ggplot(data) + geom_bar(aes(fill=Celda, y=Cantidad_num, x=Arquitectura),position="dodge", stat="identity") + scale_fill_manual(values=brewer.pal(n = 9, name = "Paired")) +  
  geom_line(aes(x,(100*WNS_200+550)),size = 1) + #+ scale_x_continuous(breaks=1:8, labels=Arquitectura[0:8]) 
  scale_y_continuous(sec.axis = sec_axis(~./100-5.5, name = "WNS [ns]"))  +  ylab("Cantidad") + xlab("Implementación")
