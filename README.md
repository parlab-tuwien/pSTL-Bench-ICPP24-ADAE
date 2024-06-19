# ICPP 2024 ADAE - Exploring Scalability in C++ Parallel STL Implementations

This repository contains the scripts used to generate the data and plots for the paper "Exploring Scalability in C++ Parallel STL Implementations" submitted to ICPP 2024.

## Repository Structure

The repository is structured as follows:

- `cc-jupyter/`: Jupyter notebooks to create a lease and execute an image in Chamaleon Cloud. The notebooks should be uploaded to the Chamaleon Cloud Jupyter environment and executed there. Remember to change the `PROJECT_NAME` and other variables to match your project.

- `cc-server/`: Collection of scripts that you should find when `ssh` into the Chamaleon Cloud server. The scripts are numbered and grouped by experiment. There are four types of scripts:
  - `00_run_all.sh`: Script to run all the experiments. Execute this, wait for it to finish and then download the results.
  - `01_compile.sh`: Script to compile the pSTL-Bench suite with all the different compilers and backends supported in the Chamaleon Cloud image. The CC image already has the binaries compiled and ready to execute. If you want to compile from scratch, first remove the binaries with `rm -rf pSTL-Bench/build-*`.
  - `*_experiments.sh`: Scripts to execute the experiments for a specific figure in the paper. After running each of these scripts, you can find a folder `results/figX/` with the results of the experiments in `json` format.
  - `*_plot.sj`: Scripts to generate the plots for a specific figure in the paper. These scripts should be executed after running the corresponding `*_experiments.sh` script. The plots will be saved as `figures/figX`.

## Estimated time of completion (ETC)

| Script                     | ETC    |
|----------------------------|--------|
| `00_run_all.sh`            |        |
| `01_compile.sh`            | 5m     |
| `02a_Fig2_experiments.sh`  | 1h 30m |
| `03a_Fig3_experiments.sh`  | 4h     |
| `04a_Fig5a_experiments.sh` | 10m    |
| `04c_Fig5b_experiments.sh` | 10m    |
| `05a_Fig7a_experiments.sh` | 1h     |
| `05c_Fig7b_experiments.sh` | 1h     |
| `*_plot.sh`                | 2s     |

**Note**: If binaries already exist, step `01_compile.sh` should take only a few seconds.

## Remarks

- The full set of experiments takes around 6 hours to complete.

- pSTL-Bench uses the Google Benchmark library to execute the benchmarks. This library has an option `--benchmark_min_time` that can be used to increase the minimum time each benchmark is executed. Despite that the experiments in the paper use a minimum time of 5 seconds, these scripts use a minimum time of 1 second to reduce the time needed to complete the experiments. You use the environment variable `PSTL_MIN_TIME` to change this value (e.g. `PSTL_MIN_TIME=5s` or `PSTL_MIN_TIME=100x`). **Important**: The higher the value, the longer the experiments will take to complete.
