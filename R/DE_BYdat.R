#' Bavaria data from WID 
#'
#' @description
#' Data on Bavaria from the World Inequality Database (WID). 
#' This is one of 422 countries and regions downloaded 2025-10-27. 
#' It was selected as one of the smallest datasets in WID. 
#' It is included here to help demonstrate the features of this package. 
#' 
#' These datasets come in pairs with data in a file with a name like 
#' `WID_data_DE-BY.csv` and corresponding metadata in a file with a name like 
#' WID_metadata_DE-BY.csv", read using [read.csv2] into `DE_BYdat` and 
#' `DE_BYmeta`, respectively. In this example, `DE` is the 
#' [`ISO 3166-1 alpha-2`](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
#' code for Germany ("Deutschland", in German), and `DE-BY` is the 
#' [`ISO 3166`](https://en.wikipedia.org/wiki/ISO_3166) code for 
#' [Bavaria](https://en.wikipedia.org/wiki/Bavaria) ("Bayern" in German). 
#' 
#' `DE_BYdat` is a [`data.frame`] with 7 columns: `country`, `variable`, 
#' `percentile`, `year`, `value`, `age`, and `pop`. 
#' 
#' `DE_BYmeta` is a `data.frame with 19 columns: `country`, `variable`, `age`, 
#' `pop`, `countryname`, `shortname`, `simpledes`, `technicaldes`, `shorttype`, 
#' `longtype`, `shortpop`, `longpop`, `shortage`, `longage`, `unit`, `source`, 
#' `method`, `extrapolation`, and `data_points`, with the following definitions
#' for the different variables:   
#' 
#' @format 
#' \describe{
#'   \item{country}{
#'      ISO country or region code. These are 2-letter country codes. 
#'      For regions within countries, the 2 letters for that country are 
#'      followed by "-" and another 2 or 3 characters. All upper case. 
#'   }
#'   \item{variable}{
#'      code for the variable, e.g., `sfiinct992` for "Fiscal income", further 
#'      described in `DE_BYmeta`. 
#'      
#'      The complete WID variable codes (i.e. sfiinct992) obey to the following 
#'      logic:
#'        * the first letter indicates the variable type (i.e. "s" for share).
#'        * the next five letters indicate the income/wealth/other concept 
#'          (i.e. "ptinc" for pre-tax national income).
#'        * the next three digits indicate the age group (i.e. "992" for 
#'          adults).
#'        * the last letter indicate the population unit (i.e. "j" for 
#'          equal-split).
#'   }
#'   \item{percentile}{
#'      code for percentile, e.g., `p0p100` for everyone and `p99p99.9` for 
#'      those between the 99th and the 99.9th percentile. 
#'      
#'      There are two types of percentiles in WID data: 
#'      (1) group percentiles and 
#'      (2) generalized percentiles. 
#'      The interpretation of income (or wealth) average, 
#'      share or threshold series depends on which type of percentile is 
#'      looked at.
#'      
#'      Generalized percentiles (g-percentiles) are defined to as follows: 
#'      p0, p1, p2, ..., p99, p99.1, p99.2, ..., p99.9, p99.91, p99.92, ..., 
#'      p99.99, p99.991, p99.992 ,..., p99.999. 
#'      There are 127 g-percentiles in total, but none appear in `DE-BY` and 
#'      `US`. 
#'   }
#'   \item{year}{integer year}
#'   \item{value}{
#'      a number whose value is deterimined bythe `unit` for the corresponding 
#'      `variable`. 
#'   }
#'   \item{age}{
#'      integer code for age range, e.g.,  "1" for ages 0 to 4 and '999' for 
#'      everyone. 
#'   }
#'   \item{pop}{
#'      A single character: 
#'    \describe{
#'      \item{f}{female}
#'      \item{i}{individuals}
#'      \item{j}{equal-split adults (most common)}
#'      \item{m}{male}
#'      \item{t}{tax unit (e.g., household in the US)}
#'    }
#'   }
#'   \item{countryname}{ 
#'      the name of the country/region as it would appear in an English 
#'      sentence.   
#'   }
#'   \item{shortname}{
#'      the name of the country/region as it would appear on its own in English.
#'   }
#'   \item{simpledes}{
#'      decription of the variable in plain English.
#'   }
#'   \item{technicaldes}{
#'      description of the variable via accounting identities.
#'   }
#'   \item{shorttype}{
#'      short description of the variable type (average, aggregate, share, 
#'      index, etc.) in plain English.
#'   } 
#'   \item{longtype}{
#'      longer, more detailed description of the variable type in plain English.
#'   }
#'   \item{shortpop}{
#'      short description of the population unit (individuals, tax units, 
#'      equal-split, etc.) in plain English.
#'   }
#'   \item{longpop}{
#'      longer, more detailed description of the population unit in plain 
#'      English.
#'   }
#'   \item{shortage}{
#'      short description of the age group (adults, full population, etc.) in 
#'      plain English.
#'   }
#'   \item{longage}{
#'      longer, more detailed description of the age group in plain English.
#'   }
#'   \item{unit}{
#'      unit of the variable (the 3-letter currency code for monetary amounts).
#'   }
#'   \item{source}{
#'      The source(s) used to compute the data.
#'   }
#'   \item{method}{
#'      Methological details describing how the data was constructed and/or 
#'      caveats.
#'   }
#'   \item{extrapolation}
#'      `NA` in `DE_BYmeta` but in other `WID_metadata_*.csv` files, this 
#'      sometimes contain year ranges for which data were extrapolated. For 
#'      example, in the comparable `WID_metadata_US.csv`, this variable is 
#'      blank for most variables but has values like "[[2018, 2020]]" and 
#'      "[[1980, 1990], [2018, 2020]]". 
#'   }
#'   \item{data_points{
#'      `NA` in `DE_BYmeta` but in other `WID_metadata_*.csv` files, this 
#'      sometimes contain years for which data were available. For example, in 
#'      the comparable `WID_metadata_US.csv`, this variable is blank for most 
#'      variables but is `[2004, 2007, 2011, 2014]` for 8 observations dealing 
#'      with emissions. 
#'   }
#' }
#' @examples
#' ## DE_BYdat
#' table(DE_BYdat$country) # should be `DE_BY` for all observations. 
#' table(DE_BYdat$variable) # should be `c(sfiinct992=12, sptinct992=12) 
#' 
#' table(DE_BYdat$percentile) # should be 4 each of 
#' #`p90p100`, `p95p100`, `p99.5p100`, `p99.99p100`, `p99.9p100`, and `p99p100`. 
#' 
#' table(DE_BYdat$age) # should be `c(992=24)` = adults, i.e., over age 20. 
#' 
#' table(DE_BYdat$pop) # should be `c(t=24)`. 
#' 
#' ## DE_BYmeta
#' table(DE_BYmeta$country) # should be `DE_BY` for both observations. 
#' table(DE_BYmeta$countryname) # should be `Bavaria` for both observations. 
#' table(DE_BYmeta$variable) # should be `c(sfiinct992=1, sptinct992=1) 
#' 
#' table(DE_BYmeta$age) # should be `c(992=2)` = adults, i.e., over age 20. 
#' 
#' table(DE_BYmeta$pop) # should be `c(t=2)` for tax unit. 
#' 
#' 
#' @source <https://wid.world>"World Inequality Database"
"DE_BYdat"

#' @rdname DE_BYdat
"DE_BYmeta"
