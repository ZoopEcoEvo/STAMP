# Load in required packages
library(rmarkdown)
library(tidyverse)
library(lme4)
library(lmerTest)

#Determine which scripts should be run
setup_experiment = T
process_data = F #Runs data analysis 
make_report = F #Runs project summary
knit_manuscript = F #Compiles manuscript draft


if(setup_experiment == T){

  ### THINGS YOU NEED TO CHANGE
  # 1 - the number of tubes used ( = number of samples + 1 for the thermometer)
  ### NOTE: FOR NOW THIS MUST BE AN ODD NUMBER
  num_tubes = 9 
  
  # 2 - the treatments involved in the assay (add or remove as needed)
  treatments = c("control", "microplastics", "warming", "combined")
  
  # 3 - set the assay number (start with 1 and increase as you go)
  ### Be sure to double check what the previous assay number was to avoid overwriting any data!
  assay_num = 2
  
  source(file = "Scripts/tube_assignments.R")
}


############################
### Read in the RAW data ###
############################

if(process_data == T){
  source(file = "Scripts/01_data_processing.R")
}

##################################
### Read in the PROCESSED data ###
##################################

ctmax_data = read.csv(file = "Raw_data/temp_data.csv") %>% 
  janitor::clean_names() %>% 
  mutate(treatment = fct_relevel(treatment, "Control", "Microplastics", "Heatwave", "Combined"))


if(make_report == T){
  render(input = "Output/Reports/report.Rmd", #Input the path to your .Rmd file here
         #output_file = "report", #Name your file here if you want it to have a different name; leave off the .html, .md, etc. - it will add the correct one automatically
         output_format = "all")
}

##################################
### Read in the PROCESSED data ###
##################################

if(knit_manuscript == T){
  render(input = "Manuscript/manuscript_name.Rmd", #Input the path to your .Rmd file here
         output_file = paste("dev_draft_", Sys.Date(), sep = ""), #Name your file here; as it is, this line will create reports named with the date
                                                                  #NOTE: Any file with the dev_ prefix in the Drafts directory will be ignored. Remove "dev_" if you want to include draft files in the GitHub repo
         output_dir = "Output/Drafts/", #Set the path to the desired output directory here
         output_format = "all",
         clean = T)
}
