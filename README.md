**Producing an online grocery app**



1. **Introduction**

    * Rationale

Due to the popularity of online shopping and the progress of logistics, online grocery will be more and more feasible in our daily life. 

    * Objectives of the study

In order to produce an online grocery app, we are going to know about the product preference of our target users. From this anticipatory research, the profit will be maximized and the cost will be minimized. 

By clustering the users, we can take accurate advertising of products and sales promotion. At the same time, it is significant for an online grocery to optimize the quantity and quality of product stock and make appropriate delivery strategies by achieving customers’ need of products.

2. **Methods**

    * Target population

The users who are usually shopping online and have the ability to buy is our targeting object of study. Meanwhile, we focus on the target population from 18 to 70 years old.

    * Data source

Kaggle provides us with several useful datasets from a similar online grocery *Instacart*. One dataset is about customer characteristics. And the other datasets are related to products and describe customers’ orders over time. Because *Instacart *and our app are the same type, we will directly use their dataset to analyze.

    * Sampling method

The original training dataset is collected from random sampling. Since this dataset has been classified by the day of the week and time of orders, we can make assumptions that we can achieve 700 weekly orders(about 100 orders per day) before we did factor analysis.

    * Data structure and variables of interest

We have four main datasets to do analysis.

1.  Mall_Customers: CustomerID, Gender, Age, Annual Income($k), Spending Score(1-100 reflects customers’ consumption level)

2. Orders: order_id, user_id, order_number, order_dow(day of week), order_hour(hours of day), days_since_prior_order

3. We merged datasets Order_products_train(information about products in orders) and Products(products’ information). Finally, we got the training datasets with order_id, product_id, product_name, aisle_id, department_id, add_to_cart_order, reordered(0 or 1).

    * Statistical methods

1. Order exploratory analysis

In order to have initial understandings of the data, we did simple exploratory analyses on the day of the week, hours of the day and reorder time. The results are shown by the dendrogram.

2. Product exploratory analysis

Similarly, we did simple exploratory analyses on items in one order by last add_to_cart_order, bestseller, and reorder probability. The results are also shown by the dendrogram.

3. Factor analysis

After making a new dataset with department components in orders, we did factor analysis. We tried to find certain features by continuous variables to represent the categories of products. Since each feature is the projection of all the points of the original dataset, hence we can conclude that features obtained from PCA are representative of the dataset.

4. Customer exploratory analysis and Cluster analysis

In this part, customer data will be divided into groups of individuals that are similar in age, annual income or spending score. A deeper understanding of our target population and  customer’s preferences can be obtained after clustering analysis.

3. **Results**

**1. **Orders exploratory analysis

* Summary statistics 

![image alt text](image_0.png)

*  Order hours of the day

![image alt text](image_1.png)

People always place orders between 8 a.m. and 9 p.m.

* Order day of week

![image alt text](image_2.png)

Most of the people place orders on Sunday.

 

*   When do customers order again?

![image alt text](image_3.png)

Some people prefer to do online shopping each week. But most of the people prefer to place an order again after one month.

 

**2.** Products exploratory analysis

* Summary statistics

![image alt text](image_4.png)

*  How many items do people buy in one order?

![image alt text](image_5.png)

People always buy approximately 5 items once.

*  Bestseller

![image alt text](image_6.png)

As is shown in the picture, Banana is the bestseller. Since fruits and vegetables are customers’ daily needs, the top 10 bestsellers are all fruit and vegetables.

 

* Reorder probability

828824/(555793+828824)≈0.5985944

More than half of the products will be reordered.

 

**3.   **Product factor analysis

![image alt text](image_7.png)

The 1st 8 factors explained 54% of the total variance.

8 factors are suggested.

 

Latent root criteria:

Eigenvalues for the 8th factor > 1 while that of 9th factors are <1

8 factors are suggested.

 ![image alt text](image_8.png)

Scree plot shows the eigenvalue for the number of factors.:

An elbow is observed at 3

2 factors are suggested.

8 factors solution:

![image alt text](image_9.png)

Factor 1: produce, bakery, canned goods, personal care, meat seafood, breakfast load highly and positively

Factor 2: Bulk, dairy eggs, babies load highly and positively

Factor 3: Other, alcohol load highly and positively

Factor 4: pasta

Factor 5: Pantry

Factor 6: Snacks, deli

Factor 7: Frozen, beverage, pets, household

Factor 8: International, dry goods

2 factors solution:

Rotated loadings

![image alt text](image_10.png)

Pasta, other, alcohol and household are correlated

Dairy eggs, bulk, pets, beverages, and babies are correlated 

Pantry, deli, international and personal care are correlated

Breakfast, snacks, dry goods, meat seafood, canned goods, bakery, produce are correlated

Frozen on its own

 

6 cluster solution on factor scores (including no strong characteristic)

![image alt text](image_11.png)

**4. **Customer segmentation cluster analysis

* Exploratory analysis

