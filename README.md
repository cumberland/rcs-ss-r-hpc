# Westgrid/Compute Canada Summer School R in HPC Environments

This repository is prepared in support of the Westgrid/Compute Canada Research Computing Services course entitled "R in HPC environment" linked at: https://westgrid.github.io/calgarySummerSchool2019/r_in_hpc

## Introduction

The format of this visit will be to walk through the process/machinery and sample code to run a reasonably standard parameter search style simulation study using R and a series of helpers on high performance compute infrastructure. 

## Goals

By the end of this session you should have all you need to walk off and start your own project of a similar design.

## Outline

The technical approach:

1. Generate a simulation space/parameter set to be analyzed.
2. Write a simulation agent to consume parameter sets.
	1. This agent will fetch a parameter set.
	2. Generate a synthetic data set.
	3. Model this dataset and assess confounding between a key covariate and a treatment effect.
	4. Extract results from the R model output and push them back to a results store.
3. Write a minimal dashboard to monitor the simulation under way and summarize some results as they progress.

## Resources

We'll need...

1. Docker 
	- Optionally Docker Cloud or something like that for auto-building of images.  
2. Git 
	- Optionally GitHub for collaboration, and automation things. 
3. R
	- Lots of people like R-Studio.  It's very good.  I use a text editor (Vim and or Sublime Text)
4. MySQL/MariaDB, or a Message Queue, or something with ACID Transactions. 
	- We'll look at MariaDB and Amazon SQS service examples.  
5. SSH Client
	- Nothing fancy needed.  Git-Bash is good on Windows, CC has a recommendation, OSX and Linux just use the default terminal. 




