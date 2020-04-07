#CH3 dplyr

library(tidyverse)
library(nycflights13)
library(Lahman)

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

# EXERCISES p58
#1.
transmute(flights, dep_time_min_since_midnight = ((dep_time %/% 100)*60) + (dep_time %% 100))
transmute(flights, sched_dep_time_min_since_midnight = ((sched_dep_time %/% 100)*60) + (sched_dep_time %% 100))

#2.
flights_bit <- flights %>% 
  select(air_time, arr_time, dep_time) %>% 
  mutate(calc_timings = arr_time - dep_time) %>% 
  mutate(diff = air_time - calc_timings) %>% 
  filter(calc_timings != 0)

#3.
flight_delayed <- flights %>% 
  select(dep_time, sched_dep_time, dep_delay) %>% 
  mutate(calc_dep_time = sched_dep_time + dep_delay) %>% 
  mutate(diff = calc_dep_time - dep_time) %>% 
  filter(diff != 0)

#4.
delays <- mutate(flights, delay_ranking = min_rank(flights$dep_delay)) %>% 
  arrange(desc(delay_ranking))

#5.
1:3 + 1:10

# summarise()

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_dest <- group_by(flights, dest)
delay <- summarise(by_dest, count = n(),
                   dist = mean(distance, na.rm = TRUE))
delay <- filter(delay, count > 20, dest != 'HNL')

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(count = n(),
            dist = mean(distance, na.rm = TRUE),
            delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(count > 20, dest != 'HNL')

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay))
ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(delay = mean(arr_delay, na.rm = TRUE), n = n())
ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

delays %>% 
  filter(n > 25) %>% 
  ggplot(mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10)

batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE))

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() +
  geom_smooth(se = FALSE)

batters %>% 
  arrange(desc(ba))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    #average delay
    avg_delay1 = mean(arr_delay, na.rm = TRUE),
    # average positive delay
    avg_delay2 = mean(arr_delay[arr_delay > 0], na.rm = TRUE)
  )

not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
    filter(r %in% range(r))

