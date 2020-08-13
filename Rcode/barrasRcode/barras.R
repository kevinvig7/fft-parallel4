# library
library(readxl)
library(ggplot2)
library(RColorBrewer)
#library(latex2exp)
#library(tikzDevice)

areaTiempo <- read_excel("areaTiempo.xlsx")
powerArea  <- read_excel("powerArea.xlsx")

WNS_100 <- areaTiempo$Slack
LUT_100 <- areaTiempo$CombinationalArea
FF_100  <- areaTiempo$NoncombinationalArea

WNS_200 <- powerArea$TotalCellArea
LUT_200 <- powerArea$TotalDynamicPower
FF_200  <- powerArea$CellLeakagePower

# Area-Tiempo
# create a dataset
Arquitectura = c(rep(c("Imp. 1","Imp. 2","Imp. 3","Imp.4","Imp.5"),2))
Area=c(rep("Combinational",5),rep("Noncombinational",5))
Cantidad =c(LUT_100,FF_100)
Cantidad_num <- as.numeric(Cantidad)
data=data.frame(Area,Arquitectura,Cantidad_num,x=1:5,WNS_100)
data_frec= data.frame(x=1:5,WNS_100)

# Grouped
ggplot(data) + geom_bar(aes(fill=Area, y=Cantidad_num, x=Arquitectura),position="dodge", stat="identity") + scale_fill_manual(values=brewer.pal(n = 5, name = "Paired")) +  
  geom_line(aes(x,(5e4*WNS_100+2.05e5)),size = 1) + 
  scale_y_continuous(sec.axis = sec_axis(~./5e4-4.1, name = "Slack (ns)")) +  ylab("Area (um2)") + xlab("Implementation")


#Power-Area
#create a dataset
Arquitectura = c(rep(c("Imp. 1","Imp. 2","Imp. 3","Imp. 4","Imp.5"),2))
Power=c(rep("Total Dynamic",5),rep("Cell Leakage",5))
Cantidad =c(LUT_200,FF_200)
Cantidad_num <- as.numeric(Cantidad)
data=data.frame(Power,Arquitectura,Cantidad_num,x=1:5,WNS_200)
data_frec= data.frame(x=1:5,WNS_200)

# Grouped
ggplot(data) + geom_bar(aes(fill=Power, y=Cantidad_num, x=Arquitectura),position="dodge", stat="identity") + scale_fill_manual(values=brewer.pal(n = 5, name = "Paired")) +  
  geom_line(aes(x,(0.004*WNS_200-1000+100)),size = 1) + 
  scale_y_continuous(sec.axis = sec_axis(~./0.004+224.5e3, name = "Total Cell Area (um2)"))  +  ylab("Power (mW)") + xlab("Implementation")
