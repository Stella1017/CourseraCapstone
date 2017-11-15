GetBestGuess <- function(voc, slct) {
  if (c("") %in% slct|c("^ $") %in% slct) best <- c("error: must have 4 choices")
  else {
  l <- length(voc)
    if(l < 2) best <- c("sentence is too short")
    else {
      p <- paste(voc[l-1], voc[l], sep=" ")
      p1 <- data.frame(slct = slct, x=1:4, y=0)
      for(i in 1:4) {
        p1$x[i] <- paste(p, slct[i], sep=" ")
        if(p1$x[i] %in% tri.dict$Vocabulary) p1$y[i] <- tri.dict[tri.dict$Vocabulary==p1$x[i], 3]
      }
  
      if(max(p1$y)==0) {
        p2 <- data.frame(slct=slct, x=1:4, y=0)
        for(i in 1:4) {
          p2$x[i] <- paste(voc[l], slct[i], sep=" ")
          if(p2$x[i] %in% bi.dict$Vocabulary) p2$y[i] <- bi.dict[bi.dict$Vocabulary==p2$x[i], 3]
        }
        if(max(p2$y)==0) {
          for(i in 1:4) p2$y[i] <- uni.dict[uni.dict$Vocabulary==slct[i], 3]
          best <- p2$slct[p2$y == max(p2$y)]
    }
    else best <- p2$slct[p2$y == max(p2$y)]
  }
  else best <- p1$slct[p1$y == max(p1$y)]
    }
  }
  as.character(best)
}