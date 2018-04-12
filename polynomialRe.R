setwd("C:/Users/HP/Desktop/thss")
dataset = read.csv("sentiment.csv")
dataset$anger = dataset$anger^2
dataset$anticipation = dataset$anticipation^2
dataset$disgust = dataset$disgust^2
dataset$fear = dataset$fear^2
dataset$joy = dataset$joy^2
dataset$sadness = dataset$sadness^2
dataset$surprise = dataset$surprise^2
dataset$trust = dataset$trust^2
dataset$negative = dataset$negative^2
dataset$positive = dataset$positive^2

poly_reg = lm(formula = price ~ .,
              data = dataset)

library(ggplot2)

ggplot()+
  
  geom_point(aes(x=dataset$positive , y = dataset$price),
             color = 'blue') +
  geom_line(aes(x= dataset$positive , y= predict(poly_reg , newdata = dataset)),
            color = 'green') +
  xlab('sentiments') +
  ylab('price')

y_predPoly = predict(poly_reg , data.frame(anger= 225 , anticipation= 2500 , disgust = 100 , fear = 361 , joy = 529 , sadness =250 , surprise = 169 , trust = 3364, negative = 841 , positive = 10609))
