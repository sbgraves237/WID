#' WIDcodes  
#'
#' @description
#' Extract definitions from a `_metadata_` file for variables in a 
#' corresponding `_data_` file in the 
#' [World Inequalty Database (WID)](https://wid.world/). 
#' 
#' @param code name of a column of `data` for which matching information in 
#' `meta` is desired. If `grep(code, names(meta))` finds nothing, `WIDcodes`
#' throws an error. Otherwise it returns the number of matches for each level 
#' of `code` in `data` followed by the corresponding information in `meta`. 
#' If `length(grep(code, names(meta)))` > 1, `WIDcodes` returns the 
#' corresponding content of the matching columns of `meta`. 
#' 
#' In particular, 
#' * `WIDcode('age', ...)` returns matching columns of `shortage` and `longage`. 
#' * `WIDcode('pop', ...)` returns matching columns of `shortpop` and `longpop`.
#' * `WIDcode('country', ...)` returns matching columns of `countryname`.
#' 
#' If `length(grep(code, names(meta)))` = 1, `WIDcodes` returns the the 
#' contents of corresponding colums of `meta` except those including `age`, 
#' `pop`, and `country` and except the last two columns (`extrapolation` and 
#' `data_points`), which are often missing. 
#' 
#' @param data a `data.frame` returned by 
#' `read.csv2('WID_data_XX.csv')`, where `XX` is a 2-character ISO country or a 
#' 5- or 6-character ISO code for a region within a country. 
#' 
#' @param meta a `data.frame` returned by 
#' `read.csv2('WID_metadata_XX.csv')`, where `XX` is a 2-character ISO country 
#' or a 5- or 6-character ISO code for a region within a country.
#' 
#' @param cols2return columns of `meta` to return. If `missing`, the algorithm 
#' attempts to infer columns to return, as discussed with `code`, above. This 
#' is only needed if the matching content in the last two columns of `meta` are
#' desired.  
#'  
#' NOTE: `WIDcode` assumes that `XX` for `data` matches that of `metadata` but 
#' does nothing to check this assumption. 
#'  
#' @returns either a [list] or a [`data.frame`] gives the values of columns of 
#' `meta` that correspond to levels of `data[, code]`. If only one level of 
#' the selected columns of `meta` is found for each level of `code`, the object
#' returned is a `data.frame` with one row for each level of `code` in `data`. 
#' Otherwise, a list is returned with names being the levels of `code` in 
#' `data`. 
#' 
#' @export
#'
#' @examples
#' ageCodes <- WIDcodes('age', DE_BYdat, DE_BYmeta)
#' popCodes <- WIDcodes('pop', DE_BYdat, DE_BYmeta)
#' varCodes <- WIDcodes('variable', DE_BYdat, DE_BYmeta)
#' ageExtrap <- WIDcodes('age', DE_BYdat, DE_BYmeta, 
#'                 c('extrapolation', 'data_points'))
#' # ageExtrap is a list, 
#' # because DE_BYmeta[, c('extrapolation', 'data_points')] are all NAs. 
#' 
#' \dontrun{
#' WIDcodes('percentile', DE_BYdat, DE_BYmeta)
#' # throws an error, because 'percentile' is not in names(DE_BYmeta)
#' }
#' 
#' @keywords manip 
WIDcodes <- function(code='age', data, meta, cols2return){
  ##
  ## 1. table(data[, code])
  ##
  if(missing(data)){
    stop('Argument data is required for WIDcodes; is missing.')
  }
  if(missing(meta)){
    stop('Argument meta is required for WIDcodes; is missing.')
  }
  if(!(code %in% names(data))){
    stop('code = ', code, ' not in names(data) = ', 
         paste(names(data), collapse=', '))
  }
  codes <- table(data[, code])
  Codes <- names(codes)
  nCodes <- length(Codes)
  ##
  ## 2. find names(meta) that describe code
  ##
  if(missing(cols2return)){ 
    descs <- grep(code, names(meta), value=TRUE)
    k <- length(descs)
    if(k<1){
      stop('code = ', code, ' not found in names(meta) = ', 
         paste(names(meta), collapse=', '))
    }
    if(k<2){
      ctry <- grep('country', names(meta))
      ag <- grep('age', names(meta))
      pp <- grep('pop', names(meta))
      descs <- unique(c(descs, utils::head(names(meta), -2)[-c(ctry, ag, pp)]))
    } 
  } else {
    descs <- cols2return
  }
  k <- length(descs)
  cd <- which(descs == code)
  if(length(cd)<1){
      descs <- c(code, descs)
  } else {
      descs <- c(code, descs[-cd])
  }
  ##
  ## 3. find each code in meta and see if the corresponding descriptions in meta
  ##    are unique for each code
  ##
  Descs <- vector('list', nCodes)
  names(Descs) <- Codes
  Dc <- Descs
  for(i in 1:nCodes){
    seli <- (meta[, code] == Codes[i])
    desci <- meta[seli, descs]
    Descij <- vector('list', k)
    for(j in 1:k){
      Descij[[j]] <- table(desci[, j])
    }
    Descs[[i]] <- Descij
    Dc[[i]] <- sapply(Descij, length)
  }
  ## 
  ## 4. Are all descriptions unique? 
  ##
  Dc. <- table(unlist(Dc))
  if(length(Dc.)<2){
    for(i in 1:nCodes){
      Di <- sapply(Descs[[i]], names)
      Descs[[i]] <- c(Di[1], as.numeric(Descs[[i]][1]), Di[-1])
    }
    De <- matrix(unlist(Descs), nCodes, byrow=TRUE)
    rownames(De) <- Codes
    colnames(De) <- c(descs[1], 'count', descs[-1])
    De. <- as.data.frame(De)
    De.[[2]] <- as.integer(codes)
    Descs <- De. 
  }
  ##
  ## 5. Done
  ##  
  Descs
}
