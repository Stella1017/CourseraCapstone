GetNext <- function(vocin) {
  option <- c("", "", "", "")
  l <- length(vocin)
  for(i in 1:4) option[i] <- as.character(uni.dict[i,1])
  
  if(l <= 1) {
      voc <- paste("^", vocin, " ", sep="")
      ll <- length(grep(voc, bi.dict$Vocabulary))
      
      if(ll==0) {for(i in 1:4) option[i] <- as.character(uni.dict[i,1])}
      else if(ll>=4) {
        idx <- head(grep(voc, bi.dict$Vocabulary), 4)
        result <- bi.dict[idx, 4]
        for(i in 1:4) option[i] <- as.character(result[[i]][2])
      }
      else {
        idx <- head(grep(voc, bi.dict$Vocabulary), ll)
        result <- bi.dict[idx, 4]
        for(i in 1:ll) {option[i] <- as.character(result[[i]][2])}
      }
    }
    
  else if (l == 2) {
      phrase <- paste(vocin[l-1], vocin[l], sep=" ", collapse = " ")
      phrase <- paste("^", phrase, " ", sep="")
      ll <- length(grep(phrase, tri.dict$Vocabulary))
    
      if(ll > 4) {
        idx <- head(grep(phrase , tri.dict$Vocabulary), 4)
        result <- tri.dict[idx, 4]
        for(i in 1:4) option[i] <- as.character(result[[i]][3])
      }
      else if(ll %in% 1:4) {
        idx <- head(grep(phrase, tri.dict$Vocabulary), ll)
        result <- tri.dict[idx, 4]
        for(i in 1:ll) {option[i] <- as.character(result[[i]][3])}
      }
      else {
        phrase <- vocin[l]
        voc <- paste("^", phrase, " ", sep="")
        ll <- length(grep(voc, bi.dict$Vocabulary))
        
        if(ll>=4) {
          idx <- head(grep(voc, bi.dict$Vocabulary), 4)
          result <- bi.dict[idx, 4]
          for(i in 1:4) option[i] <- as.character(result[[i]][2])
        }
        else {
          idx <- head(grep(voc, bi.dict$Vocabulary), ll)
          result <- bi.dict[idx, 4]
          for(i in 1:ll) {option[i] <- as.character(result[[i]][2])}
        }
      }
  }
  
  else {
      phrase <- paste(vocin[l-2], vocin[l-1], vocin[l], sep=" ", collapse = " ")
      phrase <- paste("^", phrase, " ", sep="")
      ll <- length(grep(phrase, quad.dict$Vocabulary))
      
      if(ll >= 4) {
        idx <- head(grep(phrase , quad.dict$Vocabulary), 4)
        result <- quad.dict[idx, 4]
        for(i in 1:4) option[i] <- as.character(result[[i]][4])
      }
      
      else {
        idx <- head(grep(phrase , quad.dict$Vocabulary), ll)
        result <- quad.dict[idx, 4]
        if(ll !=0 ) {for(i in 1:ll) option[i] <- as.character(result[[i]][4])}
        x <- ll+1
        
        phrase <- paste(vocin[l-1], vocin[l], sep=" ", collapse = " ")
        phrase <- paste("^", phrase, " ", sep="")
        y <- length(x:4)
        ll <- length(grep(phrase, tri.dict$Vocabulary))
          
        if(ll >= y) {
          idx <- head(grep(phrase , tri.dict$Vocabulary), y)
          result <- tri.dict[idx, 4]
          for(i in x:4) option[i] <- as.character(result[[i-x+1]][3])
        }
        else if(ll < y) {
          idx <- head(grep(phrase, tri.dict$Vocabulary), ll)
          result <- tri.dict[idx, 4]
          if(ll !=0) {for(i in x:(x+ll-1)) option[i] <- as.character(result[[i-x+1]][3])}
            
          z <- (5-x-ll) #needs "z" more options            
          phrase <- vocin[l]
          voc <- paste("^", phrase, " ", sep="")
          ll <- length(grep(voc, bi.dict$Vocabulary))
            
          if(ll>=z) {
            idx <- head(grep(voc, bi.dict$Vocabulary), z)
            result <- bi.dict[idx, 4]              
            for(i in (5-z):4) option[i] <- as.character(result[[i+z-4]][2])
            }
          else {
            idx <- head(grep(voc, bi.dict$Vocabulary), ll)
            result <- bi.dict[idx, 4]
            if(ll!=0) {for(i in (5-z):ll) option[i] <- as.character(result[[i+z-4]][2])}
          }
        }
      }
    }
  option
}