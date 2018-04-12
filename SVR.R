setwd("C:/Users/HP/Desktop/thss")
dataset = read.csv("sentiment.csv")

library(e1071)

regressor = svm(formula = price ~ .,
                data = dataset,
                type = 'eps-regression')

y_predSVR = predict(poly_reg , data.frame(anger= 15 , anticipation= 46 , disgust = 2 , fear = 15 , joy = 29 , sadness = 8  , surprise = 14 , trust = 58, negative = 28 , positive = 100))

library(ggplot2)

ggplot()+
  
  geom_point(aes(x=dataset$positive , y = dataset$price),
             color = 'blue') +
  geom_line(aes(x= dataset$positive , y= predict(regressor , newdata = dataset)),
            color = 'green') +
  xlab('sentiments') +
  ylab('price')
