rm(list = ls())

library(rvest)
library(dplyr)
library(tidyr)
library(stringr)
library(jsonlite)

table <- read_html("http://games.espn.go.com/ffl/schedule?leagueId=275298") %>%
  html_nodes("table.tableBody") %>%
  .[[1]] %>%
  html_table()

names(table) <- c("away_team", "away_owner", "at", "home_team", "home_owner", "result")

# Add "week" variable for each game
week <- 0
for (i in 1:nrow(table)) {
  away_team <- table[i,"away_team"]
  if (str_detect(away_team, "WEEK ")) { week <- week + 1 }
  table[i,"week"] <- week
}

table <- table %>%
  filter(!is.na(away_owner), away_team != "AWAY TEAM", result != "Preview") %>%
  select(-at) %>%
  mutate(away_score = (result %>% str_split("-") %>%
                          sapply(function(d) return(d[1]) %>% as.numeric)),
         home_score = (result %>% str_split("-") %>%
                          sapply(function(d) return(d[2]) %>% as.numeric))) %>%
  select(-result)

table_home <- table %>%
  rename(team = home_team, owner = home_owner, score = home_score,
         opponent_team = away_team, opponent_owner = away_owner, opponent_score = away_score) %>%
  mutate(home = TRUE)

table_away <- table %>%
  rename(team = away_team, owner = away_owner, score = away_score,
         opponent_team = home_team, opponent_owner = home_owner, opponent_score = home_score) %>%
  mutate(home = FALSE)

removeRecord <- function(team_name) {
  i <- team_name %>% str_locate("\\(") %>% .[,"start"]
  return(team_name %>%
    str_sub(start = 1, end = i-2))
}

table <- rbind(table_home, table_away) %>%
  mutate(team = removeRecord(team),
         opponent_team = removeRecord(opponent_team)) %>%
  select(-team, -opponent_team) # drop these; they're not used

write(toJSON(table), "data.json")
