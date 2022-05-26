#
# 
# C�DIGO
# 
# Este c�digo explora o data frame USArrests (datasets) empregando diferentes t�cnicas
# de clusteriza��o, m�todoso de avalia��o dos grupos, visualiza��o dos dados etc.   
#
# O c�digo est� dividido nas seguintes se��es: 
#
# 1. PREPARE CONHE�A SEU DADO
# 2. BUSCANDO O MELHOR K N�MERO DE GRUPOS
# 2.1. Within and Betweenss: Elbow
# 2.2. Group Sizes
# 2.3. Silhouette Method
# 3. ANALISE DOS GRUPOS (DOS RESULTADOS)
# 4. PAM K MED�IDES
# 5. CLUSTER HIERARQUICO HCLUST
# 6. OUTROS M�TODOS E DISCUSS�O
#
# A cada se��o do c�digo, explicadas neste texto de apoio, execute e explore o c�digo,  
# e responda as quest�es correspondente.
#    


# ----------------------------------------------------------------------------------
# IMPORTANTE: 
# Muitos processos aqui executados empregam t�cnicas de resampling. 
# No caso de estar obtendo resultados diferentes das alternativas do
# question�rio, limpe todas as vari�veis (o workspace do RStudio)
# e re-execute o trecho em quest�o. N�o esque�a tamb�m de manter o seed.
# ----------------------------------------------------------------------------------


#
# Um ou mais pacotes podem ser necess�rios. Instale a medida que forem
# necess�rios
# ----------------------------------------------------------------------------------

# install.packages("datasets")
# install.packages("cluster")
# install.packages("tidyverse")
# install.packages("corrplot")
# install.packages("gridExtra")
# install.packages("GGally")


library(datasets) # USArrests
library(cluster)
library(tidyverse)
library(corrplot)
library(gridExtra)
library(GGally)
library(factoextra)

#
# 1. PREPARE CONHE�A SEU DADO                      Q1
# ----------------------------------------------------------------------------------

#
# Know your data before start  
#
help(USArrests)
head(USArrests)
help(USArrests)

#
# Missing Data: Dados faltantes devem ter tratamento antes da clusteriza��o 
#
# H� dados faltantes aqui? 
#
any(is.na(USArrests))

#
# Numeric Data: Como a Clusteriza��o emprega fun��es de similaridade/dist�ncia somente
# dados num�ricos s�o aceitos 
#
# H� dados N�O num�ricos aqui? 
#
any(as.logical(sapply(USArrests, is.numeric )-1))

#
# Scale data: diferentemente dos processos de classifica��o (aprendizado supervisionado)
# � importante aplicar-se algum tipo normaliza��o os dados dos dados 
#
# A fun��o scale( ) normaliza todos os valores com centro=0 (media) e variancia=1   
#
mydata = data.frame(scale(USArrests))
summary(mydata)
sapply(mydata,median) # cuidado com o nr de zeros!
sapply(mydata,var)

#
# 2. BUSCANDO O MELHOR K N�MERO DE GRUPOS
# ----------------------------------------------------------------------------------

#
# 2.1. Within and Betweenss: Elbow                 Q2  
# ----------------------------------------------------------------------------------
RNGversion("3.5.2")
set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
wss = 0
bss = 0
for (i in 1:10) wss[i] = sum(kmeans(mydata,i, nstart=25)$withinss) 
for (i in 1:10) bss[i] = sum(kmeans(mydata,i, nstart=25)$betweenss)

