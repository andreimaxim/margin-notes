# Margin Notes

A small Rails JSON application backed by PostgreSQL.

Requires Ruby 3.2.9 and PostgreSQL. Install the locked bundle, then prepare the
local database:

```sh
bundle install
bin/rails db:prepare
bin/rails server
```

The application starts from Rails 7.0 with its original framework defaults.
Development uses `margin_notes_development` and a PostgreSQL role matching the
local user. This is local development configuration, not a production deployment
setup.
