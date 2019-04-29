#!/usr/bin/env Rscript

library(infercnv)

infercnv_obj = readRDS('03_normalized_by_depth.infercnv_obj')


## plot meanvar first

mean_var_table = infercnv:::.get_mean_var_table(infercnv_obj)

logm = log(mean_var_table$m + 1)
logv = log(mean_var_table$v + 1)
mean_var_spline = smooth.spline(logv ~ logm)

smoothScatter(logm, logv)
r = range(logm)
x=seq(r[1], r[2], 0.1)
points(x, predict(mean_var_spline, x)$y, col='magenta', t='l')


## plot dropout 

mean_vs_p0_table <- infercnv:::.get_mean_vs_p0_table(infercnv_obj)
dropout_logistic_params <- infercnv:::.get_logistic_params(mean_vs_p0_table)


mean_vs_p0_table$logm <- log(mean_vs_p0_table$m)

smoothScatter(mean_vs_p0_table$logm, mean_vs_p0_table$p0)

r = range(mean_vs_p0_table$logm[is.finite(mean_vs_p0_table$logm)])

s = dropout_logistic_params$spline
x=seq(r[1], r[2], 0.1)
points(x, predict(s, x)$y, col='orange')
