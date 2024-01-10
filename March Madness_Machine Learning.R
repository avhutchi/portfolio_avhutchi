library(tm)
#install.packages("tm")
library(stringr)
library(slam)
library(quanteda)
## ONCE: install.packages("quanteda")
library(SnowballC)
library(arules)
##ONCE: install.packages('proxy')
library(proxy)
library(cluster)
library(stringi)
library(proxy)
library(Matrix)
library(tidytext) 
library(plyr) 
library(ggplot2)
library(factoextra) 
library(mclust) 
library(amap)
library(networkD3)
library(stats)
library(tidyverse)
#install.packages("philentropy")
library(philentropy)
library(akmeans)


mmtourney = read.csv(file.choose(), header = TRUE)
head(mmtourney)
str(mmtourney)

mmtourney %>% count(team_id)


###prep
#5 teams with high number of obs
team12 = mmtourney[mmtourney$team_id == "12" , ]
team12 = team12[ , -c(1,2,4:8,22, 23, 25:69)]
#str(team12)

team24 = mmtourney[mmtourney$team_id == "24" , ]
team24 = team24[ , -c(1,2,4:8,22, 23, 25:69)]
#str(team24)

team39 = mmtourney[mmtourney$team_id == "39" , ]
team39 = team39[ , -c(1,2,4:8,22, 23, 25:69)]
#str(team39)

team81 = mmtourney[mmtourney$team_id == "81" , ]
team81 = team81[ , -c(1,2,4:8,22, 23, 25:69)]
#str(team81)

team111 = mmtourney[mmtourney$team_id == "111" , ]
team111 = team111[ , -c(1,2,4:8,22, 23, 25:69)]
#str(team111)

teams = rbind(team12 , team24, team39, team81, team111)
head(teams)
tail(teams)
str(teams)


teams_noid = teams[ , -1]
head(teams_noid)
str(teams_noid)



#set row names and numbers to not showing up
rownames(teams_noid) = NULL

####dist measure (all 5 teams)

mm_df = teams_noid
mm_df = as.data.frame(as.matrix(mm_df))
#mm_df = as.matrix(mm_df)
# dimnames(mm_mat) = NULL
tail(mm_df)
str(mm_df)

######dist measure

distMatrix_E = dist(mm_df, method="euclidean")
print(distMatrix_E)

distMatrix_C = distance(mm_df, method="cosine")
print(distMatrix_C) ##small number is less distant


distMatrix_C2 = distance(mm_df, method="cosine", use.row.names = TRUE)
print(distMatrix_C2) 


distMatrix_Min_2 = dist(mm_df,method="minkowski", p=2)
print(distMatrix_Min_2)


####dist measure with just team 81

team81 = team81[ , -1]
str(team81)
# rownames(team81) = NULL

# team81

distMatrix_E81 = dist(team81, method="euclidean")
print(distMatrix_E)

distMatrix_C81 = distance(team81, method="cosine")
print(distMatrix_C81) ##small number is less distant


distMatrix_C281 = distance(team81, method="cosine", use.row.names = TRUE)
print(distMatrix_C281) 


distMatrix_Min_281 = dist(team81,method="minkowski", p=2)
print(distMatrix_Min_281)


######distance measures (5 teams)

## Euclidean
groups_E <- hclust(distMatrix_E,method="ward.D")
plot(groups_E, cex=0.9, hang=-1, main = "Euclidean")
rect.hclust(groups_E, k=4)
radialNetwork(as.radialNetwork(groups_E))


## Cosine Similarity
distMatrix_C <- as.dist(distMatrix_C)
hclust(distMatrix_C, method = "single")

groups_C <- hclust(distMatrix_C,method="ward.D")
plot(groups_C, cex=.7, hang=-30,main = "Cosine Sim")
rect.hclust(groups_C, k=10)

radialNetwork(as.radialNetwork(groups_C))
dendroNetwork(groups_C)



########dist measure (team 81) 

## Euclidean
groups_E81 <- hclust(distMatrix_E81,method="ward.D")
plot(groups_E81, cex=0.9, hang=-1, main = "Euclidean")
rect.hclust(groups_E81, k=4)
radialNetwork(as.radialNetwork(groups_E81))

## Cosine Similarity
distMatrix_C281 <- as.dist(distMatrix_C281)
hclust(distMatrix_C281, method = "single")

groups_C81 <- hclust(distMatrix_C81,method="ward.D")
plot(groups_C81, cex=.7, hang=-30,main = "Cosine Sim")
rect.hclust(groups_C81, k=10)

radialNetwork(as.radialNetwork(groups_C81))
dendroNetwork(groups_E81)



groups_C281 <- hclust(distMatrix_C281,method="ward.D")
plot(groups_C281, cex=.7, hang=-30,main = "Cosine Sim")
rect.hclust(groups_C281, k=10)

