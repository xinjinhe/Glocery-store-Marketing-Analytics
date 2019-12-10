install.packages("psych")
library(psych)
library(reshape2)
library(ggplot2)

setwd("/Users/clairehe/Desktop")
customer<-read.csv("Mall_Customers.csv", header = TRUE)#standardize
#customer[,2:4]<-scale(customer[,2:4])
#customer[,2:4]
describe(customer[2:4],skew=F,ranges=F)

data<-read.csv("C:\\Users\\52357\\Desktop\\project\\Mall_Customers.csv", header = TRUE)
ggplot(data, aes( x = Age, fill = Gender)) + geom_density(alpha = 0.5)

##segmentation using age, income and spending score
#Elbow for K
data=customer[,c(2,4)]
wss=sapply(1:15,function(x){kmeans(data,x)$tot.withinss})
plot(1:15,wss,main="Elbow for K",xlab="K",ylab="Total Withinss",frame=FALSE,type="b")

#k-means method, 6-cluster solution
set.seed(123456)
#kmeans() K-means clustering
#x= data set
#centers= number of clusters/centers of clusters
#algorithm= K-means algorithm
# MacQueen's method the traditional method
fit1<-kmeans(x=customer[2:4],centers=6)
fit1


#cluster solution
fit1$cluster

tb<-fit1$centers

tb<-data.frame(cbind(tb,cluster=1:6))
tbm<-melt(tb,id.vars='cluster')
tbm$cluster<-factor(tbm$cluster)
ggplot(tbm, 
       aes(x = variable, y = value, group = cluster, colour = cluster)) + 
  geom_line(aes(linetype=cluster))+
  geom_point(aes(shape=cluster)) +
  geom_hline(yintercept=0) +
  labs(x=NULL,y="mean")


##segmentation using income and spending score

#Elbow for K
data=customer[,c(3,4)]
wss=sapply(1:15,function(x){kmeans(data,x)$tot.withinss})
plot(1:15,wss,main="Elbow for K",xlab="K",ylab="Total Withinss",frame=FALSE,type="b")

#k-means method, 5-cluster solution
set.seed(12345)
#kmeans() K-means clustering
#x= data set
#centers= number of clusters/centers of clusters
#algorithm= K-means algorithm
# MacQueen's method the traditional method
fit2<-kmeans(x=customer[3:4],centers=5)
fit2


#cluster solution
fit2$cluster

tb<-fit2$centers

tb<-data.frame(cbind(tb,cluster=1:5))
tbm<-melt(tb,id.vars='cluster')
tbm$cluster<-factor(tbm$cluster)
ggplot(tbm, 
       aes(x = variable, y = value, group = cluster, colour = cluster)) + 
  geom_line(aes(linetype=cluster))+
  geom_point(aes(shape=cluster)) +
  geom_hline(yintercept=0) +
  labs(x=NULL,y="mean")
# VISULIASE THE CLUSTERS
ggplot(customer[,3:4], aes(x = Annual.Income..k.., y = Spending.Score..1.100.)) + 
  geom_point(stat = "identity", aes(color = as.factor(fit2$cluster))) +
  scale_color_discrete(name=" ",
                       breaks=c("1", "2", "3", "4", "5"),
                       labels=c("Cluster 1", "Cluster 2", "Cluster 3", "Cluster 4", "Cluster 5")) +
  ggtitle("Segments using income and spending scores", subtitle = "K-means Clustering")