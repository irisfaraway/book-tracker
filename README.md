# book-tracker

Tracking what books I've read, when I read them and how much I liked them.

This is up and running at [iris-book-tracker.herokuapp.com](http://iris-book-tracker.herokuapp.com/)

You can sign up and track books too. Authentication is through Facebook. You can fill in book data manually or search Google Books.

## Backlog

I keep a (fairly messy) [backlog on Trello](https://trello.com/b/ckL0n133/book-tracker).

## Setup

This uses Ruby 2.3.0 and Rails 4.2.6.

Database is PostgreSQL for Heroku reasons.

1. Clone it
2. `bundle install`
3. `rake db:reset`
4. `rails s`
5. Go to http://localhost:3000