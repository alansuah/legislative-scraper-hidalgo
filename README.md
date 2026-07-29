# Legislative Scraper – Congreso del Estado de Hidalgo

Repositorio para la obtención automatizada de información pública del Acervo Legislativo del Congreso del Estado de Hidalgo.

## Contenido

- Obtención automática del catálogo de diputadas y diputados.
- Descarga sistemática de intervenciones legislativas.
- Exportación de una base de datos en formato CSV.

## Flujo de trabajo

```text
01_catalogo_diputados.R
            ↓
02_scraping_legislativo.R
            ↓
03_exportar_base.R
```

## Requisitos

R ≥ 4.2

Paquetes:

- rvest
- dplyr
- readr
- purrr
- stringr
- tibble

## Ejecución

```r
source("R/01_catalogo_diputados.R")
source("R/02_scraping_legislativo.R")
source("R/03_exportar_base.R")
```

La base final se guarda como:

```
data/base_legislativa_hidalgo.csv
```

## Licencia

MIT
