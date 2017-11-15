GetDict <-
function(vocabulary) {
    dict <- as.data.frame(xtabs(~vocabulary))
    colnames(dict) <- c("Vocabulary", "Freq")
    dict <- dict[order(dict$Freq, decreasing = T), ] # frequency sorted dictionary
    dict <- cbind(dict, pct = dict$Freq/length(vocabulary))
    rownames(dict) <- 1:length(dict$Vocabulary) #rename the rownames 
    return(dict)
}
