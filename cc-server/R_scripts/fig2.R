
library(dplyr)
library(jsonlite)
library(tidyverse)

read_exp_json <- function(fname) {
  df <- fromJSON(fname)
  # extract benchmark data
  df2 <- data.frame(df$benchmarks)
  # let's break exp data into columns
  df2[c('runtime', 'libcall', 'datatype', 'problemsize', 'timer')]  <- str_split_fixed(df2$run_name, '/', 5)
  df2[c('namespace', 'stlfunc')]  <- str_split_fixed(df2$libcall, '::', 2)
  df2$problemsize <- as.numeric(df2$problemsize)
  df2
}

read_json_files <- function(its=1) {
  base_dir <- "./results/fig2/"
  fnames <- list.files(base_dir, pattern = paste0("its\\_",its,"\\.json"), recursive = TRUE)
  fnames <- paste0(base_dir, fnames)
  df <- NA
  for(fname in fnames) {
    print(paste("reading", fname))
    df1 <- read_exp_json(fname)
    if( ! is.data.frame(df) ) {
      df <- df1
    } else {
      df <- rbind(df, df1)
    }
  }

  df <- df %>%
    dplyr::mutate(runtime = ifelse(runtime == "IntelLLVM-TBB", "ICC-TBB", runtime)) %>%
    dplyr::mutate(runtime = ifelse(runtime == "GNU-HPX", "GCC-HPX", runtime)) %>%
    dplyr::mutate(runtime = ifelse(runtime == "GNU-SEQ", "GCC-SEQ", runtime)) %>%
    dplyr::mutate(runtime = ifelse(runtime == "GNU-OMP", "GCC-GNU", runtime)) %>%
    dplyr::mutate(runtime = ifelse(runtime == "GNU-TBB", "GCC-TBB", runtime)) %>%
    dplyr::mutate(runtime = ifelse(runtime == "NVHPC-OMP", "NVC-OMP", runtime))
}


df1 <- read_json_files(1)

p1 <- ggplot(df1, aes(x=problemsize, y=real_time, color=runtime)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_point() +
  geom_line() +
  ggtitle("for_each, iterations=1") +
  ylab("Time [ns]") +
  xlab("Problem size (#elements)") +
  theme_bw() +
  theme(
    legend.justification = c(1, 0),
    legend.position = c(0.98, 0.02),
    legend.title=element_blank()
  )

plot(p1)

pdf("figures/fig2a_for_each_its1.pdf", width=7, height=5)
plot(p1)
dev.off()


df2 <- read_json_files(1000)

p2 <- ggplot(df2, aes(x=problemsize, y=real_time, color=runtime)) +
  scale_x_log10() +
  scale_y_log10() +
  geom_point() +
  geom_line() +
  ggtitle("for_each, iterations=1000") +
  ylab("Time [ns]") +
  xlab("Problem size (#elements)") +
  theme_bw() +
  theme(
    legend.justification = c(1, 0),
    legend.position = c(0.98, 0.02),
    legend.title=element_blank()
  )

plot(p2)

pdf("figures/fig2b_for_each_its1000.pdf", width=7, height=5)
plot(p2)
dev.off()
