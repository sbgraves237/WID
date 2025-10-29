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
  expect_equal(names(ageExtrap), '992')
  expect_true(inherits(ageExtrap, 'list'))
  # ageExtrap is a list of length 1 with name '992' 
  # because DE_BYmeta[, c('extrapolation', 'data_points')] are all NAs. 
  expect_false(inherits(ageExtrap, 'data.frame'))
  
  expect_error(WIDcodes('percentile', DE_BYdat, DE_BYmeta))
  # throws an error, because 'percentile' is not in names(DE_BYmeta)
  
  DE_BYdat$type <- substring(DE_BYdat$variable, 1, 1)
  DE_BYmeta$type <- substring(DE_BYmeta$variable, 1, 1)
  typeCodes <- WIDcodes('type', DE_BYdat, DE_BYmeta)
  expect_equal(names(typeCodes), 
               c('type', 'count', 'shorttype', 'longtype'))
  expect_true(inherits(typeCodes, 'data.frame'))
})
