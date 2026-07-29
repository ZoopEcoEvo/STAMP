### This script will generate a set of tube assignments for the rate of acclimation experiments 

### Define Parameters

###############################################################
### Don't change anything here without checking with Matt first
treatment_levels = c(rep(treatments, times = num_tubes/length(treatments)), "thermometer") # Specify the treatments you want to distribute across tubes
population = rep("CP", each = num_tubes) # Designates the population
#thermometer = sample(1:num_tubes, size = 1)
exp_date = str_replace_all(Sys.Date(), pattern = "-", replacement = "_") 
###############################################################
###############################################################


### Randomly assign treatments & populations to tubes 
assignments = data.frame(tube = sample(1:num_tubes), 
                         pop = population,
                         treatment = treatment_levels) %>% 
  mutate(pop = if_else(treatment == "thermometer", NA, pop)) %>% 
  arrange(tube)

### Summarize the output 
print("This is how many individuals you'll need for each population/treatment:")
assignments %>% 
  drop_na(pop) %>% 
  count(pop, treatment) %>% 
  print()

print("This is the tube assignments for this assay:")

print(assignments)

### Write the data file to the output? 
assignments %>% 
  mutate("exp_rep" = "",
         "assay_num" = assay_num,
         "exp_date" = Sys.Date(),
         "acc_day" = "",
         "start_time" = "",
         "water_bath" = "", 
         "thermometer" = "",
         "ctmax" = "", 
         "length" = "") %>% 
  select(exp_rep:thermometer, tube, pop, treatment, ctmax, length) %>% 
  write.csv(paste("Raw_data/ctmax_data/", exp_date, "_assay", assay_num, ".csv", sep = ""), row.names = F)

### Simulate many experimental assays to make sure this script sets things up appropriately 
# 
# meta = data.frame()
# 
# for(sim in 1:30){
#   total = data.frame()
#   for(exp in 1:5){
#     
#     for(day in 1:7){
#       
#       assignments = data.frame(tube = sample(1:12), 
#                                pop = population,
#                                treatment = treatment_levels) %>% 
#         mutate(pop = if_else(tube == thermometer, "thermometer", pop), 
#                treatment = if_else(pop == "thermometer", NA, treatment)) %>% 
#         arrange(tube) %>% 
#         mutate(experiment = exp, 
#                day = day, 
#                simulation = sim)
#       
#       total = bind_rows(total, assignments)
#     }
#     
#   }
#   meta = bind_rows(meta, total)
# }
# 
# meta %>% 
#   drop_na(treatment) %>% 
#   count(simulation, pop, treatment) %>% 
#   ggplot(aes(x = pop, fill = treatment, y = n)) + 
#   geom_boxplot()
# 
# 
# #This one looks at the number per day for each population and treatment - it should be 2 or 3 in all cases
# meta %>% 
#   drop_na(treatment) %>% 
#   count(simulation, pop, treatment, experiment, day) %>% 
#   ggplot(aes(x = simulation, y = n)) + 
#   geom_point()
# 
# #This one looks at the total number per experiment for each population and treatment
# #There will be more variability here, but the range should be <5
# meta %>%
#   drop_na(treatment) %>%
#   count(simulation, pop, treatment, experiment) %>%
#   ggplot(aes(x = simulation, y = n)) +
#   geom_point()
