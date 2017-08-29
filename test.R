total_num <- max(sum(!is.na(listings$id)),length(unique(listings$id)))




  plot_ly(data = countdf(), x= ~room_type, y=~count_type, type="bar", color=~room_type,
          colors = c('#E03A3C','#009DDC','#62BB47'),
          hoverinfo = 'text',
          text = ~count_type) %>%
    layout(xaxis = list(title="", showticklabels = FALSE),
           yaxis = list(title = "count"), showlegend = FALSE,
           annotations = list(x = ~room_type, y = ~count_type, text = ~paste(round(count_type/sum(count_type),2)*100,'%'),
                              xanchor = 'center', yanchor = 'bottom',
                              showarrow = FALSE)) %>% 
    config(displayModeBar = FALSE)


  listings %>%
    group_by(., room_type) %>%
    summarise(., count_type=n(), )

  
  listings$price <- as.numeric(gsub('[$,]', '', listings$price))
  total_num_pivot <- listings %>% 
    group_by_(.dots=c("neighbourhood_cleansed","room_type")) %>% 
    summarise(., count_type=n(), avg_price=round(mean(price)))
  
  
  write_csv(total_num_pivot,"total_num_pivot.csv")
  
  plot_ly(data = total_num_pivot, x= ~room_type, y=~count_type, type="bar", color=~room_type,
          colors = c('#E03A3C','#009DDC','#62BB47'))
  
  a <- ggplot(total_num_pivot,aes(room_type,count_type)) + geom_col(aes(fill=room_type)) + coord_flip()
  b <- ggplot(total_num_pivot,aes(room_type,avg_price)) + geom_col(aes(fill=room_type)) + coord_flip()
  
 