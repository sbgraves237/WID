test_that("WIDcodes", {
  ageCodes <- WIDcodes('age', DE_BYdat, DE_BYmeta)
  expect_equal(names(ageCodes), 
      c('age', 'count', 'shortage', 'longage'))
  
  popCodes <- WIDcodes('pop', DE_BYdat, DE_BYmeta)
  expect_equal(names(popCodes), 
               c('pop', 'count', 'shortpop', 'longpop'))
  
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
})
