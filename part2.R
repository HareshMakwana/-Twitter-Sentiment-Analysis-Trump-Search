#part2

pos.words = scan('D:/ML-sh/positive-words.txt', what='character', comment.char=';')
neg.words = scan('D:/ML-sh/negative-words.txt', what='character', comment.char=';')

#Adding other words to positive & negative databases
pos.words=c(pos.words, 'Congrats', 'thanks', 'thnx', 'Grt', 'gr8','leader')
neg.words = c(neg.words, 'fight', 'fighting', 'not')

srch.tweets=searchTwitter("trump", lang="en", n=1500, resultType="recent")
#srch.tweets=searchTwitter("trump", lang="en", n=15000, resultType="recent")

sample=NULL
for (tweet in srch.tweets)

sample = c(sample,tweet$getText())

df <- do.call("rbind", lapply(srch.tweets, as.data.frame))


df$text <- sapply(df$text,function(row) iconv(row, "latin1", "ASCII", sub=""))
df$text = gsub("(f|ht)tp(s?)://(.*)[.][a-z]+", "", df$text)

sample <- df$text

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
	require(plyr)
	require(stringr)
	list=lapply(sentences, function(sentence, pos.words, neg.words)
	{
		sentence = gsub('[[:punct:]]',' ',sentence)
		sentence = gsub('[[:cntrl:]]','',sentence)
		sentence = gsub('\\d+','',sentence)
		sentence = gsub('\n','',sentence)

		sentence = tolower(sentence)
		word.list = str_split(sentence, '\\s+')
		words = unlist(word.list)
		pos.matches = match(words, pos.words)
		neg.matches = match(words, neg.words)
		pos.matches = !is.na(pos.matches)
		neg.matches = !is.na(neg.matches)
		pp=sum(pos.matches)
		nn = sum(neg.matches)
		score = sum(pos.matches) - sum(neg.matches)
		list1=c(score, pp, nn)
		return (list1)
	}, pos.words, neg.words)

	score_new=lapply(list, `[[`, 1)
	pp1=score=lapply(list, `[[`, 2)
	nn1=score=lapply(list, `[[`, 3)

	scores.df = data.frame(score=score_new, text=sentences)
	positive.df = data.frame(Positive=pp1, text=sentences)
	negative.df = data.frame(Negative=nn1, text=sentences)

	list_df=list(scores.df, positive.df, negative.df)
	return(list_df)
}



result = score.sentiment(sample, pos.words, neg.words)


test1=result[[1]]
test2=result[[2]]
test3=result[[3]]


test1$text=NULL
test2$text=NULL
test3$text=NULL

q1=test1[1,]
q2=test2[1,]
q3=test3[1,]
qq1=melt(q1, ,var='Score')
qq2=melt(q2, ,var='Positive')
qq3=melt(q3, ,var='Negative')
 
qq1['Score'] = NULL
qq2['Positive'] = NULL
qq3['Negative'] = NULL


table1 = data.frame(Text=result[[1]]$text, Score=qq1)
table2 = data.frame(Text=result[[2]]$text, Score=qq2)
table3 = data.frame(Text=result[[3]]$text, Score=qq3)

table_final=data.frame(Text=table1$Text, Score=table1$value, Positive=table2$value, Negative=table3$value)
