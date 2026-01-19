#Step 1 download the dataset from GitHub to your laptop 

#Step 2 --> make sure to set you workinng directory
#setwd("~/Desktop/Assignment/Cleaned CSV Files")

#Step 2 import the dataset into RStudio
library(tidyverse)
library(ggplot2)
dataset_songs<-read.csv("dataset_songs.csv")

nrow(dataset_songs) #this checks the number of rows: total row of 15635 

#Now it is time to create the  composite visualisations
#Step 3: creating a line graph for average artist popularity across artist types between 2008-2018
library(dplyr)
library(ggplot2)

# 3.1: Filter years to specific for 2008-2018 and also calculate the average popularity score for each year 
timeline_data <- dataset_songs %>%
  filter(year >= 2000 & year <= 2018) %>%
  group_by(year, artist_type) %>%
  summarise(mean_pop = mean(popularity.y, na.rm = TRUE), .groups = 'drop') %>%
  filter(!is.na(artist_type))

# 3.2: Create the line graph 
ggplot(timeline_data, aes(x = year, y = mean_pop, color = artist_type)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  scale_x_continuous(breaks = seq(2000, 2018, 2)) + # Makes the x-axis clean
  theme_minimal() +
  labs(title = "Average Artist Popularity Score across Artist Type (2000-2018)",
       x = "Year",
       y = "Average Popularity Score",
       color = "Artist Type") +
  scale_color_viridis_d()
#end of graph visualisation for graph 1: theoretical framework

#Step 4: creating heatmap for average popularity score across top 5 genres between 2008-2018
install.packages("viridis") # this is a colourblind friendly colour palette (it is a blue to yellow)
library(viridis) 
library(dplyr)
library(ggplot2)
#4.1: Need to filter years so that heatmap only has 2008-2018. 
subset_data_heat <- dataset_songs %>%
  filter(year >= 2008 & year <= 2018)

#4.2: Now need to filter so only the Top 10 genres JUST for those years (2008-2018)
top_5_genres_era <- subset_data_heat%>%
  count(main_genre, sort = TRUE) %>%
  top_n(5, n) %>%
  pull(main_genre)

#4.3. Need to create a sub dataset that only includes necessary data for the heatmap (thats the top 5 genre and 2008-2018)
heatmap_data <- subset_data_heat %>%
  filter(main_genre %in% top_5_genres_era) %>%
  group_by(main_genre, year) %>%
  summarise(avg_popularity = mean(popularity.y, na.rm = TRUE))

# 4. Now the heatmap can be plotted using that subset dataset and colourblind friendly palette 

ggplot(heatmap_data, aes(x = factor(year), y = main_genre, fill = avg_popularity)) +
  geom_tile() + 
  geom_text(aes(label = round(avg_popularity, 1)), color = "white", size = 3) + #here I have added the average popularity scores in white
  scale_fill_viridis(option = "viridis",
                     name = "Average\nPopularity Score") + 
  theme_minimal() +
  labs(
    title = "Average Artist Popularity Score Across the Top Five Genres (2008–2018)",
    subtitle = "Yearly average popularity calculated for each genre",
    x = "Year", 
    y = "Top 5 Main Genres"
  ) +
  theme(
    panel.grid = element_blank(), # this ensures that the graph has a white background rather than grey lines
    axis.text.x = element_text(angle = 45, hjust = 1), # x axis years are titled 
    plot.title = element_text(face = "bold", size = 14)
  )
#end of graph 2 for accessibility

#Step 5: Creating a boxplot for populairty score and explicitness of songs
library(ggplot2)
library(scales)

#MAIN GRAPH
# 5.1. Need to transform variables:
#5.1 a) Convert popularity to numeric 
#5.2 b) explicit(TRUE/FALSE to EXPLICIT/NON EXPLICIT)
dataset_songs <- dataset_songs %>%
  mutate(
    popularity.y = as.numeric(as.character(popularity.y)), # this ensures that it recognises popularity as a numeric variable
    explicit_transformed = ifelse(explicit == TRUE, "Explicit", "Non-Explicit")
  ) %>%
  filter(!is.na(popularity.y)) # although data was cleaned this step is to just ensure that all missing data is removed so summary: removes any rows that couldn't be converted


ggplot(dataset_songs, aes(x = explicit_transformed, y = popularity.y, fill = explicit)) +
  geom_boxplot(alpha = 0.7, outlier.size = 1) +  coord_flip()+
  
  # This adds the actual average number onto the graph
  stat_summary(fun = mean, geom = "label", aes(label = after_stat(round(y, 1))), 
               fill = "white", fontface = "bold", vjust = -0.5) +
  
  # Keep your original scale and labels
  scale_y_continuous(labels = label_comma()) + 
  scale_fill_manual(values = c("FALSE" = "black", "TRUE" = "#2ECC71"),
                    labels = c("Non-Explicit", "Explicit")) +
  theme_minimal() +
  labs(title = "Distribution of Artist Popularity Score by Explicitness",
       subtitle = "Average scores displayed as white labels",
       x = "Song Type", 
       y = "Artist Popularity Score",
       fill = "Is Explicit?") +   theme(
         plot.title = element_text(face = "bold", size = 14)
       ) #makes the main title bold
#END OF graph 3: Visualisation Choice

#Step 6: Creating a scatterplot for followers and artist popularity

library(ggplot2)
library(scales)
library(dplyr)

# 6.1: again need to create a subset and clean the data so variables are readable in the dataset
scatter_data <- dataset_songs %>%
  # this ensure that followers variable is coded as numeric and removes any missing data (NA)
  mutate(followers = as.numeric(followers)) %>%
  filter(!is.na(followers))

# 6.2: Now it is time to plot the variables onto the scatterplot 
ggplot(scatter_data, aes(x = followers, y = popularity.y)) +
  geom_point(alpha = 0.2, color = "black") + 
  geom_smooth(method = "lm", color = "red") +
  scale_x_log10(
    breaks = c(100, 1000, 10000, 100000, 1000000, 10000000), #this helps transform the x axis so that it goes up in 100s to see follower count
    labels = scales::comma_format()
  ) +
  theme_minimal() +
  labs(
    title = "Exploring the relationship between Artist Popularity Score and Follower Count",
    x = "Number of Followers (Log Scale)", 
    y = "Artist Popularity Score"
  )


