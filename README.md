# easydb
Simple functions for querying Postgres Databases

## Installation
The easiest way is to use the `devtools` package.

```
install.packages('devtools') # if you don't already have it installed
library(devtools)
install_github('timabe/easydb')
```

Note: You may get an error regarding the RPostgres library. If you do, you can install it with this command.

```
devtools::install_github("rstats-db/RPostgres")
```

Once installed, you should be able to attach the package just like any other R package using `library(easydb)`.

## Configuration

Add a pg_service.conf file in your home directory with all your database connections. The file uses an "INI file" format. For example:

```
# comment
[mydb]
host=somehost
port=5433
user=admin
```

If you want to query this database, you can create a function like this:

```
sql <- query_db(dbname = 'mydb')
```

The function will pick up the connection parameters from the pg_service.conf file. For more info see [here](http://www.postgresql.org/docs/9.4/static/libpq-pgservice.html).

### SSH tunneling
If your database setup involves connecting via a Bastion Host (common with Postgres DBs hosted on Amazon Web Services RDS), you need to establish an SSH tunnel to the instance and use port forwarding so you can send commands back and forth.
```
ssh -N -L <your_port>:<db_hostname>:5432 -L <username>@<instance_hostname>
```
