library(shiny)
library(ggplot2)
library(dplyr)
library(eurostat)

library(reshape2)
library(gridExtra)

p1<-get_eurostat("tsdtr420",filters = list(geo=c("AT","BE","CZ","DE","DK","EL","ES","FI","FR",
                                                 "IE","IT","LI","LU","NL","PT","RO","SE","UK","PL","SI","BG","CH","CY",
                                                 "EE","HU","IS","LV","MT","NO","SK","HR","LT"),time_format="num"))
p2<-p1[!rowSums(is.na(p1)),]
p2<-label_eurostat(p2)

shinyServer(
  function(input, output) {
    
    output$plot<-renderPlot({
      
      if(input$Choose=="C_Plot"){
        
        p3 <- filter(p2, grepl(input$geo,geo))
        p<-ggplot(data=p3,aes(time,values,fill=values))+
          geom_bar(stat="identity")+theme_minimal()+theme(legend.position="none")+
          labs(title="Road Accidents Victims(COUNTRY)",x="YEAR",y="VICTIMS")
        print(p)
        
        output$summary<-renderPrint({
          p3 <- filter(p2, grepl(input$geo,geo))
          summary(p3)})
        
        output$table<-renderTable({
          p3 <- filter(p2, grepl(input$geo,geo))
          head(p3)
        })
        
        
      }else{
        p4 <- filter(p2, grepl(input$time,time))
        pp<-ggplot(data=p4,aes(geo,values,fill=geo))+
          geom_bar(stat="identity")+theme_minimal()+theme(axis.text.x=element_text(angle=45,hjust=1,size =12),legend.position="none")+
          labs(title="Road Accidents Victims (YEAR)",x="COUNTRY NAMES",y="VICTIMS")
        print(pp)
        time<-input$time
        output$summary<-renderPrint({
          p3 <- filter(p2, grepl(input$time,time))
          summary(p3)})
        
        output$table<-renderTable({
          p3 <- filter(p2, grepl(input$time,time))
          head(p3)
        })
        
        
        
      }
    })
  }
)