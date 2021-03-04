# ctrl- L to Clear screen
# ctrl + enter to Run selection
devtools::install_github("kjhealy/socviz")
library(tidyverse)
library(socviz)
library(here)
library(gapminder)

gapminder

# Examples https://www.oreilly.com/library/view/r-for-data/9781491910382/ch01.html
#################################################

#https://socviz.co/makeplot.html#makeplot
p <- ggplot(data = gapminder)

data=gapminder

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))

p # Why does nothing show????

p + geom_point()

##############################################
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_smooth()

#############################################
# generalized  Additive Model
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() + geom_smooth() 
## `geom_smooth()` using method = 'gam' and formula 'y ~ s(x, bs = "cs")'

#############################################
# Linear Model
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() + geom_smooth(method = "lm") 
################################################
# GAM + Log10 Transform (x-axis)
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()


#  Log10 Transform (y-axis)
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_y_log10()

###############################################
# scales::dollar using scales
# library(scales)
# Try scales::comma
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point() +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar)
###############################################
#aesthetic mapping 
###############################################
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = "purple"))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
###############################################
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(color = "purple") +
  geom_smooth(method = "loess") +
  scale_x_log10()
###############################################

# se option = standard error = false
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp)) 
p + geom_point(alpha = 0.3) +
  geom_smooth(color = "orange", se = FALSE, size = 8, method = "lm") +
  scale_x_log10()
###############################################

#Labels
p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y=lifeExp))
p + geom_point(alpha = 0.3) +
  geom_smooth(method = "gam") +
  scale_x_log10(labels = scales::dollar) +
  labs(x = "GDP Per Capita", y = "Life Expectancy in Years",
       title = "Economic Growth and Life Expectancy",
       subtitle = "Data points are country-years",
       caption = "Source: Gapminder.")
###############################################
# 

gapminder

p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
###############################################
# legend color and fill
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp,
                          color = continent,
                          fill = continent))
p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()
###############################################
#Aesthetics can be mapped per geom

p <- ggplot(data = gapminder, mapping = aes(x = gdpPercap, y = lifeExp))
p + geom_point(mapping = aes(color = continent)) +
  geom_smooth(method = "loess") +
  scale_x_log10()
###############################################
# map continuous variables to the color aesthetic
p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p + geom_point(mapping = aes(color = log(pop))) +
  scale_x_log10() 

###############################################
# Export image ggsave(filename = "my_figure.png")


p <- ggplot(data = gapminder,
            mapping = aes(x = gdpPercap,
                          y = lifeExp))
p_out <- p + geom_point() +
  geom_smooth(method = "loess") +
  scale_x_log10()

ggsave("images/my_figure2.pdf", plot = p_out,  
       height = 8, width = 10, units = "in")

ggsave(here("images", "lifexp_vs_gdp_gradient.pdf"), plot = p_out)

###############################################
# Grouping 

p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))
p + geom_line() 
######
p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))
p + geom_line(aes(group=country)) 

###############################################
#Facet to make small multiples
p <- ggplot(data = gapminder,
            mapping = aes(x = year,
                          y = gdpPercap))
p + geom_line(aes(group = country)) + facet_wrap(~ continent)

################################
# display in 1 row
p <- ggplot(data = gapminder, mapping = aes(x = year, y = gdpPercap))
p + geom_line(color="gray70", aes(group = country)) +
  geom_smooth(size = 1.1, method = "loess", se = FALSE) +
  scale_y_log10(labels=scales::dollar) +
  facet_wrap(~ continent, ncol = 3) + # this line sets the cols =5
  labs(x = "Year",
       y = "GDP per capita",
       title = "GDP per capita on Five Continents")
####################
#seperate facets

gss_sm

p <- ggplot(data = gss_sm,
            mapping = aes(x = age, y = childs))
p + geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(sex ~ race)

################
p <- ggplot(data = gss_sm,
            mapping = aes(x = age, y = childs))
p + geom_point(alpha = 0.2) +
  geom_smooth() +
  facet_grid(sex ~ race + degree) #too complex


############################################################
#SMOOTHING
# https://en.wikipedia.org/wiki/Local_regression LEOSS/LOWESS (locally estimated scatterplot smoothing)
# https://en.wikipedia.org/wiki/Ordinary_least_squares OLS
# https://en.wikipedia.org/wiki/Generalized_additive_model GAM
# https://en.wikipedia.org/wiki/Generalized_linear_model GLM

p <- ggplot(data = gss_sm, mapping = aes(x = bigregion))
p + geom_bar()

