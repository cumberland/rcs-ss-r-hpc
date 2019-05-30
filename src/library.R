#library.R
require(DBI)
require(RMariaDB)



getParameterSet <- function(){
	con <- dbConnect(RMariaDB::MariaDB(), user='rockandrole', password='RbzK21pq', dbname='simulation', host='simulation.cwzuadxgqmt1.ca-central-1.rds.amazonaws.com')
	dbBegin(con)
	parameters <- dbGetQuery(con, "select * from parameters where status = 'available' limit 1 FOR UPDATE;")
	if(nrow(parameters)!=1){ 
             dbRollback(con)
             attributes(parameters)$class = 'try-error'
             return(parameters)
	} else { 
	update_query <- paste("update parameters set status = 'inflight', starttime=now() where i = ", parameters$i, ";")
	dbExecute(con, update_query)
	dbCommit(con)
	dbDisconnect(con)
	return(parameters)
	}
}

saveResultSet <- function(results = results_object){
	con <- dbConnect(RMariaDB::MariaDB(), user='rockandrole', password='RbzK21pq', dbname='simulation', host='simulation.cwzuadxgqmt1.ca-central-1.rds.amazonaws.com')
	results = results
	dbBegin(con)
	dbWriteTable(con, 'results', results, append=TRUE, replace=FALSE, row.names=FALSE)
	finalize_parameter_set <- paste('update parameters set status = "complete", endtime=now() where i = ', params$i, ';')
	dbExecute(con, finalize_parameter_set)
	dbCommit(con)
	dbDisconnect(con)
}

# results <- dbGetQuery(con, "select * from results")
# write.csv(results, file='results.csv')