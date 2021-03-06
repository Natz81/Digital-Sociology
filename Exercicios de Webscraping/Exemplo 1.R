rm(list=ls())
options(warn=-1)
options(show.error.messages = T)
library(XML)


### Aprender uma linguagem � entender cada termo, mas tamb�m, pensar de uma forma diferente
### Perceba como cada fun��o() pega um objeto [ fun��o(objeto)] e o transforma em outra coisa.


### 1 - Criar um objeto cujo valor � o endere�o do site
baseurl <- "http://www.lab404.ufba.br/"
### 2 - Ler as linhas do site
url.lida <- readLines(baseurl)
### 3 - Em seguida � preciso fazer uma "an�lise gramatical" (Parse) das linhas de c�digo
url.analisada <- htmlParse(url.lida)
### 4 - Agora � preciso pegar as ra�zes (root) do XML da p�gina
url.conteudo <- xmlRoot(url.analisada)
### 5 - Agora � preciso pegarmos a informa��o que queremos dentro do site.
###     Esse � um momento importante e � onde ocorre a "garimpagem, � preciso analisar
###     o site para saber onde est� aquilo que queremos. 
###     
###     A fun��o que vamos usar � a:
###
         getNodeSet(conteudo da url, "XPATH onde est� a informa��o")
######################################################################
         Mas que diabos � "XPATH"????
######################################################################
         A linguagem "XPath" a XML Path Language, � uma linguagem de consulta (query Language) 
         para selecionar n�s de um documento XML ("eXtensible Markup Language").
         Sintaxe semelhante � do HTML, baseada em TAGS, mas voc� pode inventar seus pr�prios TAGS
         N�o substitui HTML (podemos que o HTML � um tipo particular de XML, com TAGs pr�-definidas)
         O que XML faz?
         Estrutura e descreve informa��es
         Uma outra "arquitetura" de banco de dados
         � baseada em uma representa��o em �rvore do documento XML,
         e fornece a capacidade de navegar ao longo da �rvore, selecionando n�s 
         por uma variedade de crit�rios        
######################################################################
###     Votemos ao nosso site. 
###     Digamos que eu queira pegar a descri��o do site:

descri��o <- getNodeSet(url.conteudo,"//*[@id='masthead']/div/div/div/p")
descri��o
####
### Perceba que a informa��o ainda est� dentro do node XML, se quisermos
### pegar somente o conte�do do node teremos que dar mais um comando

descri��o <- xmlSApply(descri��o, xmlValue)

descri��o

######################################################################
###     Digamos agora que eu pegar o in�cio do texto das postagens:

inicio.textos <- getNodeSet(url.conteudo,"//article/div/div/div/p")
inicio.textos <- xmlSApply(inicio.textos, xmlValue)
inicio.textos
######################################################################
###   Que tal pegarmos os t�tulos de todas as postagens:

titulos <- getNodeSet(url.conteudo, "//h2/a")
titulos <- xmlSApply(titulos, xmlValue)
titulos

###   Mas a� tem um detalhe, pois os t�tulos s�o links!!! 
###   Se quisermos pegar os links dos tpitulos precisamos de uma fun��o
###   diferente. Vejamos:

links.dos.titulos <- getNodeSet(url.conteudo, "//h2/a")
links.dos.titulos <- xmlSApply(links.dos.titulos, xmlGetAttr, name = "href")
links.dos.titulos

######################################################################
"Se voc� chegou at� aqui sem surtar, chorar ou quebrar o cpu, parab�ns voc�
acabou de fazer seu primeiro webscraping!!"
######################################################################




