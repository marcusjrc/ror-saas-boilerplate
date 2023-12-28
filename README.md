# SaaS Boilerplate - Ruby on Rails

This is a wip project for creating a SaaS boilerplate/template application using Ruby on Rails.
## Demo
saas.marcusrc.com

## Features
1. User Login, Registration & Forgot Password functionality (via Devise gem)
1. Stripe integration for basic monthly subscription tiers. Webhooks are supported. Uses Stripe customer portal for user subscription management
1. Basic ticket system & help chat system (websocket supported)
1. Notification system (websocket supported)

## To do..
1. Add SSO (via Devise)
1. Setup basic admin functionality (subscription, ticketing)
1. Setup basic isolated "apps" to share between users/teams
1. Configuration for boilerplate gen / feature toggle


## Local setup

1. You will need Ruby 3+ and Docker installed
1. After cloning the repo, run `bundle install` inside the root folder to install the dependencies.
1. Next, run `docker-compose up` in the root folder to setup your local & test postgres dbs and redis.
1. Before migrating & seeding your database, you need to setup a Stripe account and obtain a test API key from the developers portal. Then set your env var, look at `config/initializers/stripe.rb`` for more
1. You will need to migrate & seed your database using `rails db:setup`



