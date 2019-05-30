#generate_parameters.R
#This loop will generate a tab delimited file with all possible combinations of parameters for the study.
#It will insert those parameters into a database as defined in library.R
setwd('~/Repositories/PhD/rcs-ss-r-hpc')
source('src/library.R')

i=1
reps = 10
status = 'available'
starttime = 'NULL'
endtime = 'NULL'
params <- data.frame(param_set=integer(), status=character(), starttime=character(), endtime=character(), reps=integer(), sample_size=integer(), baserate=double(), target_or=double(), between=double())

for (sample_size in seq(250,2000,250)){
	for (baserate in seq(5,50,5)/100){
		for (target_or in seq(105,150,5)/100){
			 for (between in list(-0.4, -0.3, -0.2, -0.1, 0.1, 0.2, 0.3, 0.4)){
				
				p_set <- c(i, status, starttime, endtime, reps, sample_size, baserate, target_or, between)
				# if(i%%1000 == 0){
				# 	print(i)
				# }
				i = i+1
				p_set <- as.data.frame(t(p_set))
				# p_set_json <- toJSON(p_set, pretty=TRUE)
				
				
				names(p_set) <- c('i', 'status', 'starttime', 'endtime', 'reps', 'sample_size', 'baserate', 'target_or', 'between')
				params <- rbind(params, p_set)

			 }
		}
	}
 }


data = params

str(data)

con <- dbConnect(RMariaDB::MariaDB(), user='rockandrole', password='RbzK21pq', dbname='simulation', host='simulation.cwzuadxgqmt1.ca-central-1.rds.amazonaws.com')

dbWriteTable(con, 'parameters', data, append=TRUE, replace=TRUE, row.names=FALSE)

#Alter Table to have Correct Engine
dbGetQuery(con, "ALTER TABLE parameters ENGINE=InnoDB")

dbGetQuery(con, "SHOW TABLE STATUS WHERE Name = 'parameters'")

dbDisconnect(con)

