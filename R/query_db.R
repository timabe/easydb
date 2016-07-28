#' Create a function to query a specific database
#'
#' The function will return a function that can be used to query a database. The example should clear up any confusion.
#'
#' Because doing an analysis normally means working on just one database, it is annoying to have to continuously type \code{psql(query, dbname = 'myproduct')}, adding in the dbname 'myproduct' each time.
#'
#' This let's you easily create a function to query 'myproduct'.
#'
#'
#' @param dbname The database you wish to query
#' @param UTC Logical value for whether you want UTC or Pacific timezone.
#'
#' @return function prepped to query the database you want.
#'
#'
#' @examples
#' sql <- query_db('mydb', UTC = TRUE)
#' sql("SELECT * FROM consumers limit 3;")
#'
#'
#' @export

query_db <- function(dbname, UTC = TRUE) {
    function(query) {
      psql(query, dbname = dbname, UTC)
  }
}