Summary Statistic:

![image alt text](image_12.png)

 Frequency of gender:

 ![image alt text](image_13.png)

The majority of customers is female.

Age variable distribution:

![image alt text](image_14.png)

It is clear that the target age groups are 30-35 for both female and male. Women in their 40s do online shopping frequently.

* Hierarchical cluster analysis 

**(Single linkage method)**

* To determine the number of clusters (using graphs)

* Plot a distance of concern at each stage; Plot the according dendrogram

* There is a jump from 4-cluster solution to 3-cluster solution 

* We choose 4 clusters

![image alt text](image_15.png)![image alt text](image_16.png)

* Cluster solutions:

    * Assuming 4 clusters

    * We derive the  number of trials in cluster C1-C5 to be: 159, 38, 2,1; 

    * Means and standardized values for the five clustered analysis:

![image alt text](image_17.png)

* Finally, we plot out the values under different clusters to intuitively visualize the result:

![image alt text](image_18.png)

**(Ward’s method)**

* Determine number of clusters through plotting:

* Plot of distance at each stage

* Plot of dendrogram 

![image alt text](image_19.png)![image alt text](image_20.png)

* Cluster solution:

* We choose 5 clusters

* We derive the number of trials in cluster C1-C5 is: 23, 20, 84, 38, 35;

![image alt text](image_21.png)

* Means and standardized values for the five clustered analysis: 

![image alt text](image_22.png)

* Finally, we plot out the values under different clusters to intuitively visualize the result:

![image alt text](image_23.png)

* Conclusions on hierarchical cluster analysis:

* Single linkage tends to form large clusters; Ward’s method tends to form smaller and more precise clusters;

* Result from Ward’s method analysis: 

    * C1: population that is middle-aged with low income and small spending score;

    * C2: population with young age, small annual income but large spending score; 

    * C3: population with middle age relatively high income and relatively high spending soore;

    * C4: population with young age, high average income and high spending score;

    * C5: population with middle age, high income but low spending score;

**(K-means cluster analysis) **

The K-means algorithm involves:

1. 	Choosing the number of cluster (best K for K-means).

2. 	Cluster each point randomly, compute the cluster centroid, reassign each data point to the cluster which has the closest centroid to this data point.

3. 	Repeat this process until no change will be settled.

In order to fully investigate the customers’ preference, two kinds of customer segmentation will be considered:

i) Segmentation using age, income and spending score

In order to find the best K for K-means algorithm, elbow method is applied.

![image alt text](image_24.png)

Elbow is bending at k=6. Therefore, k = 6 is the best number for K-means in this case.

 ![image alt text](image_25.png)

6-cluster solution

![image alt text](image_26.png)

6-cluster solution 2

This plot shows the characteristic of each cluster. A sensible interpretation for the customer segmentation can be made based on this result:

Cluster 1. Customers with middle age, lower income and lower spending score.

Cluster 2. Customers with young age, lower income and high spending score.

Cluster 3. Customers with middle age, higher income and lowest spending score.

Cluster 4. Customers with young age, medium income and high spending score.

Cluster 5. Customers with young age, highest income and high spending score.

Cluster 6. Customers with middle age, medium income and medium spending score.

ii) Segmentation using income and spending score.

In order to find the best K for K-means algorithm, elbow method is applied.![image alt text](image_27.png)

Elbow is bending at k=5. Therefore, k = 5 is the best number for K-means in this case.

 

![image alt text](image_28.png)

5-cluster solution

 ![image alt text](image_29.png)

5-cluster solution

![image alt text](image_30.png)

5-cluster solution

These plots show the characteristic of each cluster. A sensible interpretation for the customer segmentation can be made based on this result:

 

Cluster 1. Customers with medium income and medium spending score.

Cluster 2. Customers with high income and high spending score.

Cluster 3. Customers with low income and high spending score.

Cluster 4. Customers with low income and low spending score.

Cluster 5. Customers with high income and low spending score.

4. **Conclusion**

1.  We are supposed to stock on Tuesday, Wednesday or Thursday since orders these days are less than other days (except fresh food includes fruits, vegetables, etc. should be stocked every day). Meanwhile, the stocking time should between 0 a.m. to 6 a.m.

2. Since most of the people prefer to place orders once a month, we can take sales promotion on each week to change customers’ online shopping habits and attract them to buy more times in one month than before.

3. More than half of customers will reorder the products. So we can target on the regular customer.

4. From a business perspective, our app should focus on young and middle age women as  particular target group so as to provide the best experience for them. We can also make better marketing strategy based on the understanding of customers’ preference. For example, there is a group of customers with high income but low spending score. In order to boost demand and stimulate consumption, company may take them into account and construct a target marketing approach to fit their interest. In the cluster analysis of this report, we only use 2 or 3 variables due to simplicity of the dataset. However, in reality, there could be more variables which can be included in our cluster analysis to gain a more meaningful insight. 

