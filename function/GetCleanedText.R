GetVoc <-
function(source, smpsize=1) {
    l <- length(source)
    smp <- sample(1:l, l * smpsize)
    s.smp <- source[smp] #get a random smaller sample
    s.smp <- tolower(s.smp)
    s.clean <- gsub("[^a-z']+", " ", s.smp) #remove all non-alphabetic characters, except for "'"
    s.clean <- gsub("'{2,}", "'", s.clean)
    s.clean <- gsub("' | '|' '", " ", s.clean) #remove "'" that are not between two letters
    s.clean <- gsub("^'|'$", "", s.clean) #remove "'" that are at the beginning or end of a sentence
    text <- paste(s.clean, collapse = " ") #make whole text in one string
    voc <- strsplit(text, split = " ")[[1]] #
    voc <- voc[voc != ""]
    return(voc)
}
