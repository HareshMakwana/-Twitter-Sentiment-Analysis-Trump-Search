library(ROAuth)
library(twitteR)
library(stringr)
library(ggplot2)
library(reshape)
library(plyr)
library(plotrix)

#part1
#please add consumer key, consumer secret, access token, access secret below blanks "-----"

consumer_key <- "-----"
consumer_secret <- "-----"
access_token<- "-----"
access_secret <- "-----"

setup_twitter_oauth(consumer_key ,consumer_secret, access_token,  access_secret )
 
Tcred <- OAuthFactory$new(consumerKey='------', consumerSecret='------',
requestURL='https://api.twitter.com/oauth/request_token',
accessURL='https://api.twitter.com/oauth/access_token',
authURL='https://api.twitter.com/oauth/authorize')

Tcred$handshake(cainfo="cacert.pem")
