GetNext <- function(vocin) {
    option <- c("", "", "", "")
    l <- length(vocin)
    
    if(l >= 3) {
      phrase4 <- paste(vocin[l-2], vocin[l-1], vocin[l], sep=" ", collapse = " ")
      phrase4 <- paste("^", phrase4, " ", sep="")
      l4 <- length(grep(phrase4, quad.dict$Vocabulary)); l3<-0; l2<-0
      idx4 <- head(grep(phrase4, quad.dict$Vocabulary), l4)
      result4 <- quad.dict[idx4, 4]
      list4 <- c("", "", "", "");list3 <- c("", "", "", ""); list2 <- c("", "", "", "")
      if(l4 != 0) {for(i in 1:min(4,l4)) list4[i] <- result4[[i]][4]}
      if(l4 < 4) {
        phrase3 <- paste(vocin[l-1], vocin[l], sep=" ", collapse = " ")
        phrase3 <- paste("^", phrase3, " ", sep="")
        l3 <- length(grep(phrase3, tri.dict$Vocabulary))
        idx3 <- head(grep(phrase3, tri.dict$Vocabulary), l3)
        result3 <- tri.dict[idx3, 4]
        
        if(l3!=0) {for(i in 1:min(4,l3)) list3[i] <- result3[[i]][3]}
      
        phrase2 <- vocin[l]
        phrase2 <- paste("^", phrase2, " ", sep="")
        l2 <- length(grep(phrase2, bi.dict$Vocabulary))
        idx2 <- head(grep(phrase2, bi.dict$Vocabulary), l2)
        result2 <- bi.dict[idx2, 4]
        
        if(l2!=0) for(i in 1:min(4,l2)) list2[i] <- result2[[i]][2]
      }
      
      x <- sum(l2,l3,l4)
      ll <- c(list4, list3, list2); ll <- ll[ll!=""]

      i = 1; j = 1
      while (i <= 4 & j <= x) {
        if (ll[j] %in% option) j <- j+1          
        else {
          option[i] <- ll[j]
          i <- i+1; j <- j+1
        }
      }

      a <- 1; b <- sum(option!="")
      while(i>b & i<=4) {
        if(as.character(uni.dict[a,1]) %in% option) a <- a+1
        else {option[i] <- as.character(uni.dict[a,1]); a <- a+1; i <- i+1}
      }
    }
    
    else if(l == 2) {
      phrase3 <- paste(vocin[l-1], vocin[l], sep=" ", collapse = " ")
      phrase3 <- paste("^", phrase3, " ", sep="")
      l3 <- length(grep(phrase3, tri.dict$Vocabulary)); l2 <- 0
      idx3 <- head(grep(phrase3, tri.dict$Vocabulary), l3)
      result3 <- tri.dict[idx3, 4]
      list3 <- c("", "", "", ""); list2 <- c("", "", "", "")
      if(l3!=0) {for(i in 1:min(4,l3)) list3[i] <- result3[[i]][3]}
      
      if(l3 < 4) {
        phrase2 <- vocin[l]
        phrase2 <- paste("^", phrase2, " ", sep="")
        l2 <- length(grep(phrase2, bi.dict$Vocabulary))
        idx2 <- head(grep(phrase2, bi.dict$Vocabulary), l2)
        result2 <- bi.dict[idx2, 4]
        if(l2!=0) {for(i in 1:min(4,l2)) list2[i] <- result2[[i]][2]}
      }
      
      ll <- c(list3, list2);ll <- ll[ll != ""]
      x <- sum(l2,l3)        
      i = 1; j = 1
      while (i <= 4 & j <= x) {
        if (ll[j] %in% option) j <- j+1
        else {
          option[i] <- ll[j]
          i <- i+1; j <- j+1
        }
      }
      
      a <- 1; b <- sum(option!="")
      while(i>b & i<=4) {
        if(as.character(uni.dict[a,1]) %in% option) a <- a+1
        else {option[i] <- as.character(uni.dict[a,1]); a <- a+1; i <- i+1}
      }
    }
    
    else if(l == 1) {
      phrase2 <- vocin[l]
      phrase2 <- paste("^", phrase2, " ", sep="")
      l2 <- length(grep(phrase2, bi.dict$Vocabulary))
      idx2 <- head(grep(phrase2, bi.dict$Vocabulary), l2)
      result2 <- bi.dict[idx2, 4]
      if(l2!=0) {for(i in 1:min(4,l2)) option[i] <- result2[[i]][2]}
      if (l2 < 4) {
        a <- 1
        while(i > l2 & i <= 4) {
          if(as.character(uni.dict[a,1]) %in% option) a <- a+1
          else {option[i] <- as.character(uni.dict[a,1]); a <- a+1; i <- i+1}
        }
      }
    }
    
    else {for(i in 1:4) option[i] <- as.character(uni.dict[i,1])}
    option
}