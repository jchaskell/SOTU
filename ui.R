library(shiny)
load("speeches.RData")

shinyUI(pageWithSidebar(
        headerPanel("State of the Union Word Tracker"),
        sidebarPanel(
                #Drop down menu of words
                selectInput(inputId = "word", label = h3("Choose word to track"), 
                            choices = labels_app, 
                            selected = 1)
                
        ),
        mainPanel(
                p("The US Constitution says that the president must 'give to the Congress Information of the State of the Union,' which has led to the tradition of the annual State of the Union address. While presidents have given the address almost every year since the country's founding, what they have focused on has evolved over time. We can get a sense of those changes by looking at how often different words are mentioned in the State of the Union over time."),
                  p("Choose a word on the sidebar to see how often it has been used in the State of the Union between 1790 and 2015."),
                plotOutput('sotuLinePlot')
        )
))
