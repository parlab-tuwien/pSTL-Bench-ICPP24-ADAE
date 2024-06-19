
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
  base_dir <- "./results/fig5b/"
  fnames <- list.files(base_dir, pattern = paste0("\\.json"), recursive = TRUE)
  fnames <- paste0(base_dir, fnames)
  df <- NA
  for(fname in fnames) {
    print(paste("reading", fname))
    df1 <- read_exp_json(fname)
    # Take the number of threads from the filename .../n_threads/...
    n_threads <- str_extract(fname, "([0-9]+)_threads")
    n_threads <- str_extract(n_threads, "([0-9]+)")
    n_threads <- as.numeric(n_threads)
    # Get the number of threads as a number
    df1$threads <- as.numeric(n_threads)
    if (!is.data.frame(df)) {
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

# Plot for iterations=1
df1 <- read_json_files(1)

# Get the reference time from GCC-GNU
ref_time <- df1 %>%
  filter(runtime == "GCC-SEQ") %>%
  filter(threads == 1) %>%
  select(real_time) %>%
  pull()

# Calculate the speedup
df1 <- df1 %>%
  mutate(speedup = ref_time / real_time)

# Ideal speedup line
max_threads <- max(df1$threads, na.rm = TRUE)
ideal_speedup <- data.frame(threads = seq(1, max_threads, 1), speedup = seq(1, max_threads, 1))

# Plot the speedup
p1 <- ggplot(df1, aes(x = threads, y = speedup, color = runtime)) +
  geom_line(data = ideal_speedup, aes(x = threads, y = speedup), color = "black", linetype = "dashed") +
  scale_x_log10() +
  geom_point() +
  geom_line() +
  ggtitle("incl_scan") +
  ylab("Speedup (vs GCC-SEQ)") +
  xlab("#threads") +
  theme_bw() +
  theme(
    legend.justification = c(1, 0),
    legend.position = c(0.98, 0.02),
    legend.title = element_blank()
  )


ymin <- 0
ymax <- max(df1$speedup, na.rm=TRUE) * 1.1
p1 <- p1 + coord_cartesian(ylim=c(ymin, ymax))

plot(p1)

pdf("figures/fig5b_incl_scan.pdf", width=7, height=5)
plot(p1)
dev.off()
