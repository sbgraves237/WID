test_that("DE_BYdat", {
  expect_equal(table(DE_BYdat$country), c(DE_BY=24))
  expect_equal(table(DE_BYdat$variable), c(DE_BY=24))
  expect_equal(table(DE_BYdat$variable), c(sfiinct992=12, sptinct992=12))
  expect_equal(table(DE_BYdat$percentile), c(sfiinct992=12, sptinct992=12))

  ptile <- c(p90p100=4, p95p100=4, p99.5p100=4, 
             p99.99p100=4, p99.9p100=4, p99p100=4)  
  expect_equal(table(DE_BYdat$percentile), ptile) 
  expect_equal(table(DE_BYdat$age), c(992=24)) 
  expect_equal(table(DE_BYdat$pop), c(t=24))
})
