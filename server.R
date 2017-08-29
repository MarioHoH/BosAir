shinyServer(function(input, output, session) {
  mapdf <- reactive({
    if (input$select_boro == "All") {
      m <- nycmap %>%
        filter(
          room_type %in% input$select_room &
            price >= input$slider_price[1] &
            price <= input$slider_price[2] &
            review_scores_rating >= input$slider_rating[1] &
            review_scores_rating <= input$slider_rating[2] &
            number_of_reviews >= input$slider_review
        )
    } else {
      m <- nycmap %>%
        filter(
          neighbourhood_cleansed %in% input$select_boro &
            room_type %in% input$select_room &
            price >= input$slider_price[1] &
            price <= input$slider_price[2] &
            review_scores_rating >= input$slider_rating[1] &
            review_scores_rating <= input$slider_rating[2] &
            number_of_reviews >= input$slider_review
        )
    }
  })
  
  
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addLegend(
        position = "bottomleft",
        pal = groupColors,
        values = room,
        opacity = 1,
        title = "Room Type"
      ) %>%
      setView(lng = -71.0589,
              lat = 42.3601,
              zoom = 12)
  })
  
  observe({
    proxy <- leafletProxy("map", data = mapdf()) %>%
      clearMarkerClusters() %>%
      clearMarkers() %>%
      addCircleMarkers(
        ~ longitude,
        ~ latitude,
        radius = 8,
        color = ~ groupColors(room_type),
        group = "CIRCLE",
        popup = ~ paste(
          '<b><font color="Black">',
          'Listing Information',
          '</font></b><br/>',
          'Room Type:',
          room_type,
          '<br/>',
          'Price:',
          price,
          '<br/>',
          'Rating Score:',
          review_scores_rating,
          '<br/>',
          'Number of Reviews:',
          number_of_reviews,
          '<br/>'
        ),
        stroke = F,
        fillOpacity = 0.7
        
      ) %>%
      addCircleMarkers(~ longitude,
                       ~ latitude,
                       clusterOptions = markerClusterOptions(),
                       group = "CLUSTER") %>%
      addLayersControl(
        baseGroups = c("CIRCLE", "CLUSTER"),
        options = layersControlOptions(collapsed = FALSE)
      )
  })
  
  output$count_room <- renderPlot({
    ggplot(total_num_pivot,aes(room_type,count_type)) + geom_col(aes(fill = room_type)) + coord_flip()
  })
  
  
  
  
  
})