install.packages("leaflet")
library(leaflet)
library(ggplot2)
library(ggmap)
library(tidyverse)
library(sp)
library(rgdal)  
library(maps)

#get the geocode for required positions
bude <- geocode("Bude, England, UK")
bude <- fortify(bude)

bar <- geocode("The Lucky Kiss, 20 Belle Vue, Bude EX23 8JL, UK")
data_bar <- fortify(bar)

cricket <- geocode("Bude North Cornwall Cricket Club, S W Coast Path, Bude EX23 8HN, UK")
data_cricket <- fortify(cricket)

Crooklets_Beach <- geocode("S W Coast Path, Bude EX23 8NE, UK")
data_Crooklets_Beach <- fortify(Crooklets_Beach)

Summerleaze_Beach <- geocode("Summerleaze Cres, Bude EX23 8HN, UK")
data_Summerleaze_Beach <- fortify(Summerleaze_Beach)

data_all <- rbind(data_bar,data_cricket,data_Crooklets_Beach,data_Summerleaze_Beach)

#prepare for the popup
c_beach_p <- paste(sep = "<br/>",
                 "<b><a href='https://www.visitcornwall.com/beaches/lifeguards-seasonal/north-coast/bude/crooklets-beach'>Crooklets Beach</a></b>",
                 "Adress: S W Coast Path, Bude EX23 8NE.",
                 "UK606 5th Ave"
)

bar_p <- paste(sep = "<br/>",
               "<b><a href='https://thegoodpubguide.co.uk/pub/ex23+8jl/the+lucky+kiss+sports+bar/'>Lucky Kiss Sports Bar</a></b>",
                 "Phone: +44 1288 356788",
                 "Opening hours",
                 "Monday 18:00 - 23:45",
                 "Tuesday 18:00 - 23:45",
                 "Wednesday 18:00 - 23:45",
                 "Thursday 18:00 - 23:45",
                 "Friday 18:00 - 03:00",
                 "Saturday 12:00 - 03:00",
                 "Sunday 12:00 - 02:30",
                 "Adress: 20 Belle Vue",
                 "Bude EX23 8JL, UK"
)

c_p <- paste(sep = "<br/>",
                 "<b><a href='http://budecc.play-cricket.com/'>Bude North Cornwall Cricket Club</a></b>",
                 "Adress: Bude North Cornwall Cricket Club",
                 "S W Coast Path, Bude EX23 8HN, UK"
)

s_beach_p <- paste(sep = "<br/>",
                 "<b><a href='https://www.visitbude.info/accommodation/extra-large-beach-huts/'>Summerleaze_Beach</a></b>",
                 "Adress: Summerleaze Cres",
                 "Bude EX23 8HN, UK"
)

road <- paste(sep = "<br/>",
              "The road that links cricket and bar"
)

#get the road info
start <- "20 Belle Vue, Bude EX23 8JL, UK"
end <- "Bude North Cornwall Cricket Club"
route <- route(start, end, structure = "route")

route_data <- data.frame(x = route$lon, y= route$lat)

#draw the map
m <- leaflet(route_data)

m %>%
  addProviderTiles(providers$OpenMapSurfer) %>%
  addPolylines(lng = ~ x, lat = ~ y, popup = road) %>% 
  addMarkers(lng = -4.544881,lat = 50.83062, popup = bar_p) %>% 
  addMarkers(lng = -4.552814,lat = 50.83347, popup = c_p) %>% 
  addMarkers(lng = -4.554378,lat = 50.83683, popup = c_beach_p) %>% 
  addMarkers(lng = -4.549855,lat = 50.83097, popup = s_beach_p) 

#water map
m %>%
  addProviderTiles(providers$Stamen.Watercolor) %>%
  addPolylines(lng = ~ x, lat = ~ y, popup = road) %>% 
  addMarkers(lng = -4.544881,lat = 50.83062, popup = bar_p) %>% 
  addMarkers(lng = -4.552814,lat = 50.83347, popup = c_p) %>% 
  addMarkers(lng = -4.554378,lat = 50.83683, popup = c_beach_p) %>% 
  addMarkers(lng = -4.549855,lat = 50.83097, popup = s_beach_p) 

