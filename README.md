
# landusepl

<!-- README.md is generated from README.Rmd. Please edit that file -->

Display, convert and export CORINE Land Cover - CLC 2018 map to WAsP
(Wind Atlas Analysis and Application Program) roughness file for a
selected county in Poland.

### CORINE Land Cover - CLC 2018 for Poland

Description of the project is available on the web page
<https://clc.gios.gov.pl/index.php/clc-2018/o-projekcie> where data can
be requested.

### Obligatory information due to the use of CORINE Land Cover - CLC 2018

**Acording to the terms of use, please find the below obligatory
statement:**

*„Projekt Corine Land Cover 2018 w Polsce został zrealizowany przez
Instytut Geodezji i Kartografii i sfinansowany ze środków Unii
Europejskiej. Wyniki porojektu zostały pozyskane ze strony internetowej
Głównego Inspektoratu Ochrony Środowiska <https://clc.gios.gov.pl>.*

### Change and processing of CORINE Land Cover - CLC 2018 data set

The package landusepl uses the main CORINE Land Cover - CLC 2018 map
file divided into voivodeships. Due to this conversion it in the below
voivodeships of Poland data were lost:

-   TERYT code 12, Lesser Poland, województwo małopolskie
-   TERYT code 20, Podlaskie, województwo podlaskie
-   TERYT code 22, Pomeranian, województwo pomorskie
-   TERYT code 24, Silesian, województwo śląskie
-   TERYT code 26, Holy Cross, województwo świetokrzyskie
-   TERYT code 30, Greater Poland, województwo wielkopolskie

### Installation

Get the development version 0.0.0.9300 from github:

``` r
# install.packages("devtools")
devtools::install_github("prcwiek/landusepl")
```

### Use

``` r
library(landusepl)
```

For example, let’s take a look at Zachodniopomorskie voivodeship
(district) in Poland. First we have to find a county for which we want
to generate maps. We have to do it with TERYT codes and found code\_je
for a county we are interested in.

TERYT is a code of voivodeship. The complete list of voivodeships in
Poland is presented below.

``` r
library(dplyr)
show_teryt() %>% select(TERYT, Voivodeship) %>% distinct(TERYT, Voivodeship) %>% arrange(Voivodeship)
#> # A tibble: 16 x 2
#>    TERYT Voivodeship        
#>    <chr> <chr>              
#>  1 02    dolnośląskie       
#>  2 04    kujawsko-pomorskie 
#>  3 10    łódzkie            
#>  4 06    lubelskie          
#>  5 08    lubuskie           
#>  6 12    małopolskie        
#>  7 14    mazowieckie        
#>  8 16    opolskie           
#>  9 18    podkarpackie       
#> 10 20    podlaskie          
#> 11 22    pomorskie          
#> 12 24    śląskie            
#> 13 26    świętokrzyskie     
#> 14 28    warmińsko-mazurskie
#> 15 30    wielkopolskie      
#> 16 32    zachodniopomorskie
```

Let’s find all counties in Zachodniopomorskie voivodeship (district)
which has TERYT code 32. The code\_je is a code of a county consists of
TERYT + 2 digits identifier.

``` r
show_teryt(teryt = "32") %>% print(n = Inf)
#> # A tibble: 21 x 4
#>    TERYT Voivodeship        Code_je County      
#>    <chr> <chr>              <chr>   <chr>       
#>  1 32    zachodniopomorskie 3201    białogardzki
#>  2 32    zachodniopomorskie 3202    choszczeński
#>  3 32    zachodniopomorskie 3203    drawski     
#>  4 32    zachodniopomorskie 3204    goleniowski 
#>  5 32    zachodniopomorskie 3205    gryficki    
#>  6 32    zachodniopomorskie 3206    gryfiński   
#>  7 32    zachodniopomorskie 3207    kamieński   
#>  8 32    zachodniopomorskie 3208    kołobrzeski 
#>  9 32    zachodniopomorskie 3261    Koszalin    
#> 10 32    zachodniopomorskie 3209    koszaliński 
#> 11 32    zachodniopomorskie 3218    łobeski     
#> 12 32    zachodniopomorskie 3210    myśliborski 
#> 13 32    zachodniopomorskie 3211    policki     
#> 14 32    zachodniopomorskie 3212    pyrzycki    
#> 15 32    zachodniopomorskie 3213    sławieński  
#> 16 32    zachodniopomorskie 3214    stargardzki 
#> 17 32    zachodniopomorskie 3216    świdwiński  
#> 18 32    zachodniopomorskie 3263    Świnoujście 
#> 19 32    zachodniopomorskie 3262    Szczecin    
#> 20 32    zachodniopomorskie 3215    szczecinecki
#> 21 32    zachodniopomorskie 3217    wałecki
```

