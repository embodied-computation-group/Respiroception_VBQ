
combined_survey <- read.csv("surveys/combined_surveys.csv")


demodat <- combined_survey %>% 
  select(participant_id, age, gender, bmi) %>% 
  mutate(participant_id = as.numeric(gsub("sub-", "", participant_id)))

demodat <- rename(demodat, id = participant_id)

demodat$gender <- factor(demodat$gender, 
                         levels = c(1, 2), 
                         labels = c("Female", "Male"))


file_path <- "surveys/rrst_subset_trial_sticsa-wemwbs.csv"
rrst_data <- read.csv(file_path, na.strings = "NaN")

#rrst_data$id <- as.factor(rrst_data$id)
#rrst_data$trialN <- as.factor(rrst_data$trialN)
#rrst_data$blockN <- as.factor(rrst_data$blockN)
rrst_data$intero_order <- as.factor(rrst_data$intero_order)

# Merge the data frames
merged_data <- left_join(rrst_data, demodat, by = "id")
merged_data$id <- as.factor(merged_data$id)

# Rename and relevel the response variable in merged_data
merged_data$response <- factor(merged_data$response, 
                               levels = c(0, 1), 
                               labels = c("Incorrect", "Correct"))


# drop NAs
merged_data <- merged_data %>% 
  na.omit()

# Group by id and calculate the total trials, and count the 0 and 100 confidence responses, ignoring NA values
summary_data <- merged_data %>%
  group_by(id) %>%
  summarize(
    total_trials = n(),
    zero_confidence_count = sum(confidence == 0, na.rm = TRUE),
    hundred_confidence_count = sum(confidence == 100, na.rm = TRUE),
    zero_confidence_proportion = zero_confidence_count / total_trials,
    hundred_confidence_proportion = hundred_confidence_count / total_trials
  )

# Identify IDs with high 0 or 100 confidence ratings
high_prop_ids <- summary_data %>%
  filter(zero_confidence_proportion > 0.75 | hundred_confidence_proportion > 0.75) %>%
  pull(id)

#  Exclude these IDs from the original merged_data dataframe
filtered_data <- merged_data %>%
  filter(!(id %in% high_prop_ids))

# Step 4: Print the summary data frame
print(summary_data)

# Rescale the confidence variable from 0-100 to 0-1
filtered_data$confidence <- filtered_data$confidence / 100








## UNUSED ##

summary_df <- rrst_data %>%
  group_by(id) %>%
  summarise(number_of_trials = n())

#score_data <- read.csv("fa_score_data.csv")

score_data <- read.csv("pca_score_data.csv")

# Remove the prefix from participant_id in score_data and convert to numeric
score_data <- score_data %>%
  mutate(participant_id = as.numeric(gsub("sub-", "", participant_id)))

# Rename participant_id to id for merging
score_data <- rename(score_data, id = participant_id)

# Merge the data frames
merged_data <- left_join(rrst_data, score_data, by = "id")
merged_data <- left_join(merged_data, demodat, by = "id")
merged_data$id <- as.factor(merged_data$id)


# Rename and relevel the response variable in merged_data
merged_data$response <- factor(merged_data$response, 
                               levels = c(0, 1), 
                               labels = c("Incorrect", "Correct"))


# drop NAs
merged_data <- merged_data %>% 
  na.omit()



# Group by id and calculate the total trials, and count the 0 and 100 confidence responses, ignoring NA values
summary_data <- merged_data %>%
  group_by(id) %>%
  summarize(
    total_trials = n(),
    zero_confidence_count = sum(confidence == 0, na.rm = TRUE),
    hundred_confidence_count = sum(confidence == 100, na.rm = TRUE),
    zero_confidence_proportion = zero_confidence_count / total_trials,
    hundred_confidence_proportion = hundred_confidence_count / total_trials
  )


high_prop_ids <- summary_data %>%
  filter(zero_confidence_proportion > 0.75 | hundred_confidence_proportion > 0.75) %>%
  pull(id)

#  Exclude these IDs from the original merged_data dataframe
filtered_data <- merged_data %>%
  filter(!(id %in% high_prop_ids))

# Step 4: Print the summary data frame
print(summary_data)

# Rescale the confidence variable from 0-100 to 0-1
filtered_data$confidence <- filtered_data$confidence / 100