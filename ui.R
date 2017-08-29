shinyUI(
  navbarPage(title = "Airbnb Visualization", 
             id ="nav",
             
             theme = shinytheme("simplex"), #https://rstudio.github.io/shinythemes/
             
#### Map ##########      
    tabPanel("Boston map",
      div(class = "outer",
          tags$head(includeCSS("styles.css"),#customized CSS
                    includeScript("gomap.js")),
          
      leafletOutput(outputId = "map",width="100%", height="100%"),
                          
      # Options: borough, Room Type, Price, Rating, Reviews
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE, draggable = FALSE, 
                    top = 180, left = "auto", right = 20, bottom = "auto",
                    width = "auto", height = "auto",
                                        
      h2("Airbnb in Boston"),
      
      selectInput(inputId = "select_boro", label = h4("Neighbourhood"), 
                         choices = c("All",boro), selected = 'All'),
      checkboxGroupInput(inputId = "select_room", label = h4("Room Type"), 
                         choices = room, selected = room),
      sliderInput(inputId = "slider_price", label = h4("Price"), min = 10, max = 1000,
                  pre = "$", sep = ",", value = c(100, 300)), 
      sliderInput(inputId = "slider_rating", label = h4("Rating Score"), min = 20, max = 100, 
                  value = c(60, 100)),
      sliderInput(inputId = "slider_review", label = h4("Minimum Number of Reviews"), min = 10, max = 100, 
                  value = 10, step = 10)
      ),
      
      absolutePanel(id = "controls", class = "panel panel-default", fixed = FALSE, draggable = TRUE, 
                    top = 320, left = 20, right = "auto" , bottom = "auto",
                    width = 320, height = 320),
                    plotOutput(outputId = "count_room")
      
      ))


))




