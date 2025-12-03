test_that("WIDcodes", {
  ageCodes <- WIDcodes('age', DE_BYdat, DE_BYmeta)
  expect_equal(names(ageCodes), 
      c('age', 'count', 'pct', 'shortage', 'longage'))
  expect_true(inherits(ageCodes, 'data.frame'))

  popCodes <- WIDcodes('pop', DE_BYdat, DE_BYmeta)
  expect_equal(names(popCodes), 
               c('pop', 'count', 'pct', 'shortpop', 'longpop'))
  expect_true(inherits(popCodes, 'data.frame'))
  
# varCodes <- WIDcodes('variable', DE_BYdat, DE_BYmeta)
  expect_true(inherits(WIDcodes('variable', DE_BYdat, DE_BYmeta), 
                       'data.frame'))
  
  ageExtrap <- WIDcodes('age', DE_BYdat, DE_BYmeta, 
                   c('extrapolation', 'data_points'))
  expect_equal(dimnames(ageExtrap), 
      list('992', c('age', 'count', 'pct', 'extrapolation', 'data_points')))

  expect_error(WIDcodes('percentile', DE_BYdat, DE_BYmeta))
  # throws an error, because 'percentile' is not in names(DE_BYmeta)
  
  # type 
  DE_BYdat$type <- substring(DE_BYdat$variable, 1, 1)
  DE_BYmeta$type <- substring(DE_BYmeta$variable, 1, 1)
  typeCodes <- WIDcodes('type', DE_BYdat, DE_BYmeta)
  expect_equal(names(typeCodes), 
               c('type', 'count', 'pct', 'shorttype', 'longtype'))
  expect_true(inherits(typeCodes, 'data.frame'))
  
  # concept 
  DE_BYdat$concept <- substring(DE_BYdat$variable, 2, 6)
  DE_BYmeta$concept <- substring(DE_BYmeta$variable, 2, 6)
  conceptCodes <- WIDcodes('concept', DE_BYdat, DE_BYmeta)
  expect_equal(names(conceptCodes), 
      c('concept', 'count', 'pct', "variable", "shortname", "simpledes", 
        "technicaldes", "shorttype", "longtype", "unit", "source", 
        "method", "extrapolation", "data_points", "type") )
  expect_true(inherits(conceptCodes, 'data.frame'))
  
  ageC2 <- WIDcodes('age', DE_BYdat, DE_BYmeta, 'concept')
  ageC2a <- WIDcodes('age', DE_BYdat, DE_BYmeta, c('age', 'concept'))
  # ageC2 has attr(ageC2, 'nonunique') = list('992' = table(DE_BYmeta$concept)
  # different from ageCodes, because DE_BYmeta has changed. 
  ageC2nonu <- attr(ageC2, 'nonunique')
  ccpt <- rep(1, 2)
  names(ccpt) <- DE_BYmeta$concept
  ageC2nonu1 <- list('992' = list(concept=ccpt))
  expect_equal(ageC2nonu, ageC2nonu1)
})
