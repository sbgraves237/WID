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
#' More information about what data are available from WID and how to interpret 
#' them is is available in the 
#' [WID codes dictionary](https://wid.world/codes-dictionary). 
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
#'      ISO country or region code. For countries, these are 2-letter 
#'      [`ISO 3166-1 alpha-2`](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
#'      country codes, e.g., US for United States, DE for Germany 
#'      ("Deutchland" in German). For regions within countries, these are 5 or 
#'      6 characters, the first 2 of which is the country. This is followed by 
#'      "-" and 2 or 3 more characters for the region within the country. For 
#'      exam, `US-DC` = District of Columbia in the US, and `DE-BY` is Bavaria, 
#'      as noted above. These codes are all upper case. 
#'   }
#'   \item{variable}{
#'      code for the variable, e.g., `sfiinct992` and `sptinct992`, further 
#'      described in `DE_BYmeta`. 
#'      
#'      The complete WID variable codes (e.g., `sfiinct992` and 
#'      `sptinct992`) obey to the following logic:
#'        * the first letter indicates the variable type (i.e. "s" 
#'          for share, "t" for threshold; see the next paragraph in this 
#'          section documenting "variable").
#'        * the next five letters indicate the income/wealth/other 
#'          concept  (e.g., `fiinc` for "Fiscal income" and `ptinc` 
#'          for "pre-tax national income").
#'        * the next letter indicate the population unit described 
#'          with `pop` below. 
#'        * the last three characters indicate the age group (e.g. 
#'          "1" for ages 0 to 4, "992" for adults, "999" for all).
#'          
#'       File `WID_data_US.csv` contained in the full download from 
#'       the [World Inequality Database](https://wid.world/data/) 
#'       website on 2025-10-27 contained the following types (i.e., 
#'       first character of `variable`) obtained using the 
#'       [WIDcodes] function: 
#'       
#'         type count shorttype
#'          a  381099 Average 
#'          b   95243 Beta coefficient 
#'          e     906 Total emissions 
#'          g     748 Gini coefficient 
#'          i     519 Indices 
#'          k     906 Per-capita emissions 
#'          l   17190 Average per capita group emissions 
#'          m   31378 Total 
#'          n   11906 Population 
#'          r    2257 Top 10/Bottom 50 ratio 
#'          s  333286 Share 
#'          t  293285 Threshold value at `pX` for percentile `pXpY`.
#'          w   19862 % of NNI 
#'          x    1575 Exchange rates 
#'          y   21568 % of GDP 
#'          
#'       In the US data extracted 2025-10-27, data are available for 1,937 
#'       different variables. However, if we restrict consideration only to 
#'       `type = a` (Average), `pop = j` and `age = 999`, we find almost 
#'       43,000 observations on `diinc` = "Post-tax national income" 
#'       and less than 200 on other variables. If we want `s` (Share) or `t` 
#'       (Threshold), then comparable quantities of data are available only for 
#'       `diinc`, `hweal` = "Net personal wealth" and `ptinc` = "Pre-tax 
#'       national income". 
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
#'      
#'      For the median, combine type = 't' with percentile being, e.g, 
#'      `p50p51`, `p50p60`, `p50p90` or `p50p100`, all of which are available 
#'      in `WID_data_US.csv`. With the US data downloaded 2025-10-27, there 
#'      are 1966 "t" observations for each of `p50p90` and `p50p100` but only 
#'      748 for each of `p50p51` and `p50p60`. A user would be wise to confirm 
#'      which values of `percentile` are available for which `variable`. 
#'   }
#'   \item{year}{
#'      integer year. `WID_data_US.csv`downloaded 2025-10-27 has data on 
#'      between 246 and 12,210 variables each year between 1800 and 2024 with 
#'      more variables available on years between 1913 and 2023. 
#'   }
#'   \item{value}{
#'      a number whose value is determined by the `unit` for the corresponding 
#'      `variable`. 
#'   }
#'   \item{age}{
#'      integer code for age range, e.g., "1" for ages 0 to 4, '992' for 
#'      "Adults" (defined as "individuals over age 20"), and '999' for "All 
#'      Ages". The US data downloaded 2025-10-27 has the most information 
#'      available on '992' and '999'. 
#'   }
#'   \item{pop}{
#'      A single character. Those characters and occurrence in the US data 
#'      downloaded 2025-10-27 are as follows: 
#'      
#'        pop count shortpop
#'         f   9038 female
#'         i 175652 individuals
#'         j 990655 equal-split adults
#'         m   9004 male
#'         t  27379 tax unit
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
#'      All monetary amounts are in local currency at last year' prices for 
#'      countries and subregions -- USD (US dollars) for the United States. 
#'   }
#'   \item{source}{
#'      The source(s) used to compute the data.
#'   }
#'   \item{method}{
#'      Methological details describing how the data was constructed and/or 
#'      caveats.
#'   }
#'   \item{extrapolation}{
#'      NA in `DE_BYmeta` but in other `WID_metadata_*.csv` files, this 
#'      sometimes contain year ranges for which data were extrapolated. For 
#'      example, in the comparable `WID_metadata_US.csv`, this variable is 
#'      blank for most variables but has values like `[[2018, 2020]]` and 
#'      `[[1980, 1990], [2018, 2020]]`. 
#'   }
#'   \item{data_points}{
#'      NA in `DE_BYmeta` but in other `WID_metadata_*.csv` files, this 
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
