# Clustering
Machine Learning Clustering

## 1. Tipos de Clustering

![image](https://user-images.githubusercontent.com/87387315/168158167-ff82ff61-42e4-4558-b9d3-88af8549279f.png)
![image](https://user-images.githubusercontent.com/87387315/168158555-630e9b00-1fe8-4582-b234-d28fab6c4951.png)

### Clustering hierárquico: 
Define clusters que definem uma hierárquia são representados por um dendograma. Podemos tambem representar eles com o diagrama de Venn

  #### Dendograma
  
  O dendograma é base dos métodos hierárquicos. 
  Você pode construí-lo a partir de cada elemento e ir agrupando-os. Esse método chamamos de **aglomerativo**(Aglomerative Clustering = bottom up).
  Ou você pode partir de um grande grupo com todos os elementos e ir separando-os. Esse é chamado de método **divisivo** (Divisive Clustering - top-down). 

![image](https://user-images.githubusercontent.com/87387315/168161605-b5e4b1c2-e355-4049-b482-699fd440c441.png)

### Clustering Particional

Uma vez que cada cluster formado e mutuamente exclusivo, nunca pode haver uma relacção hierárquica entre os clusters. Um algoritmo muito usado para este tipo de cluster é o algoritmo chamado k-means

![image](https://user-images.githubusercontent.com/87387315/168317288-b85c8224-ac20-40b6-a36c-c05818a49736.png)

(*) Ver explicação em excel do exercisio a  continuação para achar os centroides k-means.xlsc, sem qualquer conhecimento previo uma tecnica sugere que k seja igual a raiz quadrada de n/2. Onde n é o numero de dados. Para verificar que estamos trabalhando com o k ideal podemos aplicar o método elbow.
![image](https://user-images.githubusercontent.com/87387315/168631867-18488fd6-c807-4706-9bba-5902ba2b9326.png)

![image](https://user-images.githubusercontent.com/87387315/168631693-3e578b7a-aa01-4fd7-a4f2-3b7a76e3756d.png)

![image](https://user-images.githubusercontent.com/87387315/168317730-16be9494-255a-4a31-977a-9c6c8b98a335.png)

![image](https://user-images.githubusercontent.com/87387315/168317660-dfbfe2ff-b1f8-4eea-a892-5f5ec2e125ed.png)

### Clustering metrics

Vários métodos podem ser usados na avaliação de algoritmos de agrupamento.Para isso é necessario saber quais seram as divisões do cluster, as saídas previstas (ground truth - o valor observado, valor historico), para poder comparar com o resultado do modelo, cabe resaltar que nem sempre temos essas informações disponiveis. Essas métricas incluem:

***Homogeneity score.*** O resultado de um cluster é dito homogêneo se seus clusters contiverem apenas dados que são membros de uma única classe.

***Completeness score.*** a pontuação verifica se todos os membros de uma determinada classe são atribuídos ao mesmo cluster. 

***V measure score.*** a media entre`homogeneity e completeness. 
 
 Estas métricas tem pontoações entre 0 e 1 sendo desejada o número maior.
 
 Temos outas métricas que não requerem das saídas previstas:
 
***Inercia ***
Soma as distancias das amostras para seu centro mais proximo de agrupamento  mais próxima. Como sabemos dentro de um cluster queremos a menos distancia posivel, e entre cluster a maior distancia posivel. Podemos aplicar o método do elbow para determinar o melhor K.

## DBSCAN

http://scikit-learn.org/stable/modules/generated/sklearn.cluster.DBSCAN.html

DBSCAN (Density-Based Spatial Clustering of Applications with Noise) é um algoritmo de clustering popular usado como uma alternativa ao K-Means, em análise preditiva. Ele não requer que você defina o número de clusters. Mas em troca, você tem que ajustar dois outros parâmetros.

O Agrupamento Espacial Baseado em Densidade de Aplicações com Ruído (DBSCAN) é um algoritmo de agrupamento de dados proposto por Martin Ester, Hans-Peter Kriegel, Jörg Sander e Xiaowei Xu em 1996. Trata-se de um algoritmo de agrupamento baseado em densidade: dado um conjunto de pontos em algum espaço, agrupa pontos que estão intimamente próximos (pontos com muitos vizinhos próximos), e marcando como outliers pontos que estão sozinhos em regiões de baixa densidade (vizinhos que estão muito longe). DBSCAN é um dos algoritmos de agrupamento mais comuns e também mais citados na literatura científica.

Em 2014, o algoritmo foi premiado com o prêmio de teste de tempo na principal conferência de mineração de dados, KDD.

A implementação do Scikit-Learn fornece um padrão para os parâmetros eps e min_samples, mas que geralmente devem ser ajustados. O parâmetro eps é a distância máxima entre dois pontos de dados a serem considerados na mesma vizinhança. O parâmetro min_samples é a quantidade mínima de pontos de dados em um bairro (neighborhood) a ser considerado um cluster.

Uma vantagem do DBSCAN sobre o K-Means é que DBSCAN não é restrito a um número de conjuntos de clusters durante a inicialização. O algoritmo determinará um número de aglomerados com base na densidade de uma região. Tenha em mente, no entanto, que o algoritmo depende dos parâmetros eps e min_samples para descobrir qual a densidade de cada cluster.

Como o algoritmo DBSCAN tem um conceito interno de ruído, é comumente usado para detectar valores anómalos nos dados - por exemplo, atividade fraudulenta em cartões de crédito, e-commerce ou reivindicações de seguros.

![image](https://user-images.githubusercontent.com/87387315/170515919-35ebc6ee-4542-4ab3-82b3-51fa4de88e18.png)

## Mean Shift

http://scikit-learn.org/stable/modules/generated/sklearn.cluster.MeanShift.html

https://docs.opencv.org/4.2.0/d7/d00/tutorial_meanshift.html

O Mean Shift é uma técnica não-paramétrica de análise de espaço de características para localizar os máximos de uma função de densidade. Pode ser usado para análise de cluster, visão computacional e processamento de imagem. Foi originalmente proposto em 1975.

Em contraste com o algoritmo K-Means, a saída do Mean Shift não depende de quaisquer suposições explícitas sobre a forma da distribuição de pontos de dados, o número de clusters ou qualquer forma de inicialização aleatória.

Uma formulação geral do algoritmo Mean Shift pode ser desenvolvida através da consideração de núcleos (Kernels) de densidade. Esta abordagem é muitas vezes referida como estimativa de densidade de kernel - um método para estimativa de densidade que muitas vezes converge mais rapidamente e que também gera uma boa estimativa contínua para a função de densidade.

Essencialmente, o Mean Shift trata o problema de agrupamento supondo que todos os pontos dados representam amostras de alguma função de densidade de probabilidade, com regiões de alta densidade de amostra correspondendo aos máximos locais desta distribuição. Para encontrar esses máximos locais, o algoritmo funciona permitindo que os pontos se atraiam, por meio do que poderia ser considerado uma espécie de "força gravitacional de curto alcance". Permitindo que os pontos gravitem para áreas de maior densidade, pode-se mostrar que eles eventualmente se unificarão em uma série de pontos, próximos aos máximos locais da distribuição. Esses pontos de dados que convergem para os mesmos máximos locais são considerados membros do mesmo cluster.

Em conclusão o DBscan utiliza vecinos mais proxinos e Meanshift utiliza a função de densidade de probabilidade, e ningum dos dois requer a especificar a quantidade de clusters previamente como no caso de Kmeans



 
 
 