#####################
# Proportions
# The value of 1 is just a kind of âdummy groupâ that tells ggplot to 
# use the whole dataset when establishing the denominator for its prop calculations.

p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion))
p + geom_bar(mapping = aes(y = ..prop.., group = 1))

#######
table(gss_sm$religion)

p <- ggplot(data = gss_sm,
            mapping = aes(x = religion, color = religion))#### only border
p + geom_bar()
#######################
p <- ggplot(data = gss_sm,
            mapping = aes(x = religion, fill = religion))
p + geom_bar() + guides(fill = FALSE) 
#######################################################
p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar()
#****************************
#*
#*
#*
p <- ggplot(data = gss_sm,
            mapping = aes(x = bigregion, fill = religion))
p + geom_bar(position = "fill")

###############################################
p <- ggplot(data = gss_sm,
            mapping = aes(x = religion))
p + geom_bar(position = "dodge",
             mapping = aes(y = ..prop.., group = bigregion)) +
  facet_wrap(~ bigregion, ncol = 2)

###########################################
# position_stack(reverse = TRUE)
#https://ggplot2.tidyverse.org/reference/geom_bar.html
ggplot(gss_sm, aes(y = bigregion)) +
  geom_bar(aes(fill = religion), position = position_stack(reverse = TRUE)) +
  theme(legend.position = "top")

ggplot(gss_sm, aes(y = bigregion)) +
  geom_bar(aes(fill = religion), position = position_stack()) +
  theme(legend.position = "top")

#########################################
#Histograms
p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_histogram()

################################
## `stat_bin()` using `bins = 30`. Pick better value with
## `binwidth`. rule of thumb.
p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_histogram(bins = 10)
######
p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_histogram(bins = 20)
#####
p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_histogram(bins = 30)
################################################
#%in% operator is a convenient way to filter on more than one term in a variable when using subset().

oh_wi <- c("OH", "WI")

p <- ggplot(data = subset(midwest, subset = state %in% oh_wi),
            mapping = aes(x = percollege, fill = state))
p + geom_histogram(alpha = 0.4, bins = 20)

###################################################
# kernel density
# https://vita.had.co.nz/papers/density-estimation.pdf

p <- ggplot(data = midwest,
            mapping = aes(x = area))
p + geom_density()
############################################
p <- ggplot(data = midwest,
            mapping = aes(x = area, fill = state, color = state))
p + geom_density(alpha = 0.3)
######################################

d=subset(midwest, subset = state %in% oh_wi)

p <- ggplot(data = subset(midwest, subset = state %in% oh_wi),
            mapping = aes(x = area, fill = state, color = state))
p + geom_density(alpha = 0.3, mapping = (aes(y = ..scaled..)))

############################
p <- ggplot(data = subset(midwest, subset = state %in% oh_wi),
            mapping = aes(x = area, fill = state, color = state))

p + geom_line(stat = "density")#no fill


p <- ggplot(data = midwest,
            mapping = aes(x = area, fill = state, color = state))

p + geom_line(stat = "density")#no fill
#########################################

#What if we already have the prop?
titanic
#stat = "identity"
p <- ggplot(data = titanic,
            mapping = aes(x = fate, y = percent, fill = sex))
p + geom_bar(position = "dodge", stat = "identity") + 
  theme(legend.position = "top")
#########################################

oecd_sum

p <- ggplot(data = oecd_sum,
            mapping = aes(x = year, y = diff, fill = hi_lo))
p + geom_col() + guides(fill = FALSE) +
  labs(x = NULL, y = "Difference in Years",
       title = "The US Life Expectancy Gap",
       subtitle = "Difference between US and OECD
                   average life expectancies, 1960-2015",
       caption = "Data: OECD. After a chart by Christopher Ingraham,
                  Washington Post, December 27th 2017.")


#######################################################
## DATA WRANGLING
# dplyr
## https://moderndive.com/3-wrangling.html#wrangling-packages
library(nycflights13)
library(dplyr)

####################
#    filter
###################

alaska_flights <- flights %>% 
  filter(carrier == "AS")


portland_flights <- flights %>% 
  filter(dest == "PDX")
View(portland_flights)


btv_sea_flights_fall <- flights %>% 
  filter(origin == "JFK" & (dest == "BTV" | dest == "SEA") & month >= 10)
# & |


#COMMA works too
# filter(origin == "JFK", (dest == "BTV" | dest == "SEA"), month >= 10) 


# %IN%
#filter(dest %in% c("SEA", "SFO", "PDX", "BTV", "BDL"))

####################
#    summarize
###################
# dealing with NA
summary_temp <- weather %>% 
  summarize(mean = mean(temp), std_dev = sd(temp))
summary_temp


glimpse(weather)


summary_temp <- weather %>% 
  summarize(mean = mean(temp, na.rm = TRUE), # na.rm
            std_dev = sd(temp, na.rm = TRUE))
summary_temp

# mean(): the average
# sd(): the standard deviation, which is a measure of spread
# min() and max(): the minimum and maximum values, respectively
# IQR(): interquartile range
# sum(): the total amount when adding multiple numbers
# n(): a count of the number of rows in each group.

####################
#    group by
###################

summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean = mean(temp, na.rm = TRUE), 
            std_dev = sd(temp, na.rm = TRUE))
