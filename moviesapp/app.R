library(shinythemes)
library(shiny) 
library(DT)


ui <- fluidPage(theme = shinytheme("sandstone"),
  
  titlePanel("Movies Recommendation Path"),
  
  sidebarLayout(position = "left",
                sidebarPanel(
                  
                  helpText("Find the optimal movies path."),
                  
                  selectInput("var1", 
                              label = "Choose a first movie",
                              choices =  movies_used$original_title),
                  
                  selectInput("var2", 
                              label = "Choose a second movie",
                              choices =  movies_used$original_title),
                  
                  br(), # br() element to introduce extra vertical spacing ----
                  
                  br(),
                  
                  helpText("Get the similarities between two movies."),
                  
                  selectInput("var3", 
                              label = "First movie",
                              choices =  movies_used$original_title),
                  
                  selectInput("var4", 
                              label = "Second movie",
                              choices =  movies_used$original_title)
                  
                  
                ),
                
                mainPanel(
                  #tableOutput("table")
                  
                  tabsetPanel(
                    tabPanel("Path", br(), helpText("The optimal path between those movies is"),DT::dataTableOutput("mytable")), 
                    tabPanel("Similarities",br(), helpText("The keywords in common for the two movies are"),textOutput("keywords"),
                             br(), helpText("The genres in common for the two movies are"),textOutput("genre"))
                  )
                  
                  #helpText("The optimal path between those movies is"),
                  #textOutput("list"),
                  
                  
                  #helpText("The keywords in common for the two movies are"),
                  #textOutput("keywords"),
                  
                  #helpText("The genres in common for the two movies are"),
                  #textOutput("genre")
                  
                  
                )
  )
)

server <- function(input, output) {
  
  #output$table <- renderTable({ 
  #movies_path(c(input$var1,input$var2))
  #})
  
  #output$list <- renderText({
  #paste("The paths is :", movies_path(c(input$var1, input$var2))[[1]], "to", movies_path(c(input$var1, input$var2))[[2]])
  #})
  
  #output$list <- renderText({ movies_character(c(input$var1, input$var2))
  #})
  
  output$keywords <- renderText({ similarities_key(c(input$var3, input$var4))
  })
  
  output$genre <- renderText({ similarities_genre(c(input$var3, input$var4))
  })
  
  output$mytable = DT::renderDataTable({
    movies_path(c(input$var1,input$var2))
  })
  
  
  
}

shinyApp(ui = ui, server = server)

