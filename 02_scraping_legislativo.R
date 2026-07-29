{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 ###############################################################\
# Proyecto:\
# Scraping del Acervo Legislativo del Congreso de Hidalgo\
#\
# Archivo:\
# 02_scraping_legislativo.R\
#\
# Objetivo:\
# Descargar todas las intervenciones legislativas mediante\
# consultas sistem\'e1ticas por diputado, mes y a\'f1o.\
###############################################################\
\
library(rvest)\
library(dplyr)\
library(readr)\
library(purrr)\
library(tibble)\
\
catalogo <- read_csv(\
  "data/catalogo_diputados.csv",\
  show_col_types = FALSE\
)\
\
meses <- 1:12\
\
periodos <- c(\
  2024,\
  2025\
)\
\
grid <- expand.grid(\
\
  diputado = catalogo$diputado_id,\
\
  mes = meses,\
\
  periodo = periodos\
\
)\
\
get_filtered_data <- function(dip, mes, per)\{\
\
  url <- paste0(\
\
    "https://congresohidalgo.gob.mx/acervo_legislativo/trabajo?",\
\
    "diputado=", dip,\
\
    "&mes=", mes,\
\
    "&periodo=", per\
\
  )\
\
  html <- read_html(url)\
\
  bloques <- html_elements(\
\
    html,\
\
    xpath = "//a[contains(@href,'.pdf')]/ancestor::*[.//h3][1]"\
\
  )\
\
  if(length(bloques)==0)\{\
\
    return(NULL)\
\
  \}\
\
  tibble(\
\
    diputado_id = dip,\
\
    mes = mes,\
\
    periodo = per,\
\
    pdf = html_element(\
      bloques,\
      xpath=".//a[contains(@href,'.pdf')]"\
    ) |>\
      html_attr("href"),\
\
    texto = html_text2(bloques)\
\
  )\
\
\}\
\
datos <- pmap_dfr(\
\
  grid,\
\
  \\(diputado,mes,periodo)\{\
\
    message(\
\
      diputado,\
\
      " | ",\
\
      mes,\
\
      " | ",\
\
      periodo\
\
    )\
\
    tryCatch(\
\
      get_filtered_data(\
\
        diputado,\
\
        mes,\
\
        periodo\
\
      ),\
\
      error=function(e)NULL\
\
    )\
\
  \}\
\
)\
\
datos <- distinct(\
\
  datos,\
\
  pdf,\
\
  .keep_all=TRUE\
\
)\
\
write_csv(\
\
  datos,\
\
  "data/base_raw.csv"\
\
)\
\
cat("Registros descargados:",nrow(datos),"\\n")}