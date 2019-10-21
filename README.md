# Glocery-store-Marketing-Analytics
create a new product of grocery store providing its study design, and make according Marketing Analytic strategies
**Producing an online grocery app**

**• introduction**

***1). about our company***

We are a technology business enterprise aiming to place our products from multiregional retailer partners. As an online grocery shopping enterprise, we offer the lowest delivery fee as $3.9, with an annual fee of $99.9. Deliveries will be picked by our personal shoppers and will be delivered within one hour (for fresh market only) or up to five days in advance.
Our existing competitors on the market includes Amazon Fresh, Welcome, Shift, ParknShop ect. Different from these naming grocery stores, we use On-Demand and Schedule Ahead marketing strategies to provide customers with convenient deliveries. On-Demand allows shoppers to easily review and accept batches without planning ahead. With the introduction of Schedule Ahead, shoppers can pick up their delivery during unscheduled time. From the supplier side, since we do not need any Inventory/Warehouses, our marketing models offers less cost.


***2). Objectives of the study***

Due to the popularity of online shopping and the progress of logistics, online grocery will be more and more feasible in our daily life.

In order to produce an online grocery app, we are going to know about the product preference of our target users. From this anticipatory research, the profit will be maximized and the cost will be minimized.

By clustering the users, we can take accurate advertising of products and sales promotion. At the same time, it is significant for an online grocery to optimize the quantity and quality of product stock and make appropriate delivery strategies by achieving customers&#39; needs for products.

***3).Target population***

The users who are usually shopping online and have the ability to buy is our targeting object of study. Meanwhile, we focus on the target population from 15 to 55 years old.

• **Study design**

***1).Data source***

Kaggle provides us with several useful datasets from a similar online grocery _Instacart_. These datasets are related by products and describe customers&#39; orders over time. Because _Instacart_ and our app are the same type, we will directly use their dataset to analyze.

***2).Sampling method***

We will choose the simple random data sample from the dataset because the data is more than 1 million. Hence, using SQL to take data preprocessing and data sampling is necessary for us to get results quickly.

***3).Sample size***

Due to the original dataset has been classified by the day of the week and time of orders, we can take assumptions that we can achieve 700 weekly orders(about 100 orders per day). The sample size of our dataset will be 700.

***4).Variables in this marketing survey.***
According to dataset, variables we should consider include user-id, product-name, product-type, add-to-cart-orders, ordered-number, reordered-number, order-hour-of-day, and day-since-prior-order.

In order to accurately analyze customer preferences, we should think from two perspectives: the product properties and consumer behaviours.

From the property of the products themselves, customer preferences are largely determined by the product-type as well as product-function. Judging from the customers side, what, when and how many to purchase or repurchase are considered to be the largest influenceable factors, namely, variables including product-name, added-orders, ordered-number, reordered-number, order-hour-of-day, and day-since-prior-order.


***5).Statistical methods.***

Before we start the research, we will try to find a possible customer segmentation to classify customer according to their different purchases. After that, we will look for the best sellers of each cluster to help retailer to make decision over different products.

***•  Data processing***

This step will be done in MySQL. Each customer is identified by user\_id, for each user\_id, we will remove the null value and export certain number of prior orders to reduce the set of data (otherwise it will be too large to execute).

***•  Research Method***

***a) PCA***

Since there are thousands of products in the dataset, we will try to find some certain features to represent the categories of product. But the features may still be too much to do a cluster analysis. Hence, we are going to use Principal Component Analysis to reduce the dimensions. At the end, we hope to find an appropriate number of types of products with which the clustering will be easier. Since each feature is the projection of all the points of the original dataset, hence we can conclude that features obtained from PCA is representative of the dataset.

***b) Cluster analysis***

We will deal with several types of products and we are going to find possible clusters among different customers instead of single user\_id. One particular cluster algorithm, will be applied depends on the number of features that we obtained from PCA.

The first thing to do is to create a data frame which stores the user\_id and corresponding product features. We hope that after clustering, we will find possible clusters and be able to plot a nice graph of those clusters. Once we get the result, we will try to find the best sellers for each cluster (exclude the generic products, such as vegetables, water, milk, etc.). We believe that our results will be helpful for retailer to decide which products will be sold and maximize the revenue.
