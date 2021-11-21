cocktaildata <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-26/cocktails.csv')
cocktails <- subset(cocktaildata, select = -c(row_id, date_modified, id_drink, drink_thumb, iba, video) )
library(shiny)
require(ggplot2)
require(dplyr)
ui <- fluidPage(
    titlePanel("Cocktail"),
    fluidRow(
        column(4,
               selectInput("name",
                           "Name:",
                           c("All",
                             unique(as.character(cocktails$drink))))
        ),
        column(4,
               selectInput("type",
                           "Type:",
                           c("All",
                             unique(as.character(cocktails$alcoholic))))
        ),
        column(4,
               selectInput("category",
                           "Category:",
                           c("All",
                             unique(as.character(cocktails$category))))
        ),
        column(4,
               selectInput("ingredient",
                           "Ingredient:",
                           c("All",
                             unique(as.character(cocktails$ingredient))))
        )
    ),
    DT::dataTableOutput("table")
)

server <- function(input, output) {
    output$table <- DT::renderDataTable(DT::datatable({
        data <- cocktails
        if (input$name != "All") {
            data <- data[data$drink == input$name,]
        }
        if (input$type != "All") {
            data <- data[data$alcoholic == input$type,]
        }
        if (input$category != "All") {
            data <- data[data$category == input$category,]
        }
        if (input$ingredient != "All") {
            data <- data[data$ingredient == input$ingredient,]
        }
        data
    }))
}


library(rsconnect)
rsconnect::setAccountInfo(name='jiajackteo', token='E03E9C977558A204162248DACEC27BC9', secret='/kbbSPCaHkhlLD5wgmhVjVMho5Cu177RgOQU6feK')
rsconnect::deployApp()
    
