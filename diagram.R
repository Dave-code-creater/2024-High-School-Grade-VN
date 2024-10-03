library(ggplot2)

data <- read.csv("diem_thi_thpt_2024.csv")

graph <- function(dataset, name) {
  grade_counts <- table(dataset)
  
  grade_df <- as.data.frame(grade_counts)
  
  colnames(grade_df) <- c("Grade", "Count")
  
  p <- ggplot(grade_df, aes(x = Grade, y = Count)) +
    geom_col(aes(fill = Grade)) +
    scale_fill_viridis_d("Grade") +
    labs(
      x = name, 
      y = "Total Grades", 
      title = paste0("Total Grades by ", name)
    ) + 
    
    theme_classic()
  filepath <- file_path <- paste("graph/", name, ".png", sep = "")
  ggsave(
    filepath,   
    plot = p,     
    width = 12,   
    height = 6,    
    units = "in",  
    dpi = 300      
  )
}

for (x in 2:10){
  graph(data[, x], toString(colnames(data)[x]))
}
