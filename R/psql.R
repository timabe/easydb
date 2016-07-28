#' Run a SQL query on a postgres DB and return a nicely formatted tibble.
#'
#' Returns the results in a tibble.
#'
#' @param query A valid SQL query
#' @param dbname The database you wish to query. Connection parameters will be loaded from the pg_service.conf file and used. See \url{http://www.postgresql.org/docs/9.4/static/libpq-pgservice.html} for details on this file and syntax.
#' @param UTC A logical value indicating whether the timestamps should be returned in UTC side. Defaults to \code{TRUE}. Currently \code{FALSE} will return Pacific time.
#' @param ... Other arguments passed on to methods
#'
#' @return \href{https://github.com/hadley/tibble}{tibble} containing the query results
#'
#'
#' @examples
#' psql(query = "SELECT * FROM consumers limit 3;", dbname = 'mydb')
#'
#'
#' @export
psql <- function(query, dbname = 'mydb', UTC = TRUE, ...) {
  # establish connection to the database
  con <- RPostgres::dbConnect(
    drv = RPostgres::Postgres(),
    service = dbname
    )
  # deal with timezones
  if (UTC) { # do nothing because defaults to UTC
    }
  else {
    DBI::dbGetQuery(con, "SET timezone to \'PST8PDT\';")
    }
  res <- suppressWarnings(RPostgres::dbSendQuery(con, query))
  query_return <- RPostgres::dbFetch(res)
  # convert it to a 'tibble', which is nicer than a dataframe
  out_tbl <- dplyr::tbl_df(query_return)
  # convert columns. helpful for dates and such
  out <- readr::type_convert(out_tbl)
  RPostgres::dbClearResult(res)
  RPostgres::dbDisconnect(con)
  return(out)
}
