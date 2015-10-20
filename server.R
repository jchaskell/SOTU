library(shiny)
library(ggplot2)
load("speeches.RData")

shinyServer(
        function(input, output) {
                output$sotuLinePlot <- renderPlot({
                        word <- labels[as.numeric(input$word)]
                        word_n <- as.numeric(input$word)
                        p <- ggplot(sotu, aes(x = year, y = sotu[, word_n])) + geom_line(color = "blue", lwd = 0.5) +
                                ggtitle(word) + xlab("Year") + ylab("Count") + 
                                theme_bw() +
                                theme(#axis.line = element_line(colour = "black"),
                                        #plot.background = element_blank(),
                                        #                               panel.grid.minor= element_blank(),
                                        #                               panel.grid.major.x = element_blank(),
                                        #                               panel.grid.major.y = element_blank(),
                                        panel.border = element_blank(),
                                        panel.background = element_blank(),
                                        plot.title = element_text(size = 18, face = "bold", color = "blue"),
                                        axis.title = element_text(size = 12))
                        
                        print(p)
                }) }
)
