test_that("WIDcodes", {
  ageCodes <- WIDcodes('age', DE_BYdat, DE_BYmeta)
  expect_equal(names(ageCodes), 
      c('age', 'count', 'shortage', 'longage'))
  expect_true(inherits(ageCodes, 'data.frame'))

  popCodes <- WIDcodes('pop', DE_BYdat, DE_BYmeta)
  expect_equal(names(popCodes), 
               c('pop', 'count', 'shortpop', 'longpop'))
  expect_true(inherits(popCodes, 'data.frame'))
  
# varCodes <- WIDcodes('variable', DE_BYdat, DE_BYmeta)
  expect_true(inherits(WIDcodes('variable', DE_BYdat, DE_BYmeta), 
                       'data.frame'))
  
  ageExtrap <- WIDcodes('age', DE_BYdat, DE_BYmeta, 
                   c('extrapolation', 'data_points'))
  expect_equal(dimnames(ageExtrap), list('992', c('age', 'count')))

  expect_error(WIDcodes('percentile', DE_BYdat, DE_BYmeta))
  # throws an error, because 'percentile' is not in names(DE_BYmeta)
  
  # type 
  DE_BYdat$type <- substring(DE_BYdat$variable, 1, 1)
  DE_BYmeta$type <- substring(DE_BYmeta$variable, 1, 1)
  typeCodes <- WIDcodes('type', DE_BYdat, DE_BYmeta)
  expect_equal(names(typeCodes), 
               c('type', 'count', 'shorttype', 'longtype'))
  expect_true(inherits(typeCodes, 'data.frame'))
  
  # concept 
  DE_BYdat$concept <- substring(DE_BYdat$variable, 2, 6)
  DE_BYmeta$concept <- substring(DE_BYmeta$variable, 2, 6)
  conceptCodes <- WIDcodes('concept', DE_BYdat, DE_BYmeta)
  expect_equal(names(conceptCodes), 
      c('concept', 'count', "variable", "shortname", "simpledes", 
        "technicaldes", "shorttype", "longtype", "unit", "source", 
        "method", "type") )
  expect_true(inherits(conceptCodes, 'data.frame'))
})
