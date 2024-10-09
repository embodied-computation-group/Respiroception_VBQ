library(tidyverse)
library(readr)
library(glmmTMB)
library(ggeffects)
library(patchwork)
library(sjPlot)
library(ggplot2)
library(patchwork)
library(ggthemes)


# ordered beta regression model predicting confidence slide data from trial level stimulus intensity, response accuracy, anxiety scores, and interactions. 

conf_fit <- glmmTMB(confidence ~ stimLevel * response + response * sticsa_gm_som  + response * sticsa_gm_cog + (1 |id),
                        data=filtered_data,
                        family=ordbeta(),
                        start=list(psi = c(0, 1)))

summary(conf_fit)

# create table and save results

tab_model(conf_fit, 
          pred.labels = c("Intercept", 
                          "Stim Level", 
                          "Response Correct", 
                          "Somatic Symptom", 
                          "Cognitive Symptom", 
                          "Stim Level × Response Correct", 
                          "Response Correct × Somatic Symptom", 
                          "Response Correct × Cognitive Symptom"),
          dv.labels = "Confidence", 
          file = "conf_model_results.doc")



# plot figure 
# Define the colorblind-friendly palette
#color_palette <- c("Correct" = "#0072B2", "Incorrect" = "#D55E00")
color_palette <- c("Correct" = "#008080", # Teal
                   "Incorrect" = "#CC7722") # Ochre (dark yellow)

# Define common y-axis limits
y_limits <- c(0.3, 0.8)

# Assuming you have already run the glmm_tmb_fit model

a <- plot_model(conf_fit, type = "pred", terms = c("stimLevel [all]", "response")) +  
  scale_color_manual(values = color_palette) + # Use colorblind-friendly palette
  labs(title = "Stimulus Intensity and Response Accuracy Interaction vs Confidence",
       x = "Stimulus Level (% Obstruction)",
       y = "Predicted Confidence Proportion", 
       color = "Response Accuracy") + # Update titles and labels
  theme_minimal(base_size = 12, base_family = "Helvetica") +
  #scale_x_continuous(trans = ~ . * 5.88235, labels = scales::percent_format(scale = 1)) + # Transform x-axis and display as percentage
  scale_x_continuous(limits = c(0,17),
                     breaks =c(0.0, 4.25, 8.5, 12.75, 17),
                     labels = function(x) scales::percent(x * 5.88235 / 100, accuracy = 1)) + # Transform x-axis and display as percentage
  theme(legend.position = c(.17, 0.8),
        #legend.direction = "horizontal",
        #plot.title = element_text(hjust = 0.5),
        legend.background = element_rect(fill = "white", color =NA),
        legend.text = element_text(size = 10),
        legend.title = element_text(size = 10),
        legend.margin = margin(2,2,2,2),
        axis.line = element_line(color = "black", linewidth = 0.8), # Add bold black axes
        axis.ticks = element_line(color = "black", linewidth = 0.8),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12))+
  guides(color = guide_legend(reverse = TRUE))#+
#xlim(0,1) 
#annotate("text", x = 10, y = 0.7, label = "p = 0.00327", size = 5, hjust = 1)

# Customize plot a with p-value annotation
b <- plot_model(conf_fit, type = "pred", terms = c("sticsa_gm_cog [all]", "response")) +
  scale_color_manual(values = color_palette) + # Use colorblind-friendly palette
  labs(title = "Cognitive Anxiety and Metacognition",
       x = "Cognitive Anxiety (STICSA Cog)",
       y = "Predicted Confidence Proportion") + # Update titles and labels
  theme_minimal(base_size = 12, base_family = "Helvetica") +
  theme(legend.position = "none",
        legend.title = element_blank(),  # Remove legend title
        legend.text = element_text(size = 12),  # Increase legend text size
        plot.title = element_text(hjust = 0.5),
        axis.line = element_line(color = "black", linewidth = 0.8), # Add bold black axes
        axis.ticks = element_line(color = "black", linewidth = 0.8),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12)) +
  ylim(y_limits) # Set consistent y-axis limits
# Customize plot b with p-value annotation
c <- plot_model(conf_fit, type = "pred", terms = c("sticsa_gm_som [all]", "response")) +
  scale_color_manual(values = color_palette) + # Use colorblind-friendly palette
  labs(title = "Somatic Anxiety and Metacognition",
       x = "Somatic Anxiety (STICSA Som)",
       y = "Predicted Confidence Proportion") + # Update titles and labels
  theme_minimal(base_size = 12, base_family = "Helvetica") +
  theme(legend.position = "none",
        legend.title = element_blank(),  # Remove legend title
        legend.text = element_text(size = 12),  # Increase legend text size
        plot.title = element_text(hjust = 0.5),
        axis.line = element_line(color = "black", linewidth = 0.8), # Add bold black axes
        axis.ticks = element_line(color = "black", linewidth = 0.8),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 12)) +
  ylim(y_limits) # Set consistent y-axis limits
# ylim(.3,.8) +
#annotate("text", x =10, y = 0.75, label = "p = 0.01022", size = 5, hjust = 1)

# Combine the plots with a unified legend
#combined_plot <- a + b + plot_layout(guides = 'collect') & theme(legend.position = "bottom")





combined_plot <-a/(b + c)+ plot_annotation(tag_levels = 'a', tag_suffix = '.') #+ plot_layout(guides = 'collect') 

print(combined_plot)

ggsave("figure4_submit.tiff", dpi = 300)











## binomial logistic regression on accuracy model

accuracy_fit <- glmmTMB(response ~ stimLevel*sticsa_gm_cog + stimLevel*sticsa_gm_som+ (1 |id),
                        data=filtered_data,
                        family=binomial(link="logit"))

summary(accuracy_fit)

plot_model(accuracy_fit, type = "eff", terms = c("stimLevel")) + theme_minimal()


## RT model
rt_fit <- glmmTMB(RT ~ stimLevel*response + sticsa_gm_som*response + sticsa_gm_cog*response + (1 |id),
                        data=filtered_data,
                        family=Gamma(link="log"))

summary(rt_fit)
plot_model(rt_fit, type = "pred", terms = c("stimLevel", "response")) + theme_minimal()

