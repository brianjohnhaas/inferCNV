#!/usr/bin/env Rscript

library(infercnv)

infercnv_obj = readRDS('03_normalized_by_depth.infercnv_obj')

mean_vs_p0_table <- infercnv:::.get_mean_vs_p0_table(infercnv_obj)
dropout_logistic_params <- infercnv:::.get_logistic_params(mean_vs_p0_table)

s = dropout_logistic_params$spline
mean_vs_p0_table$logm <- log(mean_vs_p0_table$m)

dropout_prob <- predict(dropout_logistic_params$spline, mean_vs_p0_table$logm)$y[1]

smoothScatter(mean_vs_p0_table$logm, mean_vs_p0_table$p0)

r = range(mean_vs_p0_table$logm[is.finite(mean_vs_p0_table$logm)])

x=seq(r[1], r[2], 0.1)
points(x, predict(s, x)$y, col='orange')
