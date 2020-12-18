# landusepl
Display, convert and export CORINE Land Cover - CLC 2018 map to WAsP roughness file for a selected county in Poland.

### CORINE Land Cover - CLC 2018 for Poland
Description of the project is available on the web page <https://clc.gios.gov.pl/index.php/clc-2018/o-projekcie> where data can be requested.

### Obligatory information due to the use of CORINE Land Cover - CLC 2018

**Acording to the terms of use, please find the below obligatory statement:**

*„Projekt Corine Land Cover 2018 w Polsce został zrealizowany przez Instytut Geodezji i Kartografii i sfinansowany ze środków Unii Europejskiej. Wyniki porojektu zostały pozyskane ze strony internetowej Głównego Inspektoratu Ochrony Środowiska <https://clc.gios.gov.pl>.*

### Change and processing of CORINE Land Cover - CLC 2018 data set

*The package landusepl uses the main CORINE Land Cover - CLC 2018 map file divided into voivodeships. Due to this conversion it in the below voivodeships of Poland data were lost:*

* TERYT code 12, Lesser Poland, województwo małopolskie
* TERYT code 20, Podlaskie, województwo podlaskie
* TERYT code 22, Pomeranian, województwo pomorskie
* TERYT code 24, Silesian, województwo śląskie
* TERYT code 26, Holy Cross, województwo świetokrzyskie
* TERYT code 30, Greater Poland, województwo wielkopolskie

### Installation

Dev version 0.0.0.9001

``` r
remotes::install_github("prcwiek/landusepl")
```

### Remarks
The package landusepl uses quite big map files, hence it can work slow. 




