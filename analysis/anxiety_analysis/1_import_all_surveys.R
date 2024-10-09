# Define the directory containing the survey files
survey_dir <- "~/surveys/"

# List of survey files
survey_files <- list.files(survey_dir, pattern = "\\.tsv$", full.names = TRUE)

# Function to read each survey file and remove unnecessary columns
read_survey <- function(file) {
  survey_data <- read.delim(file, header = TRUE, sep = "\t", stringsAsFactors = FALSE, na.strings = "n/a")
  survey_data <- survey_data %>%
    select(-task, -id)  # Remove task and cohort columns
  return(survey_data)
}

# Read and process each survey file
survey_list <- lapply(survey_files, read_survey)

# Merge all data frames by 'participant_id'
combined_survey <- Reduce(function(x, y) full_join(x, y, by = c("participant_id","cohort")), survey_list)

write.csv(combined_survey, "combined_surveys.csv")


# View the first few rows
head(data)