radialNetwork(as.radialNetwork(groups_C281))
dendroNetwork(groups_C281)

########viz (5 teams)

#distance matrix is from above....
fviz_dist(distMatrix_C, gradient = list(low = "#00AFBB",
                                        mid = "white", high = "#FC4E07"))+
  ggtitle("Cosine Sim Based Distance Map")


#-

distance0 <- get_dist(distMatrix_C,method = "euclidean")
fviz_dist(distance0, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Euclidean Based Distance Map")


#-
distance1 <- get_dist(distMatrix_C,method = "manhattan")
fviz_dist(distance1, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Manhattan Based Distance Map")


#-
distance2 <- get_dist(distMatrix_C,method = "pearson")
fviz_dist(distance2, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Pearson Based Distance Map")


#-
distance3 <- get_dist(distMatrix_C,method = "canberra")
fviz_dist(distance3, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Canberra Based Distance Map")


#-
distance4 <- get_dist(distMatrix_C,method = "spearman")
fviz_dist(distance4, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Spearman Based Distance Map")



############ viz (team81)
fviz_dist(distMatrix_C281, gradient = list(low = "#00AFBB",
                                        mid = "white", high = "#FC4E07"))+
  ggtitle("Cosine Sim Based Distance Map team 81")


#-

distance081 <- get_dist(distMatrix_C81,method = "euclidean")
fviz_dist(distance081, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Euclidean Based Distance Map team81")


#-
distance181 <- get_dist(distMatrix_C81,method = "manhattan")
fviz_dist(distance181, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Manhattan Based Distance Map team 81")


#-
distance281 <- get_dist(distMatrix_C81,method = "pearson")
fviz_dist(distance281, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Pearson Based Distance Map team 81")

sum(is.infinite(distMatrix_C81))

#-
distance381 <- get_dist(distMatrix_C81,method = "canberra")
fviz_dist(distance381, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Canberra Based Distance Map team 81")


#-
distance481 <- get_dist(distMatrix_C81,method = "spearman")
fviz_dist(distance481, gradient = list(low = "#00AFBB",
                                     mid = "white", high = "#FC4E07"))+
  ggtitle("Spearman Based Distance Map team 81")

#####k - means clustering


##making copy of 5 teams no id
k2.data = teams_noid
head(k2.data)
str(k2.data)

###find optimal number of clusters for k
fviz_nbclust(k2.data, kmeans, method = "wss", k.max = 24) + theme_minimal() + ggtitle("the Elbow Method")



###attempt 1
(k2results = kmeans(k2.data, 5))

k2results$size
k2results$cluster

table(teams$team_id, k2results$cluster)



####higher level
k=5
kmeans_1 = kmeans(k2.data, k , centers = 5 , 
                  algorithm = c("Hartigan-Wong" , "Lloyd" , "Forgy" , "MacQueen"))

kmeans_1


####adtl way
kmeansFIT_1 = kmeans(k2.data,centers=5, nstart=4)
(kmeansFIT_1$centers)
#print("Kmeans details:")
summary(kmeansFIT_1)
(kmeansFIT_1$cluster)
kmeansFIT_1$centers[,1]


### cluster vis
fviz_cluster(kmeansFIT_1, k2.data)



###compared to cluster results (did clusters do well?)
plot(teams[c("avg_Score", "avg_rank")] , col = k2results$cluster)
plot(teams[c("team_id", "avg_rank")] , col = k2results$cluster)
plot(teams[c("avg_Score", "avg_rank", "team_id")] , col = k2results$cluster)

###compared to true classification/team number
plot(teams[c("avg_Score", "avg_rank")] , col = teams$team_id)
plot(teams[c("avg_FGM", "avg_rank")] , col = teams$team_id)
plot(teams[c("avg_Score", "avg_rank", "team_id")] , col = teams$team_id)


########full kmeans

## Check the data...
# k2.data[1:10,1:10]
# k2.data.m = as.matrix(k2.data)
# str(k2.data.m)

## Run Kmeans...
My_Kmeans1<-Kmeans(k2.data, centers=4,method = "euclidean")
fviz_cluster(My_Kmeans1,k2.data , main="Euclidean")

My_Kmeans2<-Kmeans(k2.data, centers=4,method = "spearman")
fviz_cluster(My_Kmeans2, k2.data, main="Spearman")

My_Kmeans3<-Kmeans(k2.data, centers=4,method = "manhattan")
fviz_cluster(My_Kmeans3, k2.data, main="Manhattan")

## akmeans packages........
##d.metric=2 is cosine sim   (1 is euclidean)


My_Adaptive_kmeans_withCosSim<-akmeans(k2.data,d.metric=2,ths3=0.8,mode=3)
My_Adaptive_kmeans_withCosSim$cluster
plot(My_Adaptive_kmeans_withCosSim$cluster)



