setwd("C:/Users/HP/Desktop/thss")
dataset = read.csv("sentiment.csv")

library(rpart)

regressorDT = rpart(formula = price ~ .,
                    data = dataset,
                    control = rpart.control(minsplit = 1))

y_predDT = predict(regressorDT , data.frame(anger= 15 , anticipation= 50 , disgust = 10 , fear = 19 , joy = 23 , sadness =16 , surprise = 13 , trust = 58, negative = 29 , positive = 103))

library(ggplot2)

x_grid = seq(min(dataset$positive), max(dataset$positive),0.01)

ggplot()+
  
  geom_point(aes(x=dataset$positive , y = dataset$price),
             color = 'blue') +
  geom_line(aes(x= dataset$positive , y= predict(regressorDT , newdata = dataset)),
            color = 'green') +
  xlab('sentiments') +
  ylab('price')
