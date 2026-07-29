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
# 01_catalogo_diputados.R\
#\
# Objetivo:\
# Obtener autom\'e1ticamente el cat\'e1logo de identificadores de\
# diputadas y diputados disponibles en el portal.\
###############################################################\
\
library(rvest)\
library(dplyr)\
library(readr)\
\
url <- "https://congresohidalgo.gob.mx/acervo_legislativo/trabajo"\
\
html <- read_html(url)\
\
diputados <- html |>\
  html_elements("select[name='diputado'] option") |>\
  html_attr("value")\
\
diputados <- diputados[diputados != "All"]\
\
catalogo <- tibble(\
  diputado_id = diputados\
)\
\
dir.create("data", showWarnings = FALSE)\
\
write_csv(\
  catalogo,\
  "data/catalogo_diputados.csv"\
)\
\
cat("Cat\'e1logo generado.\\n")\
cat("Diputados encontrados:", nrow(catalogo), "\\n")}