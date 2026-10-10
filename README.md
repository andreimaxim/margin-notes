# Margin Notes

A small Rails JSON notebook backed by PostgreSQL. Notes have draft/published status,
an archive flag, and JSON metadata. Listings use Jbuilder; exports use inline jobs,
Redis caching, and a Live/SSE endpoint.

Requires Ruby 3.2.9, PostgreSQL, and Redis. In an Orb, run `.agents/setup`.
For another development environment, start both services and then run:

```sh
mise trust mise.toml
mise install
eval "$(mise activate bash --shims)"
bundle install
bin/rails db:prepare
bin/rails server
```

The application starts from Rails 7.0 with its original framework defaults.
Development uses `margin_notes_development` and a peer-authenticated PostgreSQL
role matching the local user. Override `PGHOST`, `PGUSER`, and `REDIS_URL` for
other service locations. This is local development configuration, not a
production deployment setup. Tests use `margin_notes_test` and Minitest.

The JSON API supports `GET /notes.json`, `POST /notes` with `note[title]`, and
`GET /notes/:id`. Creation redirects to the new note. `GET /health` returns the
application status, while `GET /stream` emits the current note count.
Export preferences and a compose-form fragment are available at
`GET /export-preferences` and `GET /compose`. `GET /legacy-export` serves the
older client format and emits a deprecation warning.
