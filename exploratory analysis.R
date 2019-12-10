library(dplyr)
library(ggplot2)
library(caTools) 
library(ROCR) 
library(psych)

setwd("/Users/clairehe/Desktop")
orders <- read.csv('orders.csv')
orders_products<- read.csv('order_products__train.csv')
products <- read.csv('products.csv')

#1.About orders
#get the training data of orders
dataset=split(orders,list(orders$eval_set))
train=dataset$`train`

#summary statistic
describe(train)
#hours of day
ggplot(data=train,aes(x=order_hour_of_day)) + 
  geom_histogram(stat="count")

#day of week
ggplot(data=train,aes(x=order_dow)) + 
  geom_histogram(stat="count")

#day 0:Sunday most
#When do they order again
ggplot(data=train,aes(x=days_since_prior_order)) + 
  geom_histogram(stat="count")


#2.About products
#summary statistic
describe(orders_products)
#How many items do people buy?
orders_products %>% 
  group_by(order_id) %>% 
  summarize(n_items = last(add_to_cart_order)) %>%
  ggplot(aes(x=n_items))+
  geom_histogram(stat="count") + 
  geom_rug()+
  coord_cartesian(xlim=c(0,80))

#bestseller
tmp <- orders_products %>% 
  group_by(product_id) %>% 
  summarize(count = n()) %>% 
  top_n(10, wt = count) %>%
  left_join(select(products,product_id,product_name),by="product_id") %>%
  arrange(desc(count)) 
tmp %>% 
  ggplot(aes(x=reorder(product_name,-count), y=count))+
  geom_bar(stat="identity")+
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())

#reorder probability
table(orders_products$reordered)



#reorder product
tmp <-orders_products %>% 
  group_by(product_id) %>% 
  summarize(proportion_reordered = mean(reordered), n=n()) %>% 
  filter(n>40) %>% 
  top_n(10,wt=proportion_reordered) %>% 
  arrange(desc(proportion_reordered)) %>% 
  left_join(products,by="product_id")

tmp %>% 
  ggplot(aes(x=reorder(product_name,-proportion_reordered), y=proportion_reordered))+
  geom_bar(stat="identity")+
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())+coord_cartesian(ylim=c(0.85,0.95))

#first item
tmp <- orders_products %>% 
  group_by(product_id, add_to_cart_order) %>% 
  summarize(count = n()) %>% mutate(pct=count/sum(count)) %>% 
  filter(add_to_cart_order == 1, count>10) %>% 
  arrange(desc(pct)) %>% 
  left_join(products,by="product_id") %>% 
  select(product_name, pct, count) %>% 
  ungroup() %>% 
  top_n(10, wt=pct)
tmp %>% 
  ggplot(aes(x=reorder(product_name,-pct), y=pct))+
  geom_bar(stat="identity")+
  theme(axis.text.x=element_text(angle=90, hjust=1),axis.title.x = element_blank())+coord_cartesian(ylim=c(0.4,0.7))