Let’s take a look at the borders of Gryfinski County, which has a
code\_je 3206

``` r
county_map(code_je = "3206")
```

And its land cover according to CORINE Land Cover - CLC 2018 for Poland.

``` r
corine_map(code_je = "3206")
```

In the above map for each area there are two values displayed, the
CODE\_18 and roughness length assigned according to the below table.

``` r
show_clc()
#> # A tibble: 44 x 4
#>    CORINE_Land_Cove… Roughness_length Description_PL        Description_EN      
#>    <chr>             <chr>            <chr>                 <chr>               
#>  1 111               0.5              Zabudowa miejska zwa… City dense buildings
#>  2 112               0.3              Zabudowa miejska luź… City                
#>  3 121               0.5              Tereny przemysłowe l… Industrial or comme…
#>  4 122               0.1              Tereny komunikacyjne… Communication areas…
#>  5 123               0.5              Porty                 Harbors             
#>  6 124               0.5              Lotniska              Airports            
#>  7 131               0.5              Miejsca eksploatacji… Opencast mining sit…
#>  8 132               0.5              Zwałowiska i hałdy    Dumps and heaps     
#>  9 133               0.5              Budowy                Construction sites  
#> 10 141               0.3              Tereny zielone        Green areas         
#> 11 142               0.3              Tereny sportowe i wy… Sports and recreati…
#> 12 211               0.03             Grunty orne poza zas… Arable land beyond …
#> 13 212               0.03             Grunty orne stale na… Arable land constan…
#> 14 213               0.03             Pola ryżowe           Rice fields         
#> 15 221               0.1              Winnice               Vineyards           
#> 16 222               0.1              Sady i plantacje      Orchards and planta…
#> 17 223               0.1              Gaje oliwne           Olive groves        
#> 18 231               0.03             Łąki pastwiska        Pasture meadow      
#> 19 241               0.1              Uprawy jednoroczne i… Annual and permanen…
#> 20 242               0.1              Złożone systemy upra… Complex systems of …
#> 21 243               0.1              Tereny zajęte główni… Areas are mainly oc…
#> 22 244               0.3              Tereny rolno-leśne    Agricultural and fo…
#> 23 311               0.5              Lasy liściaste        Deciduous forests   
#> 24 312               0.5              Lasu iglaste          Coniferous forest   
#> 25 313               0.5              Lasy mieszane         Mixed forests       
#> 26 321               0.03             Murawy i pastwiska n… Grasslands and natu…
#> 27 322               0.1              Wrzosowiska i zakrza… Moors and bushes    
#> 28 323               0.1              Roślinność sucholubna Dry-loving vegetati…
#> 29 324               0.3              Lasy i roślinność kr… Forests and shrub v…
#> 30 331               0.03             Plaże wydmy piaski    Sand dune beaches   
#> 31 332               0.03             Odsłonięte skały      Exposed rocks       
#> 32 333               0.03             Roślinność rozproszo… Scattered vegetation
#> 33 334               0.03             Pogorzeliska          Fire sites          
#> 34 335               0.03             Lodowce i wieczne śn… Glaciers and eterna…
#> 35 411               0.03             Bagna śródlądowe      Inland marshes      
#> 36 412               0.03             Torfowiska            Peatlands           
#> 37 421               0.03             Bagna słone (solnisk… Salt marshes (salt …
#> 38 422               0.03             Saliny                Salt evaporation po…
#> 39 423               0.03             Osuchy                Drain               
#> 40 511               0.0002           Cieki                 Water paths         
#> 41 512               0.0002           Zbiorniki wodne       Water zones         
#> 42 521               0.0002           Laguny                Lagoons             
#> 43 522               0.0002           Estuaria              Estuaries           
#> 44 523               0.0002           Morza i oceany        Seas oceans
```

It is possible to export the above table as csv file, modify and upload
it back.

``` r
# save with the assignation table to a file, .csv is added fname automatically
save_clc(fname = "assignation_table")

# load a file with the assignation table
load_clc(fname = "assignation_table.csv")
```

The export to a WAsP map file
(<https://www.wasp.dk/Support/FAQ#maps__roughnessandorography>)

``` r
export_wasp_map(fname = "gryfinski.map", code_je = "3206", wgs_zone = 33, buffer = -1)
```

It is necessary to provide the correct UTM WGS34 zone, for Poland 33 or
34. The buffer has to be negative and will be used to shrink all areas.
The roughness between areas will be equal to 0.03. The default value is
-1 m.
