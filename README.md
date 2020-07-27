# PowerUp Gym

This project was my end-of-module assignment when I was finishing the Ruby section of my Software Development course at CodeClan. The task was to create software that manages the members, classes and bookings of a gym. The minimum viable product included enabling the user to create and edit members, create and delete classes, view a list of classes, assign a member to a class and view members attending each class. Recommended extra features were adding a maximum capacity for classes and preventing overbooking, as well as assigning premium membership to members, times to classes and allowing only premium members to peak-hour classes. On top of that, I also added deleting members, editing classes, listing, editing and deleting bookings, as well as conditional showing of buttons. The project was meant to demonstrate understanding of the model-view-controller design pattern, CRUD functionality and RESTful routes. It was written in Ruby, using the Sinatra library for the controllers, embedded Ruby to add logic to the HTML views, and the PG Ruby gem to connect the models to the PostgreSQL database.

## Prerequisites

* [Ruby](https://www.ruby-lang.org/en/downloads/), including Ruby gems: PG, Sinatra (plus extension 'sinatra/contrib/all')
* [PostgreSQL](https://www.postgresql.org/download/)

## How To Run

* Start the PostgreSQL service:

```
$ sudo service postgresql start
```

* Create the gym database:

```
$ createdb powerup
```

* (From the main folder of the project) Populate the database with the gym tables:

```
$ psql -d powerup -f db/gym.sql
```

* Start the app:

```
$ ruby app.rb
```

* (Optional) Check from the terminal that the database is persisting:

```
$ psql powerup
```

## Author

* **[Stan Tarnev](https://github.com/StanTarnev)**