summary_monthly_temp



library(ggplot2)
diamonds

diamonds %>% 
  group_by(cut) # nothing changed but we see 5 possible cut groups

diamonds %>% 
  group_by(cut) %>% 
  summarize(avg_price = mean(price))


by_origin <- flights %>% 
  group_by(origin) %>% 
  summarize(count = n())# note n() 
by_origin

# group by more than 1 val
by_origin_monthly <- flights %>% 
  group_by(origin, month) %>% # NOTE; comma!
  summarize(count = n())
by_origin_monthly


####################
#    mutate
###################
# make var

weather <- weather %>% # note: var overwrite
  mutate(temp_in_C = (temp - 32) / 1.8)# create new var

glimpse(weather)

summary_monthly_temp <- weather %>% 
  group_by(month) %>% 
  summarize(mean_temp_in_F2 = mean(temp, na.rm = TRUE), 
            mean_temp_in_C2 = mean(temp_in_C, na.rm = TRUE))
summary_monthly_temp




flights <- flights %>% 
  mutate(gain = dep_delay - arr_delay)


gain_summary <- flights %>% 
  summarize(
    min = min(gain, na.rm = TRUE),
    q1 = quantile(gain, 0.25, na.rm = TRUE),
    median = quantile(gain, 0.5, na.rm = TRUE),
    q3 = quantile(gain, 0.75, na.rm = TRUE),
    max = max(gain, na.rm = TRUE),
    mean = mean(gain, na.rm = TRUE),
    sd = sd(gain, na.rm = TRUE),
    missing = sum(is.na(gain))# note: missing vals
    
  )
gain_summary

ggplot(data = flights, mapping = aes(x = gain)) +
  geom_histogram(color = "white", bins = 20)

# create multiple vars
flights <- flights %>% 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours
  )

####################
#    arrange and sort rows
###################
freq_dest <- flights %>% 
  group_by(dest) %>% 
  summarize(num_flights = n())
freq_dest


freq_dest %>% 
  arrange(num_flights)

freq_dest %>% 
  arrange(desc(num_flights))# note: desc

####################
#    Joins
###################
flights_joined <- flights %>% 
  inner_join(airlines, by = "carrier") #Note: joined on carrier
View(airlines)
View(flights)
View(flights_joined)

#left_join(), right_join(), outer_join(), and anti_join()

# what about different keys?
flights_with_airport_names <- flights %>% 
  inner_join(airports, by = c("dest" = "faa"))
View(flights_with_airport_names)

View(airports)


named_dests <- flights %>%
  group_by(dest) %>%
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights)) %>%
  inner_join(airports, by = c("dest" = "faa")) %>%
  rename(airport_name = name)
named_dests



flights_weather_joined <- flights %>%
  inner_join(weather, by = c("year", "month", "day", "hour", "origin"))
View(flights_weather_joined)






####===>Start Here



####################
#    Select
###################
glimpse(flights)# see all vars

flights %>% 
  select(carrier, flight)

flights_no_year <- flights %>% select(-year) # minus removes col
flights_no_year <- flights %>% select(-year, -origin) # minus removes cols
glimpse(flights_no_year)

flight_arr_times <- flights %>%
  select(month:day, arr_time:sched_arr_time)
flight_arr_times


flights_reorder <- flights %>% 
  select(year, month, day, hour, minute, time_hour, everything()) # everything() picks all remaining vars
glimpse(flights_reorder)



flight_arr_times <- flights %>%
  select(month:day, origin:sched_arr_time)

flights %>% select(starts_with("a"))
flights %>% select(ends_with("delay"))
flights %>% select(contains("time"))

####################
#    Rename
###################

flights_time_new <- flights %>% 
  select(dep_time, arr_time) %>% 
  rename(departure_time = dep_time, arrival_time = arr_time)# renames
glimpse(flights_time_new)