par(mfrow=c(1,2)) 
plot(1:10, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")
# Voce s� poder� definir o valor abaixo depois de inspecionar no gr�fico acima
# o ponto de cotovelo
abline(v=4,col="red")

plot(1:10, bss, type="b", xlab="Number of Clusters", ylab="Betweenss groups sum of squares")
# Voce s� poder� definir o valor abaixo depois de inspecionar no gr�fico acima
# o ponto de cotovelo
abline(v=4,col="red")

# 
# consulte o help(kmeans) e empregue a fun��o para responder a Q2  
# fit = kmeans(mydata, k, nstart=25) 
#
fit = kmeans(mydata, 4, nstart=25)
fit

a = 16.212213 + 11.952463 + 19.922437 +  8.316061
a
#Rpta a suma da distancia dos elementos de cada cluster para os elementos encontrados é 56.40317 para k=4

# 
# 2.2. Group Sizes                                 Q3  
# ----------------------------------------------------------------------------------

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
par(mfrow=c(2,2))

for (i in 3:6){
  fit <- kmeans(mydata,i, nstart=25)
   main_ = paste("Size groups for k=", i)
   print(main_)
   print(fit$size)
   barplot(fit$size, main = main_ )
}  

# 
# consulte o help(kmeans) e empregue a fun��o para responder a Q3  
#fit = kmeans(mydata, k, nstart=25) 
#
#K-means clustering with 4 clusters of sizes 16, 13, 13, 8

#
# 2.3. Silhouette Method                           Q4  
# ----------------------------------------------------------------------------------

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
ss_m = c(0)
for (i in 3:10){
  fit <- kmeans(mydata,  i, nstart=25)
  ss <- silhouette(fit$cluster, dist(mydata))
  ss_m[i] <-  mean(ss[,3])
}

par(mfrow=c(1,1))
plot(ss_m,
     type = "b", pch = 19, frame = FALSE, 
     xlab = "Number of clusters K",
     ylab = "Average Silhouettes",
     xlim=c(3,10))
# Voce s� poder� definir o valor abaixo depois de inspecionar no gr�fico acima
# o ponto de cotovelo
abline(v=4,col="red")

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
par(mfrow=c(2,2))
fit <- kmeans(mydata,  3, nstart=25)
ss1 <- silhouette(fit$cluster, dist(mydata))
plot(ss1)

fit <- kmeans(mydata,  4, nstart=25)
ss2 <- silhouette(fit$cluster, dist(mydata))
plot(ss2)

fit <- kmeans(mydata,  5, nstart=25)
ss3 <- silhouette(fit$cluster, dist(mydata))
plot(ss3)

fit <- kmeans(mydata,  6, nstart=25)
ss4 <- silhouette(fit$cluster, dist(mydata))
plot(ss4)

# se necess�rio consulte o help(silhouette) e empregue a fun��o para responder a Q3  
#help(silhouette)
mean(ss2[,3])
# O valor medio é 0.3396889
#
# 3. ANALISE DOS GRUPOS (DOS RESULTADOS)           Q5  
# ----------------------------------------------------------------------------------

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
fit <- kmeans(mydata,4, nstart=25)

par(mfrow=c(1, 1))
ss <- silhouette(fit$cluster, dist(mydata))
plot(ss)
mean(ss[,3])
#Kmeans:0.3396889
# 
# a. Visualizando o Cluster para os Dois Componentes Principais
# (voc� vai conhecer mais sobre componente principais na pr�xima trilha)
#

par(mfrow=c(1, 1))
clusplot(mydata, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)
#install.packages("fpc")
#library(fpc) 
# voc� pode ignorar se encontrar a msg 
# Error: could not find function "plotcluster"
#
plotcluster(mydata, fit$cluster)

# 
# b. Visualizando o Cluster para Duas vari�veis de sua escolha 
#

p1 = ggplot(mydata, aes(UrbanPop, Murder, color = as.factor(fit$cluster))) + geom_point()
p2 = ggplot(mydata, aes(UrbanPop, Assault, color = as.factor(fit$cluster))) + geom_point()
p3 = ggplot(mydata, aes(UrbanPop, Rape, color = as.factor(fit$cluster))) + geom_point()

grid.arrange(p1, p2, p3)

# 
# c. Visualizando os valores m�dios de cada Cluster 
#

mydata$predict = fit$cluster # adicionando o atributo predict

par(mfrow=c(2, 2))
for (i in 1:4){
  main_ = paste("Group =", i)
  barplot(sapply(mydata[mydata$predict==i,-5],mean),main=main_) 
}

# 
# d. Visualizando o Cluster para a diferentes pares de vari�veis e suas distribui��es
#

ggpairs(cbind(mydata, Cluster=as.factor(fit$cluster)),
        columns=1:4, aes(colour=Cluster, alpha=0.5),
        lower=list(continuous="points"),
        upper=list(continuous="blank"),
        axisLabels="none", switch="both") 

#
# 4. PAM K MED�IDES                       Q6 
# ----------------------------------------------------------------------------------
# para reestabelecer somente os valores de Murder, Assault, UrbanPop, Rape  
mydata_pam = mydata[,-c(5)] # retira o valor predict acrescentado anteriormente

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
fit2 = pam(mydata_pam,4)

# Compare PAM e Kmeans
tt<-table(fit2$cluster, mydata$predict)
tt
tt[order(tt[,1],decreasing=TRUE),]

ss <- silhouette(fit2$cluster, dist(mydata_pam))

par(mfrow=c(1, 1))
plot(ss)
mean(ss[,3])
#PAM:0.3389904
# 
# 5. CLUSTER HIERARQUICO HCLUST            Q7 Q8 Q9
# ----------------------------------------------------------------------------------
# para reestabelecer somente os valores de Murder, Assault, UrbanPop, Rape  
mydata_hclu = mydata[,-c(5)] # retira o valor predict acrescentado anteriormente

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
d <- dist(mydata_hclu, method = "euclidean") # distance matrix

#    ATEN��O: altere o c�digo para escolha de um m�todo e execute um m�todo por 
#    vez escolhendo o melhor particionamento
#

#fit3 <- hclust(d, method = "complete")                   
#fit3 <- hclust(d, method = "single") 
fit3 <- hclust(d, method = "average")  

#
#    A seguir repetem-se os mesmos procedimentos empregados para o K-m�dias: 
#    an�lise do Silhouette, Visualiza��o dos resultados e um comparativo com o PAM.


par(mfrow=c(1, 1))
plot(fit3) # display dendogram

# cut tree into 4 clusters
groups <- cutree(fit3, k=4) 

# draw dendogram with red borders around the 4 clusters 
rect.hclust(fit3, k=4, border="red")

#
#  Silhouette
#
ss = silhouette(groups, dist(mydata_hclu))
plot(ss)
mean(ss[,3])
#complete:[1] 0.3159551
#simple: 0.1740581
#average:0.3636819
#
# Compare aqui agrupamentos (PAM, hclust) e (Kmeans, hclust) a 
# exemplo c�digo acima em que comparamos (PAM, Kmeans) 
#
# responda ent�o a quest�o 9
#
set.seed(1987)
t1<-table( groups, fit2$cluster)
t1
#HCLUST VS PAM
#complete = 6 elementos
#   1  2  3  4
#1  7  1  0  0
#2  0 11  0  0
#3  1  0 18  2
#4  0  0  2  8

#average              #average reordenada = 13 elementos
#  1  2  3  4         #   1  2  3  4 
#1  7  0  0  0        #1  7  0  0  0
#2  0  1  0  0        #3  0 11  1  0
#3  0 11  1  0        #4  1  0 19 10
#4  1  0 19 10        #2  0  1  0  0


ss1 <- silhouette(groups, dist(mydata_pam))

par(mfrow=c(1, 1))
plot(ss1)
mean(ss1[,3])

set.seed(1987)
t2<-table (groups, mydata$predict)
t2
#HCLUST vs KMEANS
#complete         #complete reordenada - 6 elementos
#   1  2  3  4    #   1  2  3  4
#1  1  0  0  7    #2 11  0  0  0
#2 11  0  0  0    #4  0 10  0  0
#3  1  3 16  1    #3  1  3 16  1
#4  0 10  0  0    #1  1  0  0  7

#average          #average reordenada - 15 elementos
#   1  2  3  4    #   1  2  3  4
#1  0  0  0  7    #3 12  0  0  0
#2  1  0  0  0    #2  1  0  0  0
#3 12  0  0  0    #4  0 13 16  1
#4  0 13 16  1    #1  0  0  0  7



ss2 <- silhouette(groups, dist(mydata))

par(mfrow=c(1, 1))
plot(ss2)
mean(ss2[,3])

# o c�digo para essa quest�o n�o � fornecido

set.seed(1987)

#
# see results like kmeans 
#
par(mfrow=c(1, 1))
clusplot(mydata_hclu, groups, color=TRUE, shade=TRUE, 
         labels=2, lines=0)

# Centroid Plot against 1st 2 discriminant functions
# library(fpc)
plotcluster(mydata_hclu, groups)

ggpairs(cbind(mydata_hclu, Cluster=as.factor(groups)),
        columns=1:4, aes(colour=Cluster, alpha=0.5),
        lower=list(continuous="points"),
        upper=list(continuous="blank"),
        axisLabels="none", switch="both")

#
# 6. OUTROS M�TODOS E DISCUSS�O           Q10
# 
# Acesse help(fviz_nbclust) ou pesquise na internet sobre esse pacote 
# e execute o c�digo abaixo para os m�todos kmeans e hclust
# 

# para reestabelecer somente os valores de Murder, Assault, UrbanPop, Rape  
mydata = mydata[,-c(5)] # retira o valor predict acrescentado anteriormente

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
fviz_nbclust(mydata, kmeans, method = "silhouette")

# Veja no help(fviz_nbclust) o que a fun��o abaixo faz e como alterar o
# parametro de kmeans para o cluster hierarquico (n�o � hclust! ;-) )
set.seed(1987)
fviz_nbclust(mydata, hcut, method = "silhouette")

set.seed(1987) # n�o altere para que seu resultados correspondam ao question�rio
fviz_nbclust(mydata, FUNcluster = kmeans, method = c("silhouette", "wss",
                                                     "gap_stat"), diss = NULL, k.max = 20, nboot = 100,
             verbose = interactive(), barfill = "steelblue", barcolor = "steelblue",
             linecolor = "steelblue", print.summary = TRUE)
