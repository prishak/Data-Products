library(shiny)
library(shinythemes)

shinyUI(fluidPage(
  theme=shinytheme("cyborg"),
  
  titlePanel("VICTIMS OF ROAD ACCIDENTS IN THE EUROPE"),
  sidebarLayout(
    sidebarPanel(
      
      selectInput("Choose","Select",
                  c(Country="C_Plot",Year="Y_Plot")
      ),
      conditionalPanel(
        condition="input.Choose=='C_Plot'",
        selectInput(
          "geo","Country:-",
          c("Austria","Belgium","Czech Republic","Denmark","Greece","Spain","Finland","France","Ireland","Italy","Liechtenstein","Luxembourg","Netherlands","Portugal","Romania",
            "Sweden","United Kingdom","Poland","Slovenia","Bulgaria","Switzerland","Cyprus","Estonia","Hungary","Iceland","Latvia",
            "Malta","Norway","Slovakia","Croatia","Lithuania")),
        radioButtons("radio","Radio buttons",
                     c("Summary" = "summary", "Table" = "table"))
        
      ),
      conditionalPanel(
        condition="input.Choose=='Y_Plot'", sliderInput('time','Year Slider(Automatic)',
                                                        value = 2000, min =1999, max =2015,animate = TRUE),
        radioButtons("radio","Radio buttons",
                     c("Summary" = "summary", "Table" = "table"))
      )),
    mainPanel(
      
      fluidRow(
        plotOutput("plot"),
        conditionalPanel(
          condition = "input.radio == 'summary'",verbatimTextOutput("summary")),
        conditionalPanel(
          condition = "input.radio == 'table'", tableOutput("table")))
      
    ))
))



