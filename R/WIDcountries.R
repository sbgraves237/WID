#' WID countries 
#'
#' @description
#' `data.frame` read from WID file `WID_countries.csv` with `rownames` = the 
#' first (`alpha2`) column. 
#' 
#' @format 
#' \describe{
#'   \item{alpha2}{
#'      [`ISO 3166-1 alpha-2`](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
#'      "country codes" with 2 letters for countries, e.g., US for United 
#'      States, DE for Germany ("Deutchland" in German) and 5 or 6 letters
#'      for region or stqtes within countries. For example, `US-DC` = District 
#'      of Columbia in the US, and `DE-BY` is Bavaria. These codes are all 
#'      upper case. 
#'   }
#'   \item{titlename}{Official name of the country.} 
#'   \item{shortname}{potentially shorter name for the country.}
#'   \item{region}{Name of the region, e.g., "Europe", "Asia", ... .}
#'   \item{region2}{Subregion, e.g., "Western Europe", "West Asia", ... .}
#'   \item{nchalpha2}{
#'      Number of characters in `alpha2` = 2 for country and 5 or 6 for a 
#'      subregion of the country.
#'   }
#' }
#' @examples
#'  
#' # ISO 2-letter code for the country with German name 'Deutschland'  
#' (Ger <- countrycode::countryname('Deutschland'))
#' (Ger2 <- countrycode::countrycode('Deutschland', origin='country.name.de', 
#'               destination='iso2c'))
#'  
#' WIDcountries[c('DE', 'US'), ]
#' 
#' # countries with data on internal states or regions
#' alphaGT2 <- with(WIDcountries, alpha2[nchalpha2>2])
#' (alphaGT2_ <- table(substring(alphaGT2, 1, 2)))
#' 
#' subset(WIDcountries, (substring(alpha2, 1, 1)== 'C') & (nchalpha2>2))
#' 
#' subset(WIDcountries,(substr(alpha2, 1, 1)== 'O')&(nchalpha2>2),titlename)
#' subset(WIDcountries,(substr(alpha2, 1, 1)== 'Q')&(nchalpha2>2),titlename)
#' subset(WIDcountries,(substr(alpha2, 1, 1)== 'W')&(nchalpha2>2),titlename)
#' subset(WIDcountries,(substr(alpha2, 1, 1)== 'X')&(nchalpha2>2),titlename)
#' 
#' @source <https://wid.world>"World Inequality Database"
"WIDcountries"
