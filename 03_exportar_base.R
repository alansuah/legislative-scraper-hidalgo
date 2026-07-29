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
# 03_exportar_base.R\
#\
# Objetivo:\
# Limpiar la base obtenida y extraer el nombre del diputado\
# desde el texto de cada intervenci\'f3n.\
###############################################################\
\
library(dplyr)\
library(readr)\
library(stringr)\
\
datos <- read_csv(\
  "data/base_raw.csv",\
  show_col_types = FALSE\
)\
\
datos <- datos |>\
\
  mutate(\
\
    texto = str_replace_all(\
      texto,\
      "\\\\r",\
      "\\n"\
    ),\
\
    texto = str_squish(texto)\
\
  )\
\
datos <- datos |>\
\
  mutate(\
\
    diputado = str_extract(\
\
      texto,\
\
      "(?i)(?<=dip\\\\.?\\\\s)[A-Z\'c1\'c9\'cd\'d3\'da\'d1][A-Za-z\'c1\'c9\'cd\'d3\'da\'d1\'f1\\\\s]+?(?=\\\\n|iniciativa|dictamen|asuntos|posicionamiento|informe)"\
\
    ),\
\
    diputado = str_to_title(\
\
      str_squish(diputado)\
\
    )\
\
  )\
\
write_csv(\
\
  datos,\
\
  "data/base_legislativa_hidalgo.csv"\
\
)\
\
cat("Base final exportada.\\n")}