####################
#    nTOP
###################
named_dests %>% top_n(n = 10, wt = num_flights)


named_dests  %>% 
  top_n(n = 10, wt = num_flights) %>% 
  arrange(desc(num_flights))# arrange = sort

###ICE 5 ANSWER
# count of flights by Origin filtered >105000 sorted desc
FlightsByOrigin = flights %>% 
  group_by(origin) %>%# groupby origin
  summarise(num_flights = n()) %>%# cnt flights
  filter(num_flights > 105000) %>%# filterby >105000 
  arrange(desc(num_flights)) # sort desc
FlightsByOrigin

# Healy Chpter 5 = https://socviz.co/workgeoms.html#workgeoms
library(socviz)


rel_by_region <- gss_sm %>%
  group_by(bigregion, religion) %>%
  summarize(N = n()) %>%
  mutate(freq = N / sum(N),
         pct = round((freq*100), 0), sum=sum(N))
rel_by_region


p <- ggplot(rel_by_region, aes(x = bigregion, y = pct, fill = religion))
p + geom_col(position = "dodge2") +
  labs(x = "Region",y = "Percent", fill = "Religion") +
  theme(legend.position = "top")

# better option as facets
p <- ggplot(rel_by_region, aes(x = religion, y = pct, fill = religion))
p + geom_col(position = "dodge2") +
  labs(x = NULL, y = "Percent", fill = "Religion") +
  guides(fill = FALSE) + 
  coord_flip() + 
  facet_grid(~ bigregion)

#vars by group
organdata %>% select(1:6) %>% sample_n(size = 10)
# could use head(organdata)

p <- ggplot(data = organdata,
            mapping = aes(x = year, y = donors))
p + geom_point()


p <- ggplot(data = organdata,
            mapping = aes(x = year, y = donors))
p + geom_line(aes(group = country)) + facet_wrap(~ country)



p <- ggplot(data = organdata,
            mapping = aes(x = country, y = donors))#"labls overlap"
p + geom_boxplot()

#still need to order
p <- ggplot(data = organdata,
            mapping = aes(x = country, y = donors))
p + geom_boxplot() + coord_flip()


p <- ggplot(data = organdata,
            mapping = aes(x = reorder(country, donors, na.rm=TRUE), # by default orders by mean
                          y = donors))
p + geom_boxplot() +
  labs(x=NULL) +
  coord_flip()



p <- ggplot(data = organdata,
            mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                          y = donors, fill = world))
p + geom_boxplot() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")




# More on geom point vs geom jitter
p <- ggplot(data = organdata,
            mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                          y = donors, color = world))
p + geom_point() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")

# jitter
p <- ggplot(data = organdata,
            mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                          y = donors, color = world))
p + geom_jitter() + labs(x=NULL) +
  coord_flip() + theme(legend.position = "top")


# control amount of jitter using position_jitter() ht, wdth
p <- ggplot(data = organdata,
            mapping = aes(x = reorder(country, donors, na.rm=TRUE),
                          y = donors, color = world))
p + geom_jitter(position = position_jitter(width=0.15)) +
  labs(x=NULL) + coord_flip() + theme(legend.position = "top")

##############MORE dplyr
by_country <- organdata %>% group_by(consent_law, country) %>%
  summarize(donors_mean= mean(donors, na.rm = TRUE),
            donors_sd = sd(donors, na.rm = TRUE),
            gdp_mean = mean(gdp, na.rm = TRUE),
            health_mean = mean(health, na.rm = TRUE),
            roads_mean = mean(roads, na.rm = TRUE),
            cerebvas_mean = mean(cerebvas, na.rm = TRUE))

by_country

#more elegant way to derive mu and sigma
by_country <- organdata %>% group_by(consent_law, country) %>%
  summarize_if(is.numeric, funs(mean, sd), na.rm = TRUE) %>%# funs deprecated
  ungroup()

by_country <- organdata %>% group_by(consent_law, country) %>%
  summarize_if(is.numeric, list(mean = mean, sd = sd), na.rm = TRUE) %>%
  ungroup()


glimpse(by_country)
s=by_country%>% select(donors_mean,donors_sd)
s

#now plot it
p <- ggplot(data = by_country,
            mapping = aes(x = donors_mean, y = reorder(country, donors_mean),
                          color = consent_law))
p + geom_point(size=3) +
  labs(x = "Donor Procurement Rate",
       y = "", color = "Consent Law") +
  theme(legend.position="top")

# or use facet Cleveland-style dotplot (one pt per cat)
p <- ggplot(data = by_country,
            mapping = aes(x = donors_mean,
                          y = reorder(country, donors_mean)))

p + geom_point(size=3) +
  facet_wrap(~ consent_law, scales = "free_y", ncol = 1) +
  labs(x= "Donor Procurement Rate",
       y= "") 

#include variance or error =>  A dot-and-whisker plot
p <- ggplot(data = by_country, mapping = aes(x = reorder(country,
                                                         donors_mean), y = donors_mean))

p + geom_pointrange(mapping = aes(ymin = donors_mean - donors_sd,
                                  ymax = donors_mean + donors_sd)) +
  labs(x= "", y= "Donor Procurement Rate") + coord_flip()


#plot yext directly
p <- ggplot(data = by_country,
            mapping = aes(x = roads_mean, y = donors_mean))
p + geom_point() + geom_text(mapping = aes(label = country))


# use hjust = 0 to ensure labels arent on the dots

p <- ggplot(data = by_country,
            mapping = aes(x = roads_mean, y = donors_mean))

p + geom_point() + geom_text(mapping = aes(label = country), hjust = 0)

#not great but another option
library(ggrepel)
elections_historic %>% select(2:7) 

p_title <- "Presidential Elections: Popular & Electoral College Margins"
p_subtitle <- "1824-2016"
p_caption <- "Data for 2016 are provisional."
x_label <- "Winner's share of Popular Vote"
y_label <- "Winner's share of Electoral College Votes"

p <- ggplot(elections_historic, aes(x = popular_pct, y = ec_pct,
                                    label = winner_label))

p + geom_hline(yintercept = 0.5, size = 1.4, color = "gray80") +
  geom_vline(xintercept = 0.5, size = 1.4, color = "gray80") +
  geom_point() +
  geom_text_repel() +
  scale_x_continuous(labels = scales::percent) +
  scale_y_continuous(labels = scales::percent) +
  labs(x = x_label, y = y_label, title = p_title, subtitle = p_subtitle,
       caption = p_caption)

# Be more selective on the labels
p <- ggplot(data = by_country,
            mapping = aes(x = gdp_mean, y = health_mean))

p + geom_point() +
  geom_text_repel(data = subset(by_country, gdp_mean > 25000),
                  mapping = aes(label = country))
###---------------------------
p <- ggplot(data = by_country,
            mapping = aes(x = gdp_mean, y = health_mean))

p + geom_point() +
  geom_text_repel(data = subset(by_country,
                                gdp_mean > 25000 | health_mean < 1500 |
                                  country %in% "Belgium"),
                  mapping = aes(label = country))

###Annotate
p <- ggplot(data = organdata, mapping = aes(x = roads, y = donors))
p + geom_point() + annotate(geom = "text", x = 91, y = 33,
                            label = "A surprisingly high \n recovery rate.",
                            hjust = 0)

#red box
p <- ggplot(data = organdata,
            mapping = aes(x = roads, y = donors))
p + geom_point() +
  annotate(geom = "rect", xmin = 125, xmax = 155,
           ymin = 30, ymax = 35, fill = "red", alpha = 0.2) + 
  annotate(geom = "text", x = 157, y = 33,
           label = "A surprisingly high \n recovery rate.", hjust = 0)

# scales, guides, and themes
p <- ggplot(data = organdata,
            mapping = aes(x = roads,
                          y = donors,
                          color = world))
p + geom_point()

#transform
p <- ggplot(data = organdata,
            mapping = aes(x = roads,
                          y = donors,
                          color = world))
p + geom_point() +
  scale_x_log10() +
  scale_y_continuous(breaks = c(5, 15, 25),
                     labels = c("Five", "Fifteen", "Twenty Five"))


## labeling Legend
p <- ggplot(data = organdata,
            mapping = aes(x = roads,
                          y = donors,
                          color = world))
p + geom_point() +
  scale_color_discrete(labels =
                         c("Corporatist", "Liberal",
                           "Social Democratic", "Unclassified")) +
  labs(x = "Road Deaths",
       y = "Donor Procurement",
       color = "Welfare State")
#ReMoving Legend
p <- ggplot(data = organdata,
            mapping = aes(x = roads,
                          y = donors,
                          color = world))
p + geom_point() +
  labs(x = "Road Deaths",
       y = "Donor Procurement") +
  guides(color = FALSE)

#moving Legend top
p <- ggplot(data = organdata,
            mapping = aes(x = roads,
                          y = donors,
                          color = world))
p + geom_point() +
  labs(x = "Road Deaths",
       y = "Donor Procurement") +
  theme(legend.position = "top")

