# Bixi-application

This is the Heroku link :
https://bixi-fx-innovation.herokuapp.com/
------------
HOW TO RUN THE APP LOCALLY

- To launch the app and sidekiq: $heroku local (or $rails server, then $sidekiq -q default -c 5).

- redis & postresql must be started.

- To run the tests: $rspec.
------------
NEXT STEP/WORKING ON : give the possibility to use the app from anywhere in Montreal
------------
This application was made for a technical test. Here are the instructions :

- Make an app that checks the availability of bixis (bikes for share) at the closest stations (from the Office which sent me the test).

- The output of a request should include each station's name, available bixis number, and the distance from the Office to the station.
The stations should be ordered from the closest to the furthest.

- Use Geocoder gem for calculate distances, and Montreal Bixis API:
http://donnees.ville.montreal.qc.ca/dataset/bixi-etat-des-stations

https://api-core.bixi.com/gbfs/gbfs.json

- At each request to the API, all stations shouldn't be updated everytime.
-----------------------------------------------------------------------

This project is probably one of my favorite so far, because it gave me the opportunity to try gems that I haven't used so far :
'rest-client', 'geocoder', 'vcr', 'shoulda-matchers', 'simplecov'.

It also made me use a job worker (sidekiq) once again, and helped me have a better understanding of it.

I also tried my best to test my code as much as possible, using Rspec.
