# HP Code Evaluation

## Up and running:

1. Install ruby version [3.0.3](https://www.youtube.com/watch?v=WE5kOjMEQqc) with your manager of choice
2. `bundle` it
2. `yarn install` 
2. `bin/webpack-dev-server`
3. `bin/rails db:migrate && bin/rails db:seed`
3. `bin/rails s` and browse to [localhost:3000](http://localhost:3000)

## Caveats

I had a bit of hassle getting js to build. Here is the relevant output of `asdf current`

``` sh
nodejs         16.13.0
ruby           3.0.3
yarn           1.22.17
```


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
