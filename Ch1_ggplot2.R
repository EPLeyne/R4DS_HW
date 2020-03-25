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

