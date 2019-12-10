library(dplyr)
library(ggplot2)
library(caTools) 
library(ROCR) 
library(psych)
library(GPArotation)
library(reshape)

setwd("/Users/clairehe/Desktop")
orders_products<- read.csv('order_products__train.csv')
products <- read.csv('products.csv')

#merge the products with aisles and departments
tmp <- orders_products %>% group_by(product_id)
tmp <- tmp %>% left_join(products,by="product_id")

#take first 700 sample
id<-aggregate(department_id~order_id,data=tmp,FUN=length)
name<-id[1:700,]$order_id
departmentnum=data.frame(name,frozen=0,other=0,bakery=0,produce=0,alcohol=0,international=0,beverages=0,pets=0
,dry_goods=0,pasta=0,bulk=0,personal_care=0,meat_seafood=0,pantry=0,breakfast=0,canned_goods=0,dairy_eggs=0,household=0
,babies=0,snacks=0,deli=0,missing=0)

#merge department in one order
i<-1
j<-1
#DO NOT RUN THE FOR LOOP!
for(i in departmentnum$name){
  order <- tmp[tmp$order_id == i,]
  for(j in (1:21)){
  department <- tmp[tmp$department_id==j,]
  intersect(order, department)
  departmentnum[which(departmentnum$name == i),j+1]<-nrow(intersect(order, department))
  }
}

#Since running the for loop spends too much time, I have saved the table as RData.
load("data.RData")


#Factor analysis
cor(x=departmentnum[,2:22])

fit<-principal(r=departmentnum[,2:22], nfactors=21,rotate="none")
fit

scree(rx=departmentnum[,2:22],factor=FALSE)

#8 factors
fit <- principal(r=departmentnum[,2:22], nfactors=8,rotate="none")
fit

fit$loadings
fit$communality
fit$uniquenesses

fitr <- principal(r=departmentnum[,2:22],nfactors=8,rotate="varimax",method="regression")
fitr

#rotation matrix (permutated)
fitr$rot.mat[c(1,2,3,4,5,6,7),c(1,7,2,8,6,5,4,3)]

fit$loadings %*% fitr$rot.mat[c(1,2,3,4,5,6,7),c(1,7,2,8,6,5,4,3)]
fitr$loadings

#standardized values
head(scale(departmentnum[,2:22]))
#coefficients to calcualte the factor scores
fitr$weights
#factor scores
head(fitr$scores)

scores<-cbind(departmentnum["name"],fitr$scores)

#group means of factor scores
tb<-aggregate(.~name,data=scores,FUN=mean)
tb


#2-factor solution
fit <- principal(r=departmentnum[,2:22], nfactors=2,rotate="varimax")

#plot of factor loadings
ld<-data.frame(fit$loadings[,1:2])
ggplot(data=ld,aes(x=RC1,y=RC2))+
  geom_point()+
  geom_text(aes(label=rownames(ld),vjust=1))+
  geom_vline(aes(xintercept=0))+
  geom_hline(aes(yintercept=0))+
  coord_cartesian(xlim = c(-0.25,0.75),ylim=c(-0.25,0.75)) 


#means factor scores
sc<-data.frame(fit$scores,name=departmentnum$name)
tb<-aggregate(.~name,data=sc,FUN=mean)
#plot
ggplot(data=tb,aes(x=RC1,y=RC2))+
  geom_point()+
  geom_text(aes(label=name,vjust=1))+
  geom_vline(aes(xintercept=0))+
  geom_hline(aes(yintercept=0))


#6-cluster solution by Ward's method
dist<-dist(sc[1:2],method="euclidean")^2
fitc <- hclust(dist, method="ward.D")
sol <- cutree(fitc, k=6)
sol<-data.frame(sol,sc)
sol$sol<-factor(sol$sol)
ggplot(data=sol,aes(x=RC1,y=RC2,colour=sol))+
  geom_point(aes(shape=sol))+
  geom_vline(aes(xintercept=0))+
  geom_hline(aes(yintercept=0))











