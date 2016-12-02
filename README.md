# README

This project is a custom built JSON Rails Engine API to expose a SalesEngine data schema.


###To run this project locally:

```
git clone alishersadikov/rails-engine-api
bundle
rake db:create db:migrate
rake import_from_csv:import_all
```

This app is written in Rails v5.0.0.1, and uses Rspec for testing with SimpleCov.
