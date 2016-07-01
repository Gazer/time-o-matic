Time-o-Matic
============

Little Rails & AngularJS app to track time!

More info about the building process and how to write tests for this kind of app can be found on http://angular-rails.com/

[![Build Status](https://travis-ci.org/Gazer/time-o-matic.svg?branch=master)](https://travis-ci.org/Gazer/time-o-matic)

Dependencies
============

Tested with :

* Ruby version : 2.2
* Bower version : 1.7.9
* NodeJS version : 5.8.0

Try it!
=======

Install Rails
-------------

Check rbenv or ask for help if you're not familiar with Ruby on Rails apps :).

Install Ruby 2.2 and Rubygems. After that just install bundler :

```
$> gem install bundler
```

And after that all the app dependencies :

```
$> bundle install
```

Configure the database
----------------------

Just edit the `config/database.yml` and set the correct values for your database.

Then just :

```
$> rake db:create
$> rake db:migrate
```

Run the app!
------------

All the angujar dependencies are already bundle in the app, so you just need to run the app ;)

```
$> rails server
=> Booting WEBrick
=> Rails 4.2.6 application starting in development on http://localhost:3000
=> Run `rails server -h` for more startup options
=> Ctrl-C to shutdown server
[2016-06-02 20:58:16] INFO  WEBrick 1.3.1
[2016-06-02 20:58:16] INFO  ruby 2.2.4 (2015-12-16) [x86_64-darwin15]
[2016-06-02 20:58:16] INFO  WEBrick::HTTPServer#start: pid=22129 port=3000
```

Open `http://localhost:3000` on your browser and start tracking!

Bonus: Run using Docker!
========================

Install docker and docker-compose. If you on Mac or Windows you also need to install docker-machine.

Then, just be awesome :) :

```
$> docker-compose build
$> docker-compose run web rake db:create db:setup
$> docker-compose up
```

Keep in mind that the app uses the code of your local machine!, so you can change the code and test without restarting docker!.

After that you need to go http://docker_ip:3000/ and star tracking!. Note that if you are using docker-machine the docker_ip is not 127.0.0.1!

Need the console? :

```
$> docker-compose run web rails console
```

Want to learn more? Just check https://robots.thoughtbot.com/rails-on-docker
