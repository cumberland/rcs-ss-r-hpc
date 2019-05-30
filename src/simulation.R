#simulation.R

#Comment this out when running live.  Code will live in current directory. 
setwd('~/Repositories/PhD/confound')
source('./code/library.R')

#This is the container version:
#source('/home/user/code/library.R')
#This file is the script that gets run by default when the container r-simulation is run with no commands.




job_count = 0
max_job_count = 10 

while (job_count < max_job_count){
#1.  Retrieve a parameter set from parameters server, updating it to reflect inflight status. 
parameters <- try(getParameterSet(), silent=TRUE)
#2. Check to confirm that the try loop around the parameter retrieval didn't error.  
if (attributes(parameters)$class == 'try-error'){
	print('Stopping')
	stop('Invalid Parameter Set')
} else {
#3. Carry on assessing parameters object to establish variables for simulation.
results_object <- parameters #Save Parameters to Results Object.

#Sys.sleep(15) #This is to slow things down to make testing of multi agent parameter retrieval feasible. 

str(parameters)
parameter_set <- parameters$i
reps <- parameters$reps
sample_size <- parameters$sample_size
rate_untreated <- parameters$baserate
target_or <- parameters$target_or
between <- parameters$between

#Use Target Odds Ratio and Base Positive Outcome in Untreated Unconfounded Rate to Calculate Treated Positive Outcome Rate in Unconfounded
#Combine Rate of 1 Outcome in Untreated (baserate) and Target Odds Ratio (target_or)
#To calculate Rate of 1 Outcome in Treated.  (Both in Confounding Level 0)

odds_untreated_success <- rate_untreated / 1 - rate_untreated
odds_treated_success <- odds_untreated_success * target_or
rate_treated <- odds_treated_success / 1 + odds_treated_success



rep = 0
for (rep in reps){
#The whole thing needs to live in this.  
#For now that's a pain in the neck.
print(rep)
}


#Generate Data... Revised to draw from 4 random binomial distributions with rates populated via 
#combination of base rate in untreated and between difference across confounder levels.  
#Confounder positive rate will be 50%
#There will be edge cases where negative between rate will make low base rate events 0.  
#In this case we'll scrap that parameter set.  
#I've done this by deleting parameter sets where baserate + between <=0 from the parameters database. 
#This deletion is done in the generate_parameters.R script (near the bottom there are 3200 or so paramater sets where this is an issue.)


#Set some rates and use them to create 4 distributions.

rate_untreated_unconfounded = rate_untreated  			#The untreated rate where confounder level  = 0.
rate_untreated_confounded = rate_untreated + between 	#The untreated rate where confounder level = 1.
rate_treated_unconfounded = rate_treated 				#The treated rate where confounder level = 0.
rate_treated_confounded = rate_treated + between 		#The treated rate where confounder level = 1.

rbinom(sample_size, 1, rate_untreated_unconfounded)
rate_untreated_confounded 
rate_treated_unconfounded 
rate_treated_confounded 






set.seed(parameter_set+rep)  #Think about this to ensure reproducibility.  I'm inclined to use i + rep to be any given sets seed. 








results_object$agent <- as.character(Sys.info()['nodename'])
results_object <- results_object[c(1, 10,5:9)] #Reorder Results Object to put agent in in place of status.


#L. Write Results Object to results table. 

saveResultSet(results_object)


} #This is the end bracket of the if/else testing to see if parameters were retrieved properly. 
job_count = job_count + 1 # Increment your job counter. 
} #This is the end bracket of the while loop that tests to see if this agent has done more than it's share (as a count) of the jobs available. There really shouldn't be anything after this. 
