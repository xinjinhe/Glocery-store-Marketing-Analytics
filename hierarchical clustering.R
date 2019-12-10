library(psych)
library(ggplot2)
library(reshape2)
library(dplyr)
setwd("/Users/clairehe/Desktop")
customer_data<-read.csv("Mall_Customers.csv", header = TRUE)
head(customer_data)

describe(customer_data[3:5],skew=F,ranges=F)
#customer<-scale(customer_data[,3:5])
customer<-customer_data[3:5]
customer 

dist<-dist(customer,method="euclidean")^2
dist

#1). single linkage
fit <- hclust(dist, method="single")
history<-cbind(fit$merge,fit$height)
history

ggplot(mapping=aes(x=1:length(fit$height),y=fit$height))+
  geom_line()+
  geom_point()+
  labs(x="stage",y="height")
#dendrogram
plot(fit,labels=customer_data$CustomerID,hang=-1,sub="",xlab="",main="")
axis(side = 2, at = seq(0, 1200, 300))

#usingg cuttre method to cluster the sample into five groups
cluster<-cutree(fit,k=4)
sol <- data.frame(cluster,customer)
sol
tb<-aggregate(x=sol, by=list(cluster=sol$cluster),FUN=mean)
tb

tbm<-melt(tb,id.vars='cluster')
tbm$cluster<-factor(tbm$cluster)
ggplot(tbm, 
       aes(x = variable, y = value, group = cluster, colour = cluster)) + 
  geom_line(aes(linetype=cluster))+
  geom_point(aes(shape=cluster)) +
  geom_hline(yintercept=0) +
  labs(x=NULL,y="mean")

#2). wards method
fit <- hclust(dist, method="ward.D")
history<-cbind(fit$merge,fit$height)
history

ggplot(mapping=aes(x=1:length(fit$height),y=fit$height))+
  geom_line()+
  geom_point()+
  labs(x="stage",y="height")

par(mar=c(1,4,1,1))
plot(fit,hang=-1,main="")

cluster<-cutree(fit,k=5)
sol <- data.frame(cluster,customer)
sol
tb<-aggregate(x=sol, by=list(cluster=sol$cluster),FUN=mean)
tb

tbm<-melt(tb,id.vars='cluster')
tbm$cluster<-factor(tbm$cluster)
ggplot(tbm, 
       aes(x = variable, y = value, group = cluster, colour = cluster)) + 
  geom_line(aes(linetype=cluster))+
  geom_point(aes(shape=cluster)) +
  geom_hline(yintercept=0) +
  labs(x=NULL,y="mean")


