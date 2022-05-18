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



 
 
 


