library(ggplot2)
library(dplyr)
library(tidyverse)
library(gridExtra)
library("gridExtra")
languages <- c("English", "Russian", "French", "Cantonese", "German", "Japanese", "Korean")
number_student_attend <- function(dataset) {
  student <- nrow(dataset)
  return(student)
}

avg_grade_subject <- function(dataset){
  grade <- mean(dataset,na.rm = T)
  return(grade)
}


english <- data.frame(read.csv('data/English.csv'))
russian <- data.frame(read.csv('data/Russian.csv'))
french <- data.frame(read.csv('data/French.csv'))
cantonese <- data.frame(read.csv('data/Cantonese.csv'))
german <- data.frame(read.csv('data/German.csv'))
japanese <- data.frame(read.csv('data/Japanese.csv'))
korean <- data.frame(read.csv('data/Korean.csv'))



languages <- list(
  "English" = english,
  "Russian" = russian,
  "French" = french,
  "Cantonese" = cantonese,
  "German" = german,
  "Japanese" = japanese,
  "Korean" = korean
)

df <- data.frame(
  Students = integer(),
  Math = numeric(),
  Literature = numeric(),
  ForeignLang = numeric(),
  Physics = numeric(),
  Chemistry = numeric(),
  Biology = numeric(),
  History = numeric(),
  Geography = numeric(),
  CivicEdu = numeric(),
  
  stringsAsFactors = FALSE
)


for (language in names(languages)) {
  dataset_language <- languages[[language]]
  
  student <- number_student_attend(dataset_language)
  math <- avg_grade_subject(dataset_language$toan)
  literature <- avg_grade_subject(dataset_language$ngu_van)
  foreign_languages <- avg_grade_subject(dataset_language$ngoai_ngu)
  physics <- avg_grade_subject(dataset_language$vat_li)
  chemistry <- avg_grade_subject(dataset_language$hoa_hoc)
  biology <- avg_grade_subject(dataset_language$sinh_hoc)
  history <- avg_grade_subject(dataset_language$lich_su)
  geography <- avg_grade_subject(dataset_language$dia_li)
  civic_education <- avg_grade_subject(dataset_language$gdcd)
  
  df[language, ] <- c(student, math, literature, foreign_languages, physics, chemistry, biology, history, geography, civic_education)
}



png("Grade Based Languages.png", height = 50*nrow(df), width = 200*ncol(df))
grid.table(df)
dev.off()