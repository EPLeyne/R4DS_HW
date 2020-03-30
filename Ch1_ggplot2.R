library(tidyverse)

mpg

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy))

#Basic recipe
ggplot(data = <DATA>) +
  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# Colour
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, colour = class))

# Size (Not advised for discrete variables)
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# Alpha
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# Shape
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Colour choice, doesn't denote any information, just sets the colour
# Note the move of the closing brackets
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy), colour = 'blue')

# EXERCISES
#2
?mpg
str(mpg)

#3.
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, colour = cty))

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, size = cty))

ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, shape = cty))

#4.
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, size = displ))

#5.
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, stroke = 10))

#6. 
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))


#Facets

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)


ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

# EXERCISES
#1.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ cty, nrow = 2)

#2. 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))

#3.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

#4. 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

#5. 
?facet_wrap
?facet_grid

#Geometric Objects

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, colour = drv)) +
  geom_point((mapping = aes(x = displ, y = hwy, colour = drv)))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, colour = drv),
              show.legend = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + #Same as above
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(colour = class)) +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(colour = class)) +
  geom_smooth(data = filter(mpg, class == 'subcompact'), #Makes the curve only for the subcompact
              se = FALSE)                                #Removes the se bars

#EXERCISES p20
# 1.
# ggplot(data = mpg) +
#   geom_line()
# ggplot(data = mpg) +
#   geom_boxplot()
# ggplot(data = mpg) +
#   geom_histogram()
# ggplot(data = mpg) +
#   geom_area()
# 
# 2.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

#6.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy)) +
  geom_smooth(aes(x = displ, y = hwy, group = drv), se = FALSE, show.legend = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, colour = drv)) +
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, colour = drv)) +
  geom_smooth(aes(x = displ, y = hwy), se = FALSE)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, colour = drv)) +
  geom_smooth(aes(x = displ, y = hwy, linetype = drv), se = FALSE)

ggplot(data = mpg) +
  geom_point(aes(x = displ, y = hwy, colour = drv))

#STATISTICAL TRANSFORMATIONS

diamonds

#Bar plot at count (default)
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

demo <- tribble(
  ~a, ~b,
  'bar_1', 20,
  'bar_2', 30,
  'bar_3', 40
)

ggplot(data = demo) +
  geom_bar(mapping = aes(x = a, y = b), stat = 'identity')

#Bar plot as proportion 

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

#EXERCISES p26
#1.
ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = 'summary',
                  fun.ymin = min, 
                  fun.ymax = max,
                  fun.y = median)

#2.

ggplot(data = demo) +
  geom_bar(mapping = aes(x = a))
ggplot(data = demo) +
  geom_col(mapping = aes(x = a, y = b))

#5. 

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = ..prop..))

# Position Adjustments

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill= cut))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill= clarity))

ggplot(data = diamonds,
  mapping = aes(x = cut, fill = clarity)) +
  geom_bar(alpha = 1/5, position = 'identity')

ggplot(data = diamonds,
  mapping = aes(x = cut, colour = clarity)) +
  geom_bar(fill = NA, position = 'identity')

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),
           position = 'fill')

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity),
           position = 'dodge')

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),
               position = 'jitter')

ggplot(data = mpg) +
  geom_jitter(mapping = aes(x= displ, y = hwy))

#EXERCISES p31
#1.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point()

#3.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count()

#4.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot()

