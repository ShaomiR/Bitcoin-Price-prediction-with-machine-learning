library(SentimentAnalysis)
sentiment <-analyzeSentiment("Shaomi Phones are cheap but effective")
convertToBinaryResponse(sentiment)$SentimentQDAP
