# LMDB

Local Movie Database

# Installation

*Prerequisites: You need to have ruby installed locally*

This will set up the dependencies, database, set up a sample tsv file as a 
tsv storage, import a sample tsv file into the sqlite database.
## Setup  
```
$ ./bin/setup
```
## Start the rails server
```
$ rails s
```

# Optional imports
## Import tsv file into sqlite
You can choose to use a local tsv file to do the querying.
If you want to use your own file you can import it by running this command:
```
$ rake import:to_sqlite[<path-to-file>]
```
## Import tsv to be used as a data source itself
If you want to import some more data into the sqlite database 
you can run the following command:
```
$ rake import:to_local[<path-to-file>]
```
## Running the tests
```
$ rspec
```

# Explanations

The server side is a simple api, designed to not care about what type of clients it has
as long as the requests are served via HTTP.

The client is implemented with vanilla js. No other libraries were added.

The database is sqllite in which the .tsv was imported.

The data source can also be just the tsv file. 
You can select the data source via a radio button on the page.

The client code is simply put in the public folder, since it is here
only so it is bundled together. This could be a totally separate app.

A limit is hardcoded right now for the purpose of a simple lookahead search bar.
We could move the limit to the client via a parameter of course.

Request throttling is handled via the rack-attack gem which is a rack middleware
that throttles requests before they get to the rails app. In a production environment
this could be mitigated to a nginx reverse proxy or another load balancer.

Features:
- browsing to the page with a link containing a query will show the results of that query
- radio button to search either in the indexed sqlite database or in the unformatted tsv file
- delayed input, so we don't do a request right away
- ongoing requests are canceled if we continue our search
- request throttling is implemented using rack-attack, and set to 1 request every 5 seconds for demonstration
- tests written in rspec
  

