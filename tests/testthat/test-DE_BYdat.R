test_that("DE_BYdat", {
  ctry <- table(rep("DE-BY", 24L))
  expect_equal(table(DE_BYdat$country), ctry)
#
  vari <- table(rep(c('sfiinct992', 'sptinct992'), 12))
  expect_equal(table(DE_BYdat$variable), vari)
#
  ptile <- table(rep(c('p90p100', 'p95p100', 'p99.5p100', 
             'p99.99p100', 'p99.9p100', 'p99p100'), 4))  
  expect_equal(table(DE_BYdat$percentile), ptile) 
#
  age <- table(rep(992, 24))
  expect_equal(table(DE_BYdat$age), age) 
#   
  pop <- table(rep('t', 24))
  expect_equal(table(DE_BYdat$pop), pop) 
})
