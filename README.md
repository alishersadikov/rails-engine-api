# README

This project is a custom built JSON Rails Engine API to expose a SalesEngine data schema.


###To run this project locally:

```
git clone https://github.com/alishersadikov/rails-engine-api.git
cd rails-engine-api
bundle
rake db:create db:migrate
rake import_from_csv:import_all
To run tests: rspec
```



###To run the spec harness:
```
git clone https://github.com/turingschool/rales_engine_spec_harness.git
cd rales_engine_spec_harness
bundle
rake
```


This app is written in Rails v5.0.0.1, and uses Rspec for testing with SimpleCov.

Link to original assignment: (http://backend.turing.io/module3/projects/rails_engine)
Link to the spec harness: (https://github.com/turingschool/rales_engine_spec_harness)
