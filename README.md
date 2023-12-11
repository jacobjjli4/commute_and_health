# Commuting and Health Project
Course paper for ECO481: Health and Economic Inequality. Fall 2023. Taught by Prof. Michael Stepner.

How does time spent commuting affect one's health? 

## Abstract
The correlation between commute time and worse health outcomes is well-known, but what about the causal effect of commute duration on one's health? Using pooled cross-sectional data from the American Time Use Survey for 2009-2015, I present evidence to confirm the correlation between commute duration and health outcomes and behaviours. I attempt an instrumental variables analysis using Uber's staggered entry across U.S. Metropolitan Statistical Areas between 2011 and 2015 as an instrument for commute duration. My results show no significant causal effect between commute duration and health outcomes.

## Data and Code
Data sources are documented and stored in `data/raw`. All code is written in the Stata language. Required Stata packages are documented in `stata-requirements.txt`. The main do-file that runs all the code is `build.do`, which calls three do-files stored in `code/` that load, clean, and analyze the data. The cleaned data, log files, figures, and graphs are not tracked in version control. You can recreate them by running the code.

All numbers reported in the paper are exported to the `results/results.yaml` file or to one of the figures and tables.


