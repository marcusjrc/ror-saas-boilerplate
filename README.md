# SaaS Boilerplate - Ruby on Rails

This is a wip project for creating a SaaS boilerplate/template application using Ruby on Rails.

Currently uses these gems: Tailwindcss, Devise, Rspec, standardrb, stripe

## Features
1. User Login, Registration & Forgot Password functionality (via Devise gem)
1. Stripe integration for basic monthly subscription tiers. Webhooks are supported. Uses Stripe customer portal for user subscription management
1. Basic ticket system & help chat system (websocket supported via Turbo Streams)
1. Notification system (websocket supported via Turbo streams)

## Testing and Linting
1. For linting, standardrb is used, use `standardrb` to run
1. RSpec is to be used for testing going forward, using `bundle exec rspec`. TODO: Controller tests to be migrated to rspec controller & feature tests - along with factories (using Factory Bot) instead of fixtures.

## To do..
1. Set up feature testing using Rspec
1. Add SSO (via Devise)
1. Setup basic admin functionality (subscription, ticketing)
1. Setup basic isolated "apps" to share between users/teams
1. Feature toggling


## Local setup

1. You will need Ruby 3+ and Docker installed
1. After cloning the repo, run `bundle install` inside the root folder to install the dependencies.
1. Next, run `docker-compose up` in the root folder to setup your local & test postgres dbs and redis.
1. Before migrating & seeding your database, you need to setup a Stripe account and obtain a test API key from the developers portal. Then set your env var, look at `config/initializers/stripe.rb`` for more info.
1. You will need to migrate & seed your database using `rails db:setup`
1. Now run using `./bin/dev`



