#runner.R
#This is your simulation agent. 

#This is the container version:
source('/home/user/src/library.R')

#This file is the script that gets run by default when the container r-simulation is run with no commands.

#Give us a reason for the while loop to start.
go <- TRUE

while (go == TRUE) {
	#1.  Retrieve a parameter set from parameters server, updating it to reflect inflight status. 
	params <- try(getParameterSet(), silent=TRUE)
	#2. Check to confirm that the try loop around the parameter retrieval didn't error.  
	if (attributes(params)$class == 'try-error'){
		go <- FALSE #You couldn't get a parameter set so you might as well quit.
		stop('Could not retrieve a parameter set')
		
	} else {
		#3. Carry on assessing parameters object to establish variables for simulation.
		results_object <- params #I do this... Some might hate it.  Saves me pulling from multiple tables at the end. 

		set.seed(results_object$seed) #This is the way we ensure that re-running a parameter set returns the same output.  
		results_object$agent <- results_object$agent <- as.character(Sys.info()['nodename']) #This tells us what worker did the job once we save the results.
		results_object <- results_object[c(1,11)]

		#This is where you do your math and generate your results. 
		#For now lets take a nap instead. 
		Sys.sleep(10)
		results_object$answer <- runif(1)

		
		saveResultSet(results_object)

		if (results_object$i == 10) {go <- FALSE} #This will kill the loop while we're testing. 
		#Sys.sleep(15) #This is to slow things down to make testing of multi agent parameter retrieval feasible. 
	} #Delete Me...

}













# str(params)
# print(params)

# #Pull Parameters.
# script 	<- paste('/home/user/code/', params[5], sep='')
# source(script, local=TRUE)
# #alpha <- 'alpha'
# #kalpha <-  'kalpha'
# results_object$agent <- as.character(Sys.info()['nodename'])
# results_object$alpha <- alpha
# results_object$kalpha <- kalpha
# saveResultSet(results_object)

# }
