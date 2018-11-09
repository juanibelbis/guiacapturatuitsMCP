## Paso 1: Configuramos el entorno de trabajo
Sys.setlocale(category = "LC_ALL", locale = "es_ES")
if (!require("pacman")) install.packages("pacman")
p_load(rtweet,jsonlite,dplyr,readr)
devtools::install_github("mkearney/rtweet")

## Paso 2: Cargamos las credenciales de Twitter
appname <- "AAAA"
key <- "BBBB"
secret <- "CCCC"
accesstoken <- "DDDD"
accesssecret <- "EEEE"

## Probamos la conexión con una búsqueda
test <- search_tweets("argentina",n=50)

## Vamos a capturar un hashtag
Bolsonaro <- search_tweets("bolsonaro", n = 20000, include_rts = TRUE, retryonratelimit = TRUE )


## Guardamos la búsqueda en un csv
write_as_csv(Bolsonaro,"Bolsonaro.csv")

## Armemos una línea de tiempo con la frecuencia de los tuits
ts_plot(Bolsonaro, "1 hours") +
  ggplot2::theme_minimal() +
  ggplot2::theme(plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Bolsonaro Twitter statuses from past 9 days",
    subtitle = "Twitter status (tweet) counts aggregated using one-hour intervals",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

## Instalamos más paquetes para trabajar nuevos gráficos
p_load(tidytext,widyr,igraph,ggraph)

## Ahora tiramos un gráfico con las fuentes de los tuits
RxA %>% group_by(source)%>% 
  summarise(Total=n()) %>% arrange(desc(Total)) %>% head(10) %>%
  ggplot(aes(reorder(source, Total), Total, fill = source)) + geom_bar(stat="identity") + coord_flip() + labs(title="Desde que dispositivos se tuitea sobre Bolsonaro", x="", subtitle="Acá ponemos un subtítulo", caption = "\nSource: Data collected from Twitter's REST API via rtweet")
