#CH3 dplyr

library(tidyverse)
library(nycflights13)

#Filter

jan1 <- filter(flights, month == 1, day == 1)
dec25 <- filter(flights, month == 12, day == 25)
dec25

filter(flights, month == 11 | month == 12)
filter(flights, month %in% c(11,12))

#EXERCIES p49

#1.
filter(flights, arr_delay >= 120)
filter(flights, dest == 'IAH' | dest == 'HOU')
filter(flights, carrier %in% c('UA','AA','DL'))
filter(flights, month %in% c(7:9))
filter(flights, arr_delay >= 120, dep_delay <= 0)
filter(flights, dep_delay >= 60, (dep_delay - arr_delay) >= 30)
filter(flights, dep_time <= 0600 | dep_time == 2400)

#2.
filter(flights, between(month, 7, 9))

#3.
View(filter(flights, is.na(dep_time)))

#4.
NA ^ 0
NA | TRUE
FALSE & NA
FALSE & 1

# arrange()

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

df <- tibble(x = c(5,2,NA))
arrange(df, x)
arrange(df, desc(x))

#EXERCISES p51
# 1.
arrange(flights, desc(is.na(dep_time), dep_time))

# 2.
arrange(flights, desc(dep_delay))
arrange(flights, desc(arr_delay))
arrange(flights, dep_time)

# 3.
View(arrange(flights, air_time))

# 4.
View(arrange(flights, distance))
View(arrange(flights, desc(distance)))


# select()

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))
select(flights, starts_with('sched'))
select(flights, ends_with('time'))
select(flights, contains('arr'))

rename(flights, tail_num = tailnum)

select(flights, air_time, time_hour, everything())

#EXERCISES p54
# 2.
select(flights, year, month, day, month)

# 3.
vars <- c('year' ,'month','day','dep_delay','arr_delay')
select(flights, one_of(vars))

# 4.
select(flights, contains('TIME'))
select(flights, contains('TIME', ignore.case = FALSE))

# mutate()

flights_sml <- select(flights, year:day, 
                      ends_with('delay'),
                      distance,
                      air_time)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour =gain / hours)

transmute(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour =gain / hours)

transmute(flights,
          dep_time,
          hour = dep_time %/% 100,
          minute = dep_time %% 100)

y <- c(1,2,2,NA,8,3)
min_rank(y)
min_rank(desc(y))
row_number(y)
dense_rank(y)
percent_rank(y)
cume_dist(y)
