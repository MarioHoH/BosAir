## global
library(shiny)
library(leaflet)
library(tidyverse)
library(shinythemes)

# load data
nycmap <- read_csv("/R/Boston Airbnb/nycmap.csv")
total_num_pivot <- read_csv("/R/Boston Airbnb/total_num_pivot.csv")
# variables
boro <- c(
  "Allston" = "Allston",
  "Back Bay" = "Back Bay",
  "Bay Village" = "Bay Village",
  "Beacon Hill" = "Beacon Hill",
  "Brighton" = "Brighton",
  "Charlestown" = "Charlestown",
  "Chinatown" = "Chinatown",
  "Dorchester" = "Dorchester",
  "Downtown" = "Downtown",
  "East Boston" = "East Boston",
  "Fenway" = "Fenway",
  "Hyde Park" = "Hyde Park",
  "Jamaica Plain" = "Jamaica Plain",
  "Leather District" = "Leather District",
  "Longwood Medical Area" = "Longwood Medical Area",
  "Mattapan" = "Mattapan",
  "Mission Hill" = "Mission Hill",
  "North End " = "North End",
  "Roslindale" = "Roslindale",
  "Roxbury" = "Roxbury",
  "South Boston" = "South Boston",
  "South Boston Waterfront" = "South Boston Waterfront",
  "South End" = "South End",
  "West End" = "West End",
  "West Roxbury" = "West Roxbury"
)

room <- c(
  "Entire home/apt" = "Entire home/apt",
  "Private room" = "Private room",
  "Shared room" = "Shared room"
)

groupColors <- colorFactor(
  c("#E03A3C", "#009DDC", "#62BB47"),
  domain = c("Entire home/apt", "Private room", "Shared room")
)



