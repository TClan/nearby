# nearby
Look for Cars , Drivers or any Service that is nearby a specified location


# Tech Stack Choice

Had choose to use RoR since I am familiar with the TDD, CI and CD ecosystem, but in an ideal world I would have used Closure or Go which has in-built async support. For a use case that requires high-throuput, an async can efficiently multiplex IO work vs compute.

The following articles gave me the confidence that RoR can be tuned to match required performance, the article tunes a Rails server to handle 4k requests/sec (240,000/minute).
http://www.ostinelli.net/how-to-build-a-rails-api-server-optimizing-the-framework/

# Performance Test Results (worst case scenario)

```
Puma production configuration, postgres in same mac
===================================================

PUT location

Concurrency Level:      5
Time taken for tests:   1.981 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      253000 bytes
Total body sent:        218000
HTML transferred:       0 bytes
Requests per second:    504.77 [#/sec] (mean)
Time per request:       9.906 [ms] (mean)
Time per request:       1.981 [ms] (mean, across all concurrent requests)
Transfer rate:          124.71 [Kbytes/sec] received
                        107.46 kb/s sent
                        232.17 kb/s total

GET nearby folks

Concurrency Level:      5
Time taken for tests:   1.564 seconds
Complete requests:      1000
Failed requests:        0
Total transferred:      391000 bytes
HTML transferred:       61000 bytes
Requests per second:    639.52 [#/sec] (mean)
Time per request:       7.818 [ms] (mean)
Time per request:       1.564 [ms] (mean, across all concurrent requests)
Transfer rate:          244.19 [Kbytes/sec] received

```

# High Level Approach

Give the time constraints, choose to use PostGIS solution provided by Postgres extension to store Lat/Long co-ordinates of drivers and use the distance function to identify closest points.

##Pros:
1) Faster Time-to-market, in-built functions available to perform most Spatial functions
2) Performance (1 ms to fetch points in a table with 1 million points | http://ngauthier.com/2013/08/postgis-and-rails-a-simple-approach.html)

##Cons:

1) Distance calculation logic is in database, restricted to use out of the box database functions
2) Have to use database replication (AWS RDS Multi-zone setup) to prevent database being the single point of failure

# Infrastructure Requirements (wanted to use docker to setup this)

1. Postgres 9.6.x with PostGIS extension
2. Rails Server

# Setup Instructions (mac with homebrew)

1) Install Postgres with PostGIS extension 

`brew update`

`brew install postgresql postgis`

# Setup Instructions (Ubuntu)

1) Install Postgres with PostGIS extension 

`sudo apt-get update`

`sudo apt-get install -y postgresql postgresql-contrib`

`sudo apt-get install postgis`

# Below steps are common for both linux and mac

2) Install libraries

`bundle install`

3) Create database and enable postgis extension
 
 `bundle exec rake db:create db:migrate`
 
4) Run server

`bundle exec rails s`


 # Run Specs
 
 `bundle exec rspec`
 
 ```
 Run options: include {:focus=>true}

All examples were filtered out; ignoring {:focus=>true}
...............................

Finished in 0.7011 seconds (files took 6.99 seconds to load)
33 examples, 0 failures
 
```

