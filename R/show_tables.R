#' List the tables and schemas of a postgres database
#'
#' Returns the results in a dataframe
#'
#' @param dbname A valid database
#' @param ... Other arguments passed on to methods
#'
#' @return dataframe containing the query results
#'
#'
#' @examples
#' show_tables(dbname = 'mydb')
#'
#' @export
show_tables <- function(dbname, ... ) {
  query = "SELECT DISTINCT table_schema, table_name FROM information_schema.columns
      where table_schema != 'information_schema'
  OR table_schema != 'pg_catalog'
  ORDER BY table_schema, table_name;"
  psql(query, dbname)
}
