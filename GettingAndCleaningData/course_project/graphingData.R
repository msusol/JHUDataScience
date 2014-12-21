## Note: interesting articles using this dataset

## https://rpubs.com/wangwf/19053  uses readData()
## http://rstudio-pubs-static.s3.amazonaws.com/10696_c676703d98c84553b9e3510b095153b9.html
## http://www.academia.edu/7619059/Human_Activity_Recognition_using_machine_learning

load("uciHarDataset.rda")
## The data comes to us partitioned by human subject with 9 subjects held out in test.
summary(data.train$subject)
## 1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
## 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 

summary(data.test$subject)
## 2   4   9  10  12  13  18  20  24 
## 302 317 288 294 320 327 364 354 381 

## Visualizations
library(ggplot2)
w = 720; h = 480
##png("plot1.png",width = w, height = )
qplot(data = data, x = subject, fill = Partition)
##dev.off()

##png("plot2.png",width = w, height = )
qplot(data = data, x = subject, fill = Activity)
##dev.off()