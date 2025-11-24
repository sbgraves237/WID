test_that("WIDcountries", {
  expect_equal(dim(WIDcountries[c('DE', 'US'), ]), c(2, 6))

# countries with data on internal states or regions
  alphaGT2 <- with(WIDcountries, alpha2[nchalpha2>2])
  expect_equal(class(alphaGT2), 'character')
  expect_gte(length(alphaGT2), 105)
  
  alphaGT2_ <- table(substring(alphaGT2, 1, 2))
  expect_equal(class(alphaGT2_), 'table')
  expect_gte(length(alphaGT2_), 25) 

  WID_C <-subset(WIDcountries, (substring(alpha2, 1, 1)== 'C') & (nchalpha2>2))
  expect_equal(class(WID_C), 'data.frame')
  expect_gte(nrow(WID_C), 2) 
  
  WID_O <- subset(WIDcountries, (substr(alpha2, 1, 1)== 'O') & (nchalpha2>2),
                  titlename)
  expect_equal(class(WID_O), 'data.frame')
  expect_gte(nrow(WID_O), 20) 
})
