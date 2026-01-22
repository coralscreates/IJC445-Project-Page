# IJC445 Project Page 📚
IJC445: Data Visualisation Coursework Overview and Code

## 🎶Project: Exploring the different characteristics that influence artist popularity.
### 🎵Background context 
Artist popularity is often defined by an artist's success across different demensions such as, chart performance and sales. Investigating artist popularity is desirable within the music industry, benefiting key stakeholders and artists. Therefore, investigating the  characteristics that influence artist popularity can help understand the factors that contributes to an artist's success.
### 🔍What variables were explored 
**Dependent Variable**

- Artist Popularity Score

**Independent Variables**
  - Artist type
  - Top 5 Genres
  - Explicitness of songs
  - Spotify Follower Count
### 📊What graphs were used 
- ***Line graph***: To explore average popualirty score of artist types between 2000-2018
    - library(tidyverse)
    - library(ggplot2)
    - library(dplyr)
- ***Heatmap***: To explore avaerage populairty score of Top 5 Genres between 2008-2018
    - library(dplyr)
    - library(viridis)
    - library(ggplot2)
- ***Boxplot***: To explore the distribution of popualirty scores across Explicitness
    - library(scales)
    - library(ggplot2)
- ***Scatterplot***: To explore the relationship between Artist Popularity and Follower Count
    - library(dplyr)
    - library(scales)
    - library(ggplot2)
 
### ⭐️Key findings
1. Line graph demonstrated that rappers consistently mainted high popularity scores with moedate variation, bands and singers experienced a steady trend over time. Whereas DJs and duo experience more variation in popularity over time.
2. Heatmap demonstrated that there was an overall increase in artist popularity over the years, with pop having highest scores and alt hiphop experiencing significant increase in popularity over years
3. Boxplot demonstrated that artists with explicit songs tend to have higher populairty scores than those with non-explicit songs.
4. Scatterplot suggests a strong positive relationship between artist popularity score and follower count
## 📄Respository Structure
- **dataset_songs.csv**: Cleaned and Merged dataset
- **IJC445 R code.r**: The R code you should download and run following steps
  
## 🌟How to Run Code
1. Download the **dataset_songs.csv** document to your laptop
2. Download the **IJC445 R code.r** file and open it in RStudio
3. Import the **dataset_songs.csv** document using read.csv (as shown in Step 2)
4. Follow the steps provided in the R script 
