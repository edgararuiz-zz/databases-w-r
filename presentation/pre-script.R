library(tidyverse)
library(gh)
library(purrr)
library(lubridate)
library(tidyverse)

from_cran <- tools:::CRAN_package_db()
packages <- from_cran[, 1:64] 
colnames(packages) <- tolower(colnames(packages))
colnames(packages) <- gsub(colnames(packages), pattern = " ", replacement = "_")
#saveRDS(packages, "packages.rds")


reverse <- packages %>%
  filter(package %in%  c("DBI", "dbplyr", "odbc")) %>%
  unite(reverse, c("reverse_suggests", "reverse_depends", "reverse_imports")) %>%
  select(reverse) %>%
  separate_rows(reverse) %>%
  group_by(reverse)  %>%
  summarise() %>%
  ungroup() %>%
  inner_join(
    packages,
    by = c("reverse" = "package")
  )

saveRDS(reverse, "reverse.rds")

# dbplyr_commits <- gh("/repos/tidyverse/dbplyr/commits", .limit = 1000)
# saveRDS(dbplyr_commits, "dbplyr_commits.rds")
# dbplyr_commits <- gh("/repos/rstudio/db.rstudio.com/commits", .limit = 1000)

cd <- dbplyr_commits %>%
  map_df(~tibble(commit_date = .x$commit$committer$date))

cd %>%
  mutate(yr = year(commit_date)) %>%
  group_by(yr) %>%
  tally()


cd <- dbplyr_commits %>%
  map_df(~tibble(commit_date = .x$commit$committer$date))

cd %>%
  mutate(yr = year(commit_date)) %>%
  group_by(yr) %>%
  tally()








