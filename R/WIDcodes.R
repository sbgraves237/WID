#' WIDcodes  
#'
#' @description
#' Extract definitions from a `_metadata_` file for variables in a 
#' corresponding `_data_` file in the 
#' [World Inequalty Database (WID)](https://wid.world/). Information about 
#' what data are available and how to interpret them is is available in the 
#' [WID codes dictionary](https://wid.world/codes-dictionary). 
#' 
#' @param code name (character vector of length 1) of a column of `data` for 
#' which matching information in `meta` is desired. If 
#' `grep(code, names(meta))` finds nothing, `WIDcodes` throws an error. 
#' Otherwise it returns the `count` (number) and `pct` of matches for each 
#' level of `code` in `data` followed by the corresponding information in 
#' `meta`. If `length(grep(code, names(meta)))` > 1, `WIDcodes` returns the 
#' corresponding content of the matching columns of `meta`. 
#' 
#' In particular, 
#' * `WIDcode('age', ...)` returns matching columns of `shortage` and `longage`. 
#' * `WIDcode('pop', ...)` returns matching columns of `shortpop` and `longpop`.
#' * `WIDcode('country', ...)` returns matching columns of `countryname`.
#' 
#' If `length(grep(code, names(meta)))` = 1, `WIDcodes` returns the contents
#' of corresponding columns of `meta` except those including `age`, `pop`, and 
#' `country` and except the last two columns (`extrapolation` and 
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
#' @returns a [`data.frame`] describing the different values of `code` found in 
#' `data` and and `meta`. The first three columns are for `code`, `count`, 
#' and `pct`. The latter are from the `cols2return` in `meta`. 
#' 
#' The name of the first column is the value of `code`. For example, the first 
#' column of the `data.frame` returned by `WIDcodes('age', ...)` is `age`. 
#' The next column is `count = table(data[, code)`. This is followed by 
#' `pct = as.numeric(format(100*count/sum(count)))`. 
#' 
#' This is followed by character variables giving the most common value of 
#' each of `cols2return` in `meta`. We might naively expect that the value of
#' each of `cols2return` in `meta` would be unique. If that is not the case, 
#' then "(*)" is appended to the most common value, and the `data.frame` 
#' returned by `WIDcodes` will have `attr(*, 'nonunique')` being a list of 
#' tables of frequencies of all values of each nonunique of the `cols2return` 
#' for each `code` in `meta`. 
#' 
#' @seealso [DE_BYdat] for a discussion of the data items in WID data. 
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
#' # to get typeCodes, we must first add it to both DE_BYdat and DE_BYmeta
#' DE_BYdat$type <- substring(DE_BYdat$variable, 1, 1)
#' DE_BYmeta$type <- substring(DE_BYmeta$variable, 1, 1)
#' typeCodes <- WIDcodes('type', DE_BYdat, DE_BYmeta)
#' 
#' # Let's also get concept 
#' DE_BYdat$concept <- substring(DE_BYdat$variable, 2, 6)
#' DE_BYmeta$concept <- substring(DE_BYmeta$variable, 2, 6)
#' conceptCodes <- WIDcodes('concept', DE_BYdat, DE_BYmeta)
#' 
#' \dontrun{
#' WIDcodes('percentile', DE_BYdat, DE_BYmeta)
#' # throws an error, because 'percentile' is not in names(DE_BYmeta)
#' }
#' # Will have attr(ageC2, 'nonunique') = table(DE_BYmeta$concept)
#' # here but not before, because DE__BYmeta has changed. 
#' ageC2 <- WIDcodes('age', DE_BYdat, DE_BYmeta, 'concept')
#' 
#' @keywords manip 
WIDcodes <- function(code, data, meta, cols2return){
  ##
  ## 1. Check arguments 
  ##
  if(missing(code)){
    stop('Argument code is required for WIDcodes; is missing.')
  }
  if(missing(data)){
    stop('Argument data is required for WIDcodes; is missing.')
  }
  if(missing(meta)){
    stop('Argument meta is required for WIDcodes; is missing.')
  }
  if(length(code) != 1){
    stop('length(code) = ', length(code), '; must be 1.') 
  }
  if(!(code %in% names(data))){
    stop('code = ', code, ' not in names(data) = ', 
         paste(names(data), collapse=', '))
  }
  if(!(code %in% names(meta))){
    stop('code = ', code, ' not in names(meta) = ', 
         paste(names(meta), collapse=', '))
  }
  ##
  ## 2. table(data[, code])
  ##
  codes0 <- table(data[, code], useNA='always')
  codes <- codes0[codes0!=0] # useNA='always' > tail(codes0, 1) = 0; delete
  pct <- as.numeric(format(100*codes / sum(codes)))
  Codes <- names(codes)
  nCodes <- length(Codes)
  out1 <- data.frame(code=Codes, count=as.integer(codes), pct=pct)
  colnames(out1)[1] <- code
  ##
  ## 3. find names(meta) that describe code
  ##
  if(missing(cols2return)){ 
    desc0 <- grep(code, names(meta), value=TRUE)
    descs <- desc0[desc0 != code]
    k <- length(descs)
    if(k<2){
      ctry <- grep('country', names(meta), value=TRUE)
      ag <- grep('age', names(meta), value=TRUE)
      pp <- grep('pop', names(meta), value=TRUE)
      no <- (names(meta) %in% c(code, ctry, ag, pp))
      descs <- names(meta)[!no]
    } 
  } else {
    chk_c2r <- (cols2return %in% names(meta))
    if(any(!chk_c2r)){
      ermsg1 <- 'some calls2return not found in names(meta)\n'
      ermsg2 <- paste0('call2return not found = ', 
          paste(cols2return[!chk_c2r], collapse=', '), '\n')
      ermsg3 <- paste0('names(meta) = ', paste(names(meta), ', '))
      stop(ermsg1, ermsg2, ermsg3)
    }
    descs <- cols2return
  }
  k <- length(descs)
  outMeta <- matrix(NA, nCodes, k)
  dimnames(outMeta) <- list(Codes, descs)
  ##
  ## 4. find each code in meta and see if the corresponding descriptions in 
  ##    meta are unique for each code.
  ##
  Descs <- vector('list', nCodes)
  names(Descs) <- Codes
  for(ic in seq(length=nCodes)){
    seli <- (meta[, code] == Codes[ic])
    desci <- meta[seli, descs, drop=FALSE]
    Desci <- do.call(table, desci)
    dimi <- dim(Desci)
    Dimi <- dimnames(Desci)
    Descsi <- list()

    for(jci in seq(length=k)){
      if(dimi[jci]<1){
        outMeta[ic, jci] <- NA 
      } else {
        if(dimi[jci]<2){
          outMeta[ic, jci] <- Dimi[[jci]]
        } else {
          Dimij <- apply(Desci, jci, sum)
          Dimij_ <- list(Dimij)
          names(Dimij_) <- descs[jci]          
          Descs[[ic]] <- c(Descs[[ic]], Dimij_)
          outMeta[ic, jci] <- paste0(names(Dimij)[which.max(Dimij)], ';*')
        }
      }
    } 
  }
  out2 <- cbind(out1, outMeta)
  ## 
  ## 5. For which variables in descs are descriptions in meta unique? 
  ##
  nDescs <- sapply(Descs, length)
  if(max(nDescs)>0)attr(out2, 'nonunique') <- Descs[nDescs>0]
  ##
  ## 6. Done
  ##  
  out2
}
