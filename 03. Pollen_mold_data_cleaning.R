library(tidyverse)

#pollen data cleaning
dat_1<- read_csv("/work/jessebell/puvvula/AQ_asthma/pollen_dat/out19merged.csv")

colnames(dat_1) <- gsub(" ", "_", colnames(dat_1))


test <- dat_1 %>% pivot_longer(cols = c(2:1099),
                             names_to = 'type_II', 
                             values_to = 'value') %>%
  separate(type_II, sep = '_', into = c('date', 'type'))


#2016
dataset.a<-test %>% group_by(date, var) %>% summarise(count=sum(value))
#2017
dataset.b <- test %>% group_by(date, var) %>% summarise(count=sum(value))
#2019
dataset.c <- test %>% group_by(date, var) %>% summarise(count=sum(value))
#2018
dataset.d <- read_csv("/work/jessebell/puvvula/AQ_asthma/pollen_dat/out18merged.csv")

#final dataset
data.final<- union_all(dataset.a,dataset.b) %>% 
  union_all(dataset.c) %>%
  union_all(dataset.d)

write_csv(data.final, "/work/jessebell/puvvula/AQ_asthma/pollen_dat/pollen_final.csv")

#mold data cleaning

m1<- read_csv("/work/jessebell/puvvula/AQ_asthma/mold_dat/input18mold.csv")

#2016
mold.a <- m1 %>% pivot_longer(cols = c(2:365))
#2017
mold.b <- m1 %>% pivot_longer(cols = c(2:365))
#2018
mold.c <- m1 %>% pivot_longer(cols = c(2:19))

#final data
mold.final<- union_all(mold.a,mold.b) %>% 
  union_all(mold.c)

write_csv(mold.final, "/work/jessebell/puvvula/AQ_asthma/mold_dat/mold_fin.csv")
