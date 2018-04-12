setwd("C:/Users/HP/Desktop/thss")
dataset = read.csv("sentiment.csv")


library(randomForest)
set.seed(1234)
regressorRF = randomForest( x = dataset[1:10],
                            y = dataset$price,
                            ntree = 1000)

y_predRF = predict(regressorRF , data.frame(anger= 15 , anticipation= 50 , disgust = 10 , fear = 19 , joy = 23 , sadness =16 , surprise = 13 , trust = 58, negative = 29 , positive = 102))

library(ggplot2)

x_grid = seq(min(dataset$positive), max(dataset$positive),0.01)

ggplot()+
  
  geom_point(aes(x=dataset$positive , y = dataset$price),
             color = 'blue') +
  geom_line(aes(x= dataset$positive , y= predict(regressorRF , newdata = dataset)),
            color = 'green') +
  xlab('sentiments') +
  ylab('price')