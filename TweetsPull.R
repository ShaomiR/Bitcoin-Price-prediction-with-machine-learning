setwd("C:/Users/HP/Desktop/thss")

library(twitteR)
library(ROAuth)
library(plyr)
library(dplyr)
library(stringr)
library(ggplot2)
library(httr)
library(wordcloud)
library(RCurl)
library(syuzhet)
library(tm)
library(sentimentr)
library(SentimentAnalysis)

oauth_endpoint(authorize = "https://api.twitter.com/oauth" , access = "https://api.twitter.com/oauth/access_token")

download.file(url = "http://curl.haxx.se/ca/cacert.pem" , destfile = "cacert.pem")
reqURL <- 'https://api.twitter.com/oauth/request_token'
accessURL <- 'https://api.twitter.com/oauth/access_token'
authURL <- 'https://api.twitter.com/oauth/authorize'

consumerKey = "D57e41bCCKX8AwILpQbj5GTmk"
consumerSecret = "RQ0ws6puGWKq7OQMJ8gqucKyl1FXYez7xhpC5Uj1WLoaEIwRJn"
accesstoken = "962001620727771136-1HaBpIqN6R4i9th7iXa30iZO3SfVACC"
accesssecret = "zZ6MkCGraJueoeuMeE9Yj7MxIbD6KREt3FRCvGVijXOLi"

Cred <- OAuthFactory$new(consumerKey = consumerKey , 
                         consumerSecret = consumerSecret , 
                         requestURL = reqURL , 
                         accessURL = accessURL, 
                         authURL = authURL)

Cred$handshake(cainfo = system.file('CurlSSL' , 'cacert.pem' , package = 'RCurl'))

save(Cred, file = 'twitter authentication.Rdata')

load('twitter authentication.Rdata')

setup_twitter_oauth(consumer_key = consumerKey , consumer_secret = consumerSecret , access_token = accesstoken , access_secret = accesssecret)

some_tweets = searchTwitter("cryptocurrency" ,n = 500 , since = "2018-03-17" , until="2018-03-18" , lang = "en" )

some_tweets

length.some_tweets <- length(some_tweets)
length.some_tweets

some_tweets.df <- ldply(some_tweets , function(t) t$toDataFrame())
write.csv(some_tweets.df , "rawtweetsmar17-18.csv")

some_txt = sapply(some_tweets, function(x) x$getText())

some_txt1 = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "",some_txt)

some_txt2 = gsub("http[^[:blank:]]+", "",some_txt1)

some_txt3 = gsub("@\\w+","",some_txt2)

some_txt4 = gsub("[[:punct:]]", " ",some_txt3)

some_txt5 = gsub("[^[:alnum:]]"," ",some_txt4)

write.csv(some_txt5, "tweetsmar17-18.csv")

some_txt6 <- Corpus(VectorSource(some_txt5))
some_txt6 <- tm_map(some_txt6, removePunctuation)
some_txt6 <- tm_map(some_txt6, content_transformer(tolower))
some_txt6 <- tm_map(some_txt6, removeWords, stopwords("english"))
some_txt6 <- tm_map(some_txt6, stripWhitespace)

pal <- brewer.pal(8, "Dark2")

wordcloud(some_txt6, min.freq = 5, max.words = Inf ,width=1000, height=1000, random.order = FALSE , color=pal)

get_nrc_sentiment("I bought an iPhone a few days ag0. It is such a nice phone, although a little large. The touch screen is cool. The voice quality is clear too. I simply love it!")

mysentiment <- get_nrc_sentiment(some_txt5)
SentimentScores <- data.frame(colSums(mysentiment[,]))
names(SentimentScores) <- "Score"
SentimentScores <- cbind("sentiment" = rownames(SentimentScores), SentimentScores)
rownames(SentimentScores) <- NULL
ggplot(data = SentimentScores, aes(x = sentiment, y= Score)) + geom_bar(aes(fill = sentiment),stat = "identity")+ theme(legend.position = "none")+ xlab("Sentiment")+ylab("Score")+ggtitle("Total Sentiment Score Based On Tweets")
write.csv(SentimentScores,"sentimar17-18.csv")

sentiment <-analyzeSentiment(some_txt5)
write.csv(convertToBinaryResponse(sentiment)$SentimentQDAP , "binarylabel.csv")

documents <- c(some_txt5)

sentimentnum <- analyzeSentiment(documents)

sentimentnum$SentimentQDAP



