data <- read.csv("diem_thi_thpt_2024.csv")

original_levels <- c("N1", "N2", "N3", "N4", "N5", "N6", "N7", "Other")  

data$ma_ngoai_ngu <- factor(
  data$ma_ngoai_ngu,
  levels = original_levels,  
  labels = c("English", "Russian", "French", "Cantonese", "German", "Japanese", "Korean", "Other")
)

languages <- levels(data$ma_ngoai_ngu)


for (language in languages) {
  print(language)  
  subset_data <- data[!is.na(data$ma_ngoai_ngu) & data$ma_ngoai_ngu == language, ]
  file_path <- paste("data/", language, ".csv", sep = "")
  write.csv(subset_data, file = file_path, row.names = FALSE)  
}
df <- data |>
  group_by(ma_ngoai_ngu) |>
  count() |>
  ungroup() |>
  mutate(perc = `n` / sum(`n`)) |>
  arrange(perc) |>
  mutate(labels = scales::percent(perc))

ggplot(df, aes(x = "", y = perc, fill = ma_ngoai_ngu)) +
  geom_col() +
  geom_label(aes(label = labels), 
             color = "black",  
             position = position_stack(vjust = 0.5),  
             show.legend = FALSE,
             fill = alpha("white", 0.7),  
             label.size = 0) +
  coord_polar(theta = "y") +
  guides(fill = guide_legend(title = "Percentage of languages")) +
  scale_fill_viridis_d() +
  theme_void()
