# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.0.0
* Rails Version 7.1

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

Steps to test App

1. After taking clone of repo run `bundle Install`
2. Change config in database.yml according to you local configs.
3. Then run `rails db:create` to create database.
4. Then run `rails db:migrate` to run migrations.
5. Run `rails s` to start server.
6. Run `bundle exec sidekiq` to start sidekiq server and background job.I have not added Demon mode right now
   so job will only run while server is running.
7. Hit Url `http://localhost:3000/users` to view on web.

Steps for testing JOB manually

1. Run `bundle exec sidekiq` to run sidekiq server.
2. Open rails console `rails c`
3. You can test the hourly job by running `HourlyJob.perform_async`
4. You can test the Nighty job by running NightyJob.perform_async

Steps for testing
1. Run `bundle exec rspec`.
