== README

Requirements:
* Rails 
* MongoDB w/ Mongoid 
* CarrierWave: For image uploading
* ImageMagick: For image manipulation, should be installed on the server
* Geocoder: extract geotag
* Bootstrap

Introduction:

Travelogue is an online photo services where travelers can upload their photos taken and also the beautiful memories and unforgettable experiences during their wonderful trips. 

Every photo with geo-tags are automatically labeled by the city and the country where it was originally taken. In the traveler's profile, you may see which countries and cities he/she has been to.

The travelers may also share their trips with fellow travelers, or browse the images taken by other travelers during their journey.


Features:

* Users can upload their avatars, and the photos of course.
* A navigation bar allows users to quickly access their profiles and dashboard
* The users may change their passwords
* Users are provided with an unique url http://application/<nickname> when registering an account
* Use Bootstrap

Note:

There is a partially working copy of Travelogue currently hosted on Heroku:
http://still-scrubland-1344.herokuapp.com/


HW5 -- sl3357 -- Shou-pon Lin

The controller used to be responsible for the check on the uniqueness of :email and several checks on :password and :password_confirmation, which are now implemented in the form of validations in User model. Encryption of password is invoked by callback method before the model is saved to the database.

Two minimalist partials are added. The first shows the links to login/signup/logout pages, whichever are appropriated given whether there is a user currently logged in. The second is a footer at the bottom, with information related to current user and a link to the user's profile page.

HW4 -- sl3357 -- Shou-pon Lin

Type 'rake nyimport:parking_violations' to parse the csv file and save the data into MongoDB database. A smaller 'parking_violations_small.csv' is supplied instead of the original file, because the size of the original file is too large.

HW3 -- sl3357 -- Shou-pon Lin

The purpose of this application is for each user to keep track of all the trips they have been to. Each trip contains several cities in an itinerary, and several attractions may be visited during a user's stay in a city.

The following models are created in this homework:
- User: corresponds to each user that uses this application; stores user information and provide authentication
- Trip: a trip describes the itinerary of a User for a certain period; it includes a start date, an end date, and the Cities that have been traveled during this period 
- City: corresponds to real cities in the world. A city has a unique Location and may have several Attractions
- Country: corresponds to real countries in the world. A country has several Cities
- Location: contains the coordinate of a specific point on the earth surface
- Address: inherits Location and contains additional fields such as street name, city name, zipcode, etc
- Attraction: is a point-of-interest within a City. It has Location or Address associated with it

A summary of associations:
- users <-> trips (many-to-many)
- trip <-> cities (one-to-many)
- country <-> cities (one-to-many)
- city <-> location (one-to-one, embedded)
- city <-> attractions (one-to-many)
- attraction <-> location/address (one-to-one, embedded)

There is one polymorphic association employed in this app. A Location can be embedded in City or Attraction, which are defined as :place.

HW2 -- sl3357 -- Shou-pon Lin

The web application now includes authentication mechanism. User new to the application may create account with password. The user may login with an account previously created in the database and with correct password. After logged in, a list of created login will be presented with password hashed and salted.

HW1 -- sl3357 -- Shou-pon Lin

Tentative project outline:

The web application (name TBD) tailored for travel experience

During travel there may be photos, videos, or notes taken along the way. I wish these materials could somehow be managed, not by the online photo service such as Picasa or Flickr. It should be more like a personal blog augmented by GoogleMap, and one can use it for reconstrusting the travel experience. 

The following features should be included:
- Photo/Video/Note storage
- The material could be sorted/presented according to the date taken or their locations
- Several ways to present the materials: on a map, in a list, etc..
- Reconstruction of itineraries based on the location and date information

Note: 
The project may subject to change if some features are not appropriate for a web application

== Placeholders

* Ruby version
2.1.0
* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.

---

Naming idea: {traveLOG}[http://www.merriam-webster.com/dictionary/travelogue] (ps. it might be taken though...)
