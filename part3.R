#part3 plots

#ggplot

dat_m1 <- melt(table_final, id.vars = "Text", measure.vars = c("Positive", "Negative"))

ggplot(data=dat_m1, aes(x=dat_m1$variable, y=dat_m1$value, colour=dat_m1$variable)) + 
	  geom_bar(stat="identity")

ggplot(data=dat_m1, aes(x=dat_m1$variable, y=dat_m1$value, colour=dat_m1$variable)) + 
		geom_line()


#Histogram

hist(table_final$Positive, col=rainbow(10), xlab="Positive", main="Histogram of Positive Sentiment")
hist(table_final$Negative, col=rainbow(10), xlab="Negative", main="Histogram of Negative Sentiment")
hist(table_final$Score, col=rainbow(10), xlab="Score", main="Histogram of Sentiment Score")

#Pie
Pslices <- c(sum(table_final$Positive), sum(table_final$Negative))


pie3D(Pslices, labels = c("Positive", "Negative"), col=rainbow(length(labels)), explode=0.00, main="Sentiment Analysis")
