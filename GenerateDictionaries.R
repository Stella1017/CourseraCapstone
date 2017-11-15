setwd("~/Google Drive/Coursera-DataScience/Capstone Project/final/en_US/")
con.twt <- file("en_US.twitter.txt", "r"); twt <- readLines(con.twt); close(con.twt)
con.news <- file("en_US.news.txt","r"); news <- readLines(con.news); close(con.news)
con.blogs <- file("en_US.blogs.txt", "r"); blogs <- readLines(con.blogs); close(con.blogs)
rm(con.twt); rm(con.news); rm(con.blogs)

set.seed(1101)
index.test <- sample(1:length(blogs),270000) #30% of length of Blogs
train.twt <- twt[-index.test]
train.news <- news[-index.test]
train.blogs <- blogs[-index.test]

test.twt <- twt[index.test]
test.news <- news[index.test]
test.blogs <- blogs[index.test]

source(file="GetCleanedText.R")
source(file="GetDictionary.R")

voc.twt <- GetVoc(train.twt, smpsize = 0.05)
voc.news <- GetVoc(train.news, smpsize = 0.05)
voc.blogs <- GetVoc(train.blogs, smpsize = 0.05)
voc.twt.test <- GetVoc(test.twt, smpsize = 0.1)
voc.news.test <- GetVoc(test.news, smpsize = 0.1)
voc.blogs.test <- GetVoc(test.blogs, smpsize = 0.1)
voc.train <- c(voc.twt, voc.news, voc.blogs)
voc.test <- c(voc.blogs.test, voc.news.test, voc.twt.test)

uni.train <- GetDict(voc.train)
uni.test <- GetDict(voc.test)

bi.cor.train <- vapply(ngrams(voc.train, 2), paste, "", collapse = " ") 
bi.train <- GetDict(bi.cor.train)
bi.cor.test <- vapply(ngrams(voc.test, 2), paste, "", collapse = " ") 
bi.test <- GetDict(bi.cor.test)

tri.cor.train <- vapply(ngrams(voc.train, 3), paste, "", collapse = " ") 
tri.train <- GetDict(tri.cor.train)
tri.cor.test <- vapply(ngrams(voc.test, 3), paste, "", collapse = " ")
tri.test <- GetDict(tri.cor.test)

quad.cor.train <- vapply(ngrams(voc.train, 4), paste, "", collapse = " ")
quad.train <- GetDict(quad.cor.train)

uni.dict <- uni.train[1:1000, ] #top 1000, cover 71%
bi.dict <- bi.train[1:177556, ] #all the instances that appeared more than twice, cover 66%
tri.dict <- tri.train[1:278900, ] #all the instances that appeared more than once, cover 31%
quad.dict <- quad.train[1:107105, ] #all the instances that appeared more than once, only cover 8.4%

bi.dict$element <- strsplit(as.character(bi.dict$Vocabulary), split=" ")
tri.dict$element <- strsplit(as.character(tri.dict$Vocabulary), split=" ")
quad.dict$element <- strsplit(as.character(quad.dict$Vocabulary), split=" ")

save(uni.dict, file="unigram.RData")
save(bi.dict, file="bigrams.RData")
save(tri.dict, file="trigrams.RData")
save(quad.dict, file="quadgrams.RData